require 'opal'
require "pry"
require "coffee-script"

desc "Build"
task :build do
  File.open("assets/javascripts/the_game.js", "w+") do |out|
    env = Opal::Environment.new
    env.append_path "lib"
    out << env["the_game"].to_s
  end
end

desc "build coffee"
task :build_coffee do
  # binding.pry

  # binding.pry

  File.open("assets/javascripts/index.js", "w+") do |out|
    out << CoffeeScript.compile(File.read("assets/javascripts/index.js.coffee"))
  end
  #   Dir["lib/**/*.rb"].each do |path|
  #     code = File.open(path).read
  #     out << Opal.compile(code)
  #   end
  # end

  # env = Opal::Environment.new
  # env.append_path "lib"
  # # # env.use_gem "require_all"

  # # # binding.pry




  #   out << env["the_game"].to_s
  # end
end

# Opal.compile(File.open("lib/the_game.rb").read)
