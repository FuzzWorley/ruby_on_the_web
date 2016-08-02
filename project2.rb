require 'rack'
require 'httparty'
require 'json'
require 'pp'

class RackApp
  def self.call(env)
    request = Rack::Request.new(env)
    path = request.path

    # inspect the env element
    if path == '/inspectenv'
      return [200, {}, ["#{pp env.to_json}"]]
    end

    # a post request like: `curl -d "fake_data=foo" localhost:8080`
    # should return 405 method not allowed
    if request.post? # Rack method, does same as: `if env["REQUEST_METHOD"] == "POST"`
      return [405, {"Allow" => "GET, HEAD"}, ["This site does not allow post requests!\n"]]
    end

    # a delete request like: `curl -X DELETE localhost:8080`
    # should return 200 with text that the database has been destroyed.
    if request.delete? # Rack method, does same as: `if env["REQUEST_METHOD"] == "DELETE"`
      return [200, {}, ["You made a delete request! Well, there's nothing here to delete. ¯\\_(ツ)_/¯\n"]]
    end

    # homepage visiting `/` should return a welcome message
    if path == '/'
      return [200, {}, ["Welcome to your Rack App home page!\n"]]
    end

    # Show a random number if the user visits the site in the browser and instruct them to make a curl
    # statement guessing the next random number 1 - 5
    # The curl should look like: `curl "localhost:8080/randomnumber?5"`
    if path == '/randomnumber'
      number = 1 + rand(5)
      if request.query_string != ""
        if request.query_string.to_i == number
          return [200, {}, ["You guessed the random number!\n"]]
        else
          return [200, {}, ["Try again!\n"]]
        end
      end
      return [200, {}, ["Here's a random number: #{number}\nTry guessing the next random number 1-5 using the query string of a GET request.\n"]]
    end

    #display the current bitcoin price from the coindesk API
    if path == '/btcprice'
      #api doc: http://www.coindesk.com/api/
      price_object = JSON.parse(HTTParty.get("https://api.coindesk.com/v1/bpi/currentprice.json"))
      date_time = price_object["time"]["updated"]
      usd_rate = price_object["bpi"]["USD"]["rate"]
      if date_time && usd_rate
        return [200, {}, ["#{date_time}: \n USD: $#{usd_rate}"]]
      else
        return [404, {}, ["Data could not be retrieved."]]
      end
    end

    # simulate a permanent path change with a 301 redirect.
    # when a user visits `/spacepeople` the user should be redirected to `/peopleinspace`
    if path == '/spacepeople'
      return [301, {'Location' => '/peopleinspace' }, ["Moved Permanently\n"]]
    end

    # return data from an API
    # when a user visits `/peopleinspace` they should see a list of organized data from the api
    if path == '/peopleinspace'
      space_object = HTTParty.get("http://api.open-notify.org/astros.json")
      number = space_object["number"]
      people = space_object["people"]
      people_string = ""
      if people && number
        people.each do |person|
           people_string << "Name: #{person["name"]}, Craft: #{person["craft"]}\n"
        end
        return [200, {}, ["Number of People currently in Space: #{number}\n\n#{people_string}"]]
      else
        return [200, {}, ["Error, API is probably down or has changed."]]
      end
    end

    # extract useragent information from the `env` variable
    # visiting `/useragent` should return the appropriate information.
    if path == '/useragent'
      if env['HTTP_USER_AGENT'].include?("Macintosh")
        return [200, {}, ["Hi there Mac browser!\n"]]
      elsif env['HTTP_USER_AGENT'].include?("Windows")
        return [200, {}, ["Hi there Windows browser!\n"]]
      else
        return [200, {}, ["#{env['HTTP_USER_AGENT']}\n"]]
      end
    end

    [404, {}, ["URI not found.\n"]]

  end
end

Rack::Handler::WEBrick.run RackApp#, :Port => 8787 uncomment if you want to teach different ports.

# http://hawkins.io/2012/07/rack_from_the_beginning/



