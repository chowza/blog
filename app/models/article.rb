class Article < ActiveRecord::Base
  	attr_accessible :text, :title
  	before_create :create_slug

  	
	def create_slug
    	self.slug = self.title.parameterize
  	end

  	def year
	  created_at.year
	end

	def month
	  created_at.strftime("%m")
	end

end
