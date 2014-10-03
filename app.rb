require "sinatra"

set :public_folder, 'public'

get "/" do
  File.read "index.html"
end

# get "/*" do
#   # p params
#   file = params["captures"].first
#   File.read file
# end


# {"splat"=>["assets/stylesheets/style.css"], "captures"=>["assets/stylesheets/style.css"]}
# {"splat"=>["assets/javascripts/the_game.js"], "captures"=>["assets/javascripts/the_game.js"]}
# {"splat"=>["vendor/jquery.js"], "captures"=>["vendor/jquery.js"]}
# 127.0.0.1 - - [03/Oct/2014 20:52:00] "GET /assets/stylesheets/style.css HTTP/1.1" 200 - 0.0015
# 127.0.0.1 - - [03/Oct/2014 20:52:00] "GET /assets/javascripts/the_game.js HTTP/1.1" 200 - 0.0009
# {"splat"=>["vendor/pixi.js"], "captures"=>["vendor/pixi.js"]}
# {"splat"=>["assets/javascripts/index.js"], "captures"=>["assets/javascripts/index.js"]}
# 1
