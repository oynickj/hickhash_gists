require 'sinatra'
require 'sinatra/reloader'
#require_relative 'gist_curl'
require 'httparty'
require 'pry'

def reformat_time (gist_time)
  gist_time.slice!(-1)
  gist_time.slice!(-3)
  gist_time.slice!(-5)
  gist_time.slice!(4)
  gist_time.slice!(6)
  gist_time.to_i
end

def get_gist_id_hash
  cohorts = ['coopermayne','phlco','quackhouse']
  big_hash = {}
  cohorts.each do |cohort|
    response = HTTParty.get("https://api.github.com/users/#{cohort}/gists")
    response.each do |gist|
      formatted_time = reformat_time( gist["updated_at"] )
      big_hash[gist["id"]] = formatted_time
    end
  end
  sorted_array = big_hash.sort_by {|id, updated_at| updated_at}
  sorted_array.map{ |couple| couple.delete_at(1) }.flatten
  sorted_array.reverse.flatten!
end

get '/' do
  @all_gists = get_gist_id_hash
  erb :index
end
