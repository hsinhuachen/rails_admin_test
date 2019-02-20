class Gallery < ApplicationRecord
	mount_uploader :name, NameUploader
	# serialize :name
	belongs_to :project
end
