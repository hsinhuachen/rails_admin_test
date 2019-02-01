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

    tag_select :tag_items
    # active_storage_field :avatar

    # file_field :thumb
    form_group :thumb, help: "Upload a file less than 2MB." do
      concat image_tag(project.thumb.url) if project.thumb
      # check_box :remove_image
      raw_file_field :thumb
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

  controller do
    # def create
    #   post_params = params["project"]
    #   project = Project.new(post_params[:id])
    #   project.tag_list = post_params[:tag_items]

    #   self.instance = admin.build_instance(admin.permitted_params(params), params)

    #   if admin.save_instance(instance, params)
    #     respond_to do |format|
    #       format.html do
    #         flash[:message] = flash_message("create.success", title: "Success!", message: "The %{lowercase_model_name} was successfully created.")
    #         redirect_to_return_location(:create, instance, default: admin.instance_path(instance))
    #       end
    #       format.json { render json: instance, status: :created, location: admin.instance_path(instance) }
    #       format.js
    #     end
    #   else
    #     respond_to do |format|
    #       format.html do
    #         flash.now[:error] = flash_message("create.failure", title: "Warning!", message: "Please correct the errors below.")
    #         render "new", status: :unprocessable_entity
    #       end
    #       format.json { render json: instance.errors, status: :unprocessable_entity }
    #       format.js
    #     end
    #   end
    # end

    def update
      project = admin.find_instance(params)
      post_params = params["project"]
      project.tag_list = post_params[:tag_items]
      # project.tag_list = "66, 88"

      # lib/trestle/resource/controller.rb
      admin.update_instance(instance, admin.permitted_params(params), params)

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

      # aa = params["project"][:tag_items]
      # logger.debug "params tag_list 3 = #{aa}"
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
  params do |params|
    params.require(:project).permit(:title,:desc, :title_en, :desc_en,:tag_list, :thumb)
    # params.require(:project).permit(:title, :desc, { tag_items: [] } )
  end
end
