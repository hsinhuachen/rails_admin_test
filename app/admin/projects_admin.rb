Trestle.resource(:projects) do
  # active_storage_fields do
  #   [:avatar]
  # end

  menu do
    item :projects, icon: "fa fa-star"
  end

  scope :all, -> { Project.order("sorting desc") }, default: true
  scope :feature, -> { Project.where("feature = 1") }, label: "精選專案"
  scope :published, -> { Project.where("status = 1") }, label: "已發佈"
  scope :unpublished, -> { Project.where("status = 0") }, label: "未發佈"


  # Customize the table columns shown on the index view.
  #
  table do
      column :id
      column :title
      # column :desc
      column :tag_list, sort: false, header: "Tag"
      column :published, align: :center, link: false, header: "精選專案" do |project|
        status_tag(icon("fa fa-check"), :success) if project.featured=="1"
      end
      column :status, align: :center, link: false, header: "發佈" do |project|
        status_tag(icon("fa fa-check"), :success) if project.published==1
      end
      column :sorting, header: "前台排序", sort: false
      column :created_at, align: :center
      column :updated_at, header: "Last Updated", align: :center
      actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |project|
    tab "中文" do
      text_field :title, label: "標題", autocomplete: "off"
      editor     :desc
    end

    tab "英文" do
      text_field :title_en, label: "標題", autocomplete: "off"
      editor     :desc_en
    end

    # tag_select :tag_items
    select :tag_ids, Tag.all, { label: "category" }, { multiple: true, data: { tags: true } }
    # active_storage_field :avatar

    # file_field :thumb
    form_group :thumb, label: "作品縮圖", help: "Upload a file less than 2MB." do
      concat image_tag(project.thumb.url(:s)) if project.thumb.url
      # check_box :remove_image
      raw_file_field :thumb
    end


    form_group :gallery, help: "Upload a file less than 2MB. 可上傳多張" do
      project.gallery.map do |img|
        concat image_tag(img.url(:small)) if img
      end
      # check_box :remove_image
      raw_file_field :gallery, :multiple => true, label: "Gallery"
    end

    check_box :status, label: "發佈文章"
    check_box :feature, label: "精選文章"
    text_field :sorting, label: "排序", placeholder: 0, value: project.checksorting

    row do
      col(xs: 6) { datetime_field :updated_at }
      col(xs: 6) { datetime_field :created_at }
    end
  end

  # controller do 
    
  # end

  # routes do
  #   post :launch
  # end


  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  def product_params
    params.require(:project).permit(:title,:desc, :title_en, :desc_en, :tag_list, :thumb, :gallery => [])
    # params.require(:project).permit(:title,:desc, :title_en, :desc_en, :tag_ids, :thumb)
  end
end
