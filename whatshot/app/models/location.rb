class Location < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	has_many :comments
end
