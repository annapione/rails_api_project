require 'open-uri'
require 'json'

class ForecastsController < ApplicationController
  def location
    @location=params[:address].gsub("+"," ")
    location=params[:address]
    url_of_data_we_want="https://maps.googleapis.com/maps/api/geocode/json?address=#{location}"
    raw_data=open(url_of_data_we_want).read
    parsed_data=JSON.parse(raw_data)
    the_latitude=parsed_data["results"][0]["geometry"]["location"]["lat"]
    the_longitude=parsed_data["results"][0]["geometry"]["location"]["lng"]

    url="https://api.forecast.io/forecast/16484c55617f48d0737167846e12fcc5/#{the_latitude},#{the_longitude}"
    raw_data=open(url).read
    parsed_data=JSON.parse(raw_data)
    @the_temperature=parsed_data["currently"]["temperature"]
    @the_hour_outlook=parsed_data["minutely"]["summary"]
    @the_day_outlook=parsed_data["hourly"]["summary"]
    @the_latitude=the_latitude
    @the_longitude=the_longitude
    @decoded_location=URI.decode(location)


  end
end
