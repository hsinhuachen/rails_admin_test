project
	title:text
	title_en:text
	desc:text
	desc_en:text
	thumb:text
	url:text
	video:string
	gallery:text
	category:string
	feature:string
	published:integer
	sorting:integer

rails generate model Project title:text title_en:text desc:text desc_en:text thumb:text url:text video:string gallery:text category:string feature:string published:integer sorting:integer

rails generate trestle:resource Project

// test --------------------
rails generate scaffold Post name:string title:string content:text

rails console 
Administrator.create(email: "**@gmal.com", password: "******", first_name: "hsinhua", last_name: "chen")


// add tag
https://www.spreered.com/rails-tagging-using-select2/

rails g model tagging tag:belongs_to project:belongs_to


------------------------------

trestle admin
carrierwave
