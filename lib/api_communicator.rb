require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_hash = get_json('http://www.swapi.co/api/people/')
  movie_array = []
  while response_hash["next"] != nil do
    response_hash["results"].each do |movies_in|
      if character == movies_in["name"].downcase
        movie_array = movies_in["films"]
      end
    end
    response_hash = get_json(response_hash["next"])
  end
  movie_array
  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def get_json(web)
  response_string = response_string = RestClient.get(web)
  response_hash = JSON.parse(response_string)
end

def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  if films_hash.length > 0
    for i in 0..films_hash.length-1
      response_hash = get_json(films_hash[i])
      puts "#{i+1}. #{response_hash["title"]}"
    end
  else
    puts "There is no character with that name"
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
