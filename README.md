# README

### API used to pluralize french words.

You just need to go to https://french-pluralize-api.herokuapp.com/
or https://french-pluralize-api.herokuapp.com/:word


## Exemple in Rails app

````
  require 'open-uri'

  def pluralize_name(name)
    JSON.parse(URI("https://french-pluralize-api.herokuapp.com/#{name}").read)["plural"]
  end

````
