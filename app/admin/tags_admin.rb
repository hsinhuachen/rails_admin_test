Trestle.resource(:tags) do
	menu do
		item :tags, icon: "fa fa-tags"
	end

	# Customize the table columns shown on the index view.
	#
	table do
	  column :id
	  column :name
	  column :created_at, align: :center
	  column :updated_at, header: "Last Updated", align: :center
	  actions
	end
end