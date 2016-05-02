class Place < ActiveRecord::Base
	has_many :keywords 
	self.primary_key = 'geoname_id'
end
