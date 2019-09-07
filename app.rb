require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
# require './models/count.rb'
require 'net/http'
require 'json'

helpers do
  def giphy(keyword ,limit_number)
    url = "http://api.giphy.com/v1/gifs/search?q="+URI.encode(keyword)+"&api_key=gFEQT6dZUmUK8AvfIyE93m2fB6U1o7aV&limit="+limit_number.to_s

    resp = Net::HTTP.get_response(URI.parse(url))
    buffer = resp.body
    result = JSON.parse(buffer)

    return result["data"]
  end

  def trending(limit_number)
    url = "http://api.giphy.com/v1/gifs/trending?api_key=gFEQT6dZUmUK8AvfIyE93m2fB6U1o7aV&limit="+limit_number.to_s

    resp = Net::HTTP.get_response(URI.parse(url))
    buffer = resp.body
    result = JSON.parse(buffer)
    return result["data"]
  end
end



before do
  @url = trending(21)
  @trend = false
end

get '/' do
  @trend = true
  erb :index
end


post '/search' do
  puts params[:word]
  @word = params[:word]

  @url = giphy(params[:word] ,10000)

  if params[:sort] == "new" then
    @url = @url.sort do |a,b|
      b["import_datetime"] <=> a["import_datetime"]
    end
  end

  if params[:sort] == "popular" then
    @url = @url.sort do |a,b|
      b["trending_datetime"] <=> a["trending_datetime"]
    end
  end

  @url = @url[0,21]

  erb :index
end
