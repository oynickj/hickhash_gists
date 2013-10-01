require 'rubygems'
require 'bundler/setup'


require 'sinatra'
#require 'sinatra/reloader'

#require_relative 'gist_curl'
require 'httparty'
#require 'pry'

def reformat_time (gist_time)
  gist_time.slice!(-1)
  gist_time.slice!(-3)
  gist_time.slice!(-5)
  gist_time.slice!(4)
  gist_time.slice!(6)
  gist_time.to_i
end

def get_gist_info
  cohorts = ['coopermayne','phlco','quackhouse']
  big_array = []
  #compile all gists with updated_at time....
  cohorts.each do |cohort|
    response = HTTParty.get("https://api.github.com/users/#{cohort}/gists")
    response.each do |gist|
      formatted_time = reformat_time( gist["updated_at"] )
      small_array = []
      small_array << cohort << gist["id"] << formatted_time
      big_array << small_array
    end
  end

  #sort by time
  sorted_array = big_array.sort_by {|nested| nested[2]}.reverse!
  ans = sorted_array.slice(0,5)
end

get '/' do
  @all_gists = get_gist_info
  erb :index
end
