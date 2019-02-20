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

	def checksorting
		if !self.sorting
			# get maximun sorting
			Project.maximum("sorting") + 10
		else
			self.sorting
		end
	end

	def featured
		self.feature
	end

	def published
		self.status
	end

	def gallery_items
		gallerys.map(&:name).join(', ')
	end

	def img_name(id)
		Gallery.find(id)
	end

	def delImg
	end
end
