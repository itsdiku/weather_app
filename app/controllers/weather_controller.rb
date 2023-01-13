require 'uri'
class WeatherController < ApplicationController
  def index
  end

  def search
    cities = find_city(params[:city])
    unless cities
      flash[:alert] = 'City not found'
      return render action: :index
    end
    @city = cities.first
    @weather = find_weather(@city[1][0]["id"])

  end

  private

  def request_api(url)
    response = Excon.get(
      url,
      headers:{
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => '85390f2fbdmshfdadd12afb5f6b7p1b1069jsn80384aa70e0a'
      }

      )
    return nil if response.status != 200

    JSON.parse(response.body)
   
  end

  def find_city(name)
    query = URI.encode_uri_component("#{name}")
    request_api("https://foreca-weather.p.rapidapi.com/location/search/#{query}?lang=en&country=in")
  end

  def find_weather(id)
    query = URI.encode_uri_component("#{id}")
    request_api("https://foreca-weather.p.rapidapi.com/current/#{query}?alt=0&tempunit=C&windunit=KMH&tz=Europe%2FLondon&lang=en")
  end


end

