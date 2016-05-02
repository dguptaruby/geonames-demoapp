class HomeController < ApplicationController
	require 'rest-client'
	def home
	end

	def search
		@responseObjs = Place.includes(:keywords).where("lower(keywords.name) LIKE ?", "%#{params[:search].downcase}%").references(:keywords)
		if @responseObjs.blank?
			responseJson = RestClient.get 'http://api.geonames.org/searchJSON',  {:params => {q: params[:search], username: :demo, style: :full, maxRows: 10}}
			@responseObjs = JSON.parse(responseJson)["geonames"]
			unless @responseObjs.blank?
				@responseObjs.each do |obj|
					placeobj = Place.find_or_create_by(name: obj["name"], country_name:obj["countryName"], lat:obj["lat"], lng:obj["lng"],  population:obj["population"], geoname_id: obj["geonameId"], elevation: obj["elevation"] )
					placeobj.keywords.create(name: params[:search])
				end
			else
				@responseErr = JSON.parse(responseJson)["status"]["message"]		
			end
		end
	end
end
