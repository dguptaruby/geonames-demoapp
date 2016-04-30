class HomeController < ApplicationController
	require 'rest-client'
	def home
	end

	def search
		@responseObjs = Place.where("name LIKE ? OR country_name LIKE ?", "%#{params[:search].downcase}%","%#{params[:search].downcase}%")
		if @responseObjs.blank?
			responseJson = RestClient.get 'http://api.geonames.org/searchJSON',  {:params => {q: params[:search], username: :demo, style: :long, maxRows: 10}}
			@responseObjs = JSON.parse(responseJson)["geonames"]
			@responseObjs.each do |obj|
				Place.find_or_create_by(name: obj["name"].downcase, country_name:obj["countryName"].downcase, lat:obj["lat"], lng:obj["lng"],  population:obj["population"] )
			end
		end
	end
end
