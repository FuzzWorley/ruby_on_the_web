# ruby_on_the_web
###A small Rack application for teaching web development.

The goal of this project is to create a simple application using Rack middleware that responds to simple requests made via the browser and via the command line using cURL. The application will respond with different information depending on what the path is and / or what the method is in the request. The application will also extract and manipulate data from an API and extract and use data from the headers of incoming requests.

###This project has 9 main objectives that can each be thought of as a single code block:

1. Have a very basic homepage:

   The path '/' should return a short welcome message.



2. Inspect the `env` variable:

   When a user visits `/inspectenv` in the browser, a nicely formatted JSON object of the request headers should be displayed.

3. Reject POST requests:

   A post request like: `curl -d "fake_data=foo" localhost:8080` should respond with a 405 status code, the appropriate “Allow” header, and a short message.
  

4. Respond to DELETE requests:

   A delete request like: `curl -X DELETE localhost:8080` should receive a response with a 200 status code and a short message about how there’s nothing here to delete!



5. Have a random number guessing game using query strings:

   A request to the path `/randomnumber` should generate a random number 1-5 and check if a query string is included in the request.
   
   If no query string is present, send a response with text instructing the user to guess the next random number 1 - 5 via the query string of a GET request.

   If a query string is present, check whether the query is equal to the random number and send a response letting the user know if they got it right or not.
  

6. Simulate a permanent path change with a 301 redirect:

   If a user visits `/spacepeople`, redirect them to `/peopleinspace` by responding with the appropriate status code, header, and a short message.

7. Retrieve, manipulate, and return data from an API:

   When visiting `/peopleinspace`, users should see a list of current people in space that is formatted like this fake example:

   ```
   Number of People currently in Space: 3

   Name: Yukihiro Matsumoto, Craft: RubyStation
   Name: Sandi Metz, Craft: RubyStation
   Name: André Arko, Craft: RubyStation
   ```


   Use the Open Notify API to get this data from this endpoint: "http://api.open-notify.org/astros.json"

8. Extract USERAGENT information from the `env` variable:
   Visiting `/useragent` in the browser should display:
      "Hi there Mac browser!" if the user visits on a Mac machine via the browser 
      "Hi there Windows browser!" if the user visits on a Windows machine via the browser
      Default to responding with the USERAGENT information otherwise


9. Return a 404 status code with a short message if the URL does not exist.

There are several gems you will find useful for this project:  
  *rack:    https://github.com/rack/rack  
  *httparty:          https://github.com/jnunemaker/httparty  
  *json:    https://github.com/flori/json  
  *pp:            http://ruby-doc.org/stdlib-2.0.0/libdoc/pp/rdoc/PP.html  
