require 'opal'
require "pry"
require "coffee-script"

desc "Build"
task :build do
  File.open("assets/javascripts/the_game.js", "w+") do |out|
    env = Opal::Environment.new
    env.append_path "lib"

    out << env["the_game"].to_s
    out << env["math"].to_s
  end
end

desc "build coffee"
task :build_coffee do
  env = Sprockets::Environment.new
  env.append_path "assets/javascripts"

  File.open("assets/javascripts/index.js", "w+") do |out|
    out << env["index.js.coffee"]
  end
end
