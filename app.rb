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
end

before do
  @url = giphy("funny" ,12)
end

get '/' do

  erb :index
end


post '/search' do
  puts params[:word]

  @url = giphy(params[:word] ,9)
  erb :index
end