project
	title:text
	title_en:text
	desc:text
	desc_en:text
	thumb:text
	url:text
	video:string
	feature:boolean
	published:boolean
	sorting:integer

rails generate model Project title:text title_en:text desc:text desc_en:text thumb:text url:text video:string gallery:text feature:integer published:integer sorting:integer

rails generate trestle:resource Project

// test --------------------
rails generate scaffold Post name:string title:string content:text

rails console 
Administrator.create(email: "**@gmal.com", password: "******", first_name: "hsinhua", last_name: "chen")


// add tag
https://www.spreered.com/rails-tagging-using-select2/

rails g model tagging tag:belongs_to project:belongs_to

sudo brew install libmagickcore-dev
sudo brew install graphicsmagick-libmagick-dev-compat
sudo brew install libmagickwand-dev
sudo brew install imagemagick
gem install rmagick

gem install rmagick -v '2.16.0' --source 'https://rubygems.org/'

-----------------------------

rails g migration Project gallery:string
rails g uploader ProjectGallery
rails g uploader Name

-----------------------------

Add Gallery
rails g model gallery name:string sorting:integer project_id:integer

http://yy4ever.logdown.com/posts/1069287

-----------------------------

trestle admin
carrierwave
