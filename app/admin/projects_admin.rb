Trestle.resource(:projects) do
  # active_storage_fields do
  #   [:avatar]
  # end

  menu do
    item :projects, icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
      column :id
      column :title
      column :desc
      column :tag_list
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
    form_group :thumb, help: "Upload a file less than 2MB." do
      concat image_tag(project.thumb.url(:s)) if project.thumb.url
      # check_box :remove_image
      raw_file_field :thumb
    end


    form_group :gallery, help: "Upload a file less than 2MB." do
      project.gallery.map do |img|
        concat image_tag(img.url(:small)) if img
      end
      # check_box :remove_image
      raw_file_field :gallery, :multiple => true, label: "Gallery"
    end

    # text_area  :desc
    # select     :feature, ["yes","no"]
    # form_group :feature, label: "Radio Buttons Form Group" do
    #   radio_button :feature, "Red"
    #   radio_button :feature, "Green"
    #   radio_button :feature, "Blue"
    #   radio_button :feature, nil, label: "No Color"
    # end

    row do
      col(xs: 6) { datetime_field :updated_at }
      col(xs: 6) { datetime_field :created_at }
    end
  end

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
