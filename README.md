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

	Montserrat
	noto

rails generate model Project title:text title_en:text desc:text desc_en:text thumb:text url:text video:string gallery:text category:string feature:string published:integer sorting:integer

rails generate trestle:resource Project

// test --------------------
rails generate scaffold Post name:string title:string content:text

rails console 
Administrator.create(email: "kevin@oniondesign.com.tw", password: "onion9394", first_name: "hsinhua", last_name: "chen")

// /lib/trestle/form/fields.rb
autoload :DatePicker

autoload :CheckBox
autoload :CollectionCheckBoxes
autoload :CollectionRadioButtons
autoload :CollectionSelect
autoload :ColorField
autoload :DateField
autoload :DateSelect
autoload :DatetimeField
autoload :DatetimeSelect
autoload :EmailField
autoload :FileField
autoload :GroupedCollectionSelect
autoload :MonthField
autoload :NumberField
autoload :RadioButton
autoload :RangeField
autoload :SearchField
autoload :Select
autoload :StaticField
autoload :TagSelect
autoload :TelephoneField
autoload :TextArea
autoload :TextField
autoload :TimeField
autoload :TimeSelect
autoload :TimeZoneSelect
autoload :UrlField
autoload :PasswordField
autoload :WeekField


// add tag
https://www.spreered.com/rails-tagging-using-select2/

rails g model tagging tag:belongs_to project:belongs_to
