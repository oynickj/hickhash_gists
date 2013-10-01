require 'sinatra'
require 'sinatra/reloader'

get '/' do
  @test = "a test string"
  erb :index
end
