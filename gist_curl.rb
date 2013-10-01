require 'httparty'
require 'pry'

def get_gist_id_hash
  cohorts = ['coopermayne','phlco']
  big_hash = {}
  big_array = []
  cohorts.each do |cohort|
    response = HTTParty.get("https://api.github.com/users/#{cohort}/gists")
    #binding.pry
    response.each do |gist|
      big_array << gist["id"]
      #big_hash[gist["id"]] = gist["updated_at"]
    end
  end
  big_array
end
