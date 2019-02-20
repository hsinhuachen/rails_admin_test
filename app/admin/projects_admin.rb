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
  search do |query|
    if query
      Project.where("title LIKE ?", "%#{query}%")
    else
      Project.all
    end
  end

  table do
      column :thumb, header: false, class: "thumbImg" do |img|
        image_tag(img.thumb.url)
      end
      column :title, header: "標題"
      column :tag_list, sort: false, header: "分類"
      column :published, align: :center, link: false, header: "精選專案" do |project|
        status_tag(icon("fa fa-check"), :success) if project.featured=="1"
      end
      column :status, align: :center, link: false, header: "發佈" do |project|
        status_tag(icon("fa fa-check"), :success) if project.published==1
      end
      column :sorting, header: "前台排序"
      column :created_at, header: "建立時間", align: :center
      column :updated_at, header: "最後更新時間", align: :center
      actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |project|
    tab "tw", label: "中文" do
      text_field :title, label: "標題", autocomplete: "off"
      editor     :desc
    end

    tab "en", label: "英文" do
      text_field :title_en, label: "標題", autocomplete: "off"
      editor     :desc_en
    end

    tab "Gallery" do
      form_group :gallerys, label: false do
        raw_file_field :name, :multiple => true, name: "gallerys[name][]"
        concat content_tag(:p, "Upload a file less than 2MB. 可上傳多張") 

        hidden_field :delImg, name: "delImgStr"
        galleryIds = project.gallery_ids
        galleryIds.map do |id|
          img = project.img_name(id)
          row do
            col(xs: 1) { concat content_tag(:p, id, class: "imgPanel") }
            col(xs: 6) { concat content_tag(:div, image_tag(img.name.url), class: "imgPanel") if img.name }
            col(xs: 5) { concat link_to "Remove image", "#", class: "delImg", data: { id: id , confirm: "Are you sure you want to delete this image?" } }
          end   
        end

      end

      concat(content_tag(:div, content_tag(:img),class: "upload-preview"))
    end

    tab "setting", label: "基本設定" do
      # tag_select :tag_items
      select :tag_ids, Tag.all, { label: "category" }, { multiple: true, data: { tags: true } }

      form_group :thumb, label: "作品縮圖", help: "Upload a file less than 2MB." do
        concat image_tag(project.thumb.url(:s)) if project.thumb.url
        raw_file_field :thumb
      end

      row do
        col(xs: 1) { text_field :sorting, label: "排序", placeholder: 0, value: project.checksorting }
        col(xs: 11) {  }
      end

      check_box :status, label: "發佈文章"
      check_box :feature, label: "精選文章"

      # row do
      #   col(xs: 6) { datetime_field :updated_at }
      #   col(xs: 6) { datetime_field :created_at }
      # end

    end
  end

  controller do 
    def create
      self.instance = admin.build_instance(admin.permitted_params(params), params) 

      if admin.save_instance(instance, params) 

        # 新增至gallery
        if params[:gallerys] != nil
          params[:gallerys]['name'].each do |img|
            @picture = instance.gallerys.create("name" => img)
          end
        end

        #刪除gallery




        respond_to do |format|  
          format.html do  
            flash[:message] = flash_message("create.success", title: "Success!", message: "The %{lowercase_model_name} was successfully created.")  
            redirect_to_return_location(:create, instance, default: admin.instance_path(instance))  
          end 
          format.json { render json: instance, status: :created, location: admin.instance_path(instance) }  
          format.js 
        end 
      else  
        respond_to do |format|  
          format.html do  
            flash.now[:error] = flash_message("create.failure", title: "Warning!", message: "Please correct the errors below.") 
            render "new", status: :unprocessable_entity 
          end 
          format.json { render json: instance.errors, status: :unprocessable_entity } 
          format.js 
        end 
      end
    end # end create

    def update
      admin.update_instance(instance, admin.permitted_params(params), params)

      # 新增至gallery
      if params[:gallerys] != nil
        params[:gallerys]['name'].each do |img|
          @picture = instance.gallerys.create("name" => img)
        end
      end

      # 刪除gallery
      delImgStr = params["delImgStr"]
      delArray = delImgStr.split(',')

      delArray.map do |delId|
        Gallery.destroy(delId)     
      end

      if admin.save_instance(instance, params)  
        respond_to do |format|  
          format.html do  
            flash[:message] = flash_message("update.success", title: "Success!", message: "The %{lowercase_model_name} was successfully updated.")  
            redirect_to_return_location(:update, instance, default: admin.instance_path(instance))  
          end 
          format.json { render json: instance, status: :ok }  
          format.js 
        end 
      else  
        respond_to do |format|  
          format.html do  
            flash.now[:error] = flash_message("update.failure", title: "Warning!", message: "Please correct the errors below.") 
            render "show", status: :unprocessable_entity  
          end 
          format.json { render json: instance.errors, status: :unprocessable_entity } 
          format.js 
        end 
      end

    end  # end update

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
  # params do |params|  
  def project_params
    # params.require(:project).permit(:title,:desc, :title_en, :desc_en)
    params.require(:project).permit(:title,:desc, :title_en, :desc_en, :tag_ids, :thumb)
  end 
end
