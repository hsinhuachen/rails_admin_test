class Project < ApplicationRecord
	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	has_many :gallerys, dependent: :destroy
	accepts_nested_attributes_for :gallerys
	# has_one_attached :avatar
	mount_uploader :thumb, AvatarUploader
	# mount_uploaders :gallery, GalleryUploader
	# serialize :gallerys


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

	def checksorting
		if !self.sorting
			Project.maximum("sorting") + 10
		else
			self.sorting
		end
	end

	def latest
		# get maximun sorting
		Project.maximum("sorting") + 10
	end

	def featured
		self.feature
	end

	def published
		self.status
	end

 # 	def gallery_list
	#     gallerys.map(&:id).join(', ')
	# end

	# def gallery_items
	# 	gallerys.map(&:name)
	# end

	# def gallery_list=(ids)
	# 	array_id = ids.split(', ')
	# 	# logger.info "array = #{array_id}"
	# 	# logger.info "-------------------"
	# 	self.gallerys = array_id.reject(&:blank?).map { |id|
	#       (id =~ /^\d+$/) ? Gallery.find(id) : Gallery.new(name: id)
	#     }
	# end
end
