require "sinatra"

set :public_folder, 'public'

get "/" do
  File.read "index.html"
end
