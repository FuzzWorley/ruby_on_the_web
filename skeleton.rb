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

    end

    # a post request like: `curl -d "fake_data=foo" localhost:8080`
    # should return 405 method not allowed
    if request.post? # Rack method, does same as: `if env["REQUEST_METHOD"] == "POST"`

    end

    # a delete request like: `curl -X DELETE localhost:8080`
    # should return 200 with text that the database has been destroyed.
    if request.delete? # Rack method, does same as: `if env["REQUEST_METHOD"] == "DELETE"`

    end

    # homepage visiting `/` should return a welcome message
    if path == '/'

    end

    # Show a random number if the user visits the site in the browser and instruct them to make a curl
    # statement guessing the next random number 1 - 5
    # The curl should look like: `curl "localhost:8080/randomnumber?5"`
    if path == '/randomnumber'

    end

    #display the current bitcoin price from the coindesk API
    #api doc: http://www.coindesk.com/api/
    if path == '/btcprice'

    end

    # simulate a permanent path change with a 301 redirect.
    # when a user visits `/spacepeople` the user should be redirected to `/peopleinspace`
    if path == '/spacepeople'

    end

    # return data from an API
    # when a user visits `/peopleinspace` they should see a list of organized data from the api
    # API availabel at "http://api.open-notify.org/astros.json"
    if path == '/peopleinspace'

    end

    # extract useragent information from the `env` variable
    # visiting `/useragent` should return the appropriate information.
    if path == '/useragent'

    end

    #respond with 404 if no routes match.

  end
end

Rack::Handler::WEBrick.run RackApp