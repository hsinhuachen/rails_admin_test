class Project < ApplicationRecord
	has_many :taggings
	has_many :tags, through: :taggings
	# has_one_attached :avatar
	mount_uploader :thumb, AvatarUploader
	mount_uploaders :gallery, GalleryUploader
	serialize :gallery, JSON

	def tag_list
	    tags.map(&:name).join(', ')
	end

	def tag_list=(names)
    	self.tags = names.reject(&:blank?).map do |item|
      		Tag.where(name: item.strip).first_or_create!
    	end
   	end

   	def tag_items
		tags.map(&:name)
	end

	def tag_ids=(ids)
	    self.tags = Array(ids).reject(&:blank?).map { |id|
	      (id =~ /^\d+$/) ? Tag.find(id) : Tag.new(name: id)
	    }
	end

	def remove_image
	end
end
