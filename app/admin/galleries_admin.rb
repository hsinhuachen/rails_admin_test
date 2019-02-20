Trestle.resource(:galleries) do
	menu do
		item :galleries, icon: "fa fa-tags"
	end

	# Customize the table columns shown on the index view.
	#
	# table do
	#   column :id
	#   column :name
	#   column :created_at, align: :center
	#   column :updated_at, header: "Last Updated", align: :center
	#   actions
	# end

	form do |photo|
		file_field :name
		text_field :sorting
		select :project_id, Project.all
  	end
end