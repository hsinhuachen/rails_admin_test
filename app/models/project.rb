class Project < ApplicationRecord
	has_many :taggings
	has_many :tags, through: :taggings
	has_one_attached :avatar

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
end
