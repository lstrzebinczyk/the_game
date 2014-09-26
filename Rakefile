require 'opal'
require "pry"


desc "Build"
task :build do
  # binding.pry

  Dir["lib/**/*.rb"].each do |path|
    code = File.open(path).read
    Opal.compile(code)
  end

  # env = Opal::Environment.new
  # env.append_path "lib"
  # # env.use_gem "require_all"

  # # binding.pry

  # File.open("the_game.js", "w+") do |out|



  #   out << env["the_game"].to_s
  # end
end


# Opal.compile(File.open("lib/the_game.rb").read)
