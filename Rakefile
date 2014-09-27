require 'opal'
require "pry"


desc "Build"
task :build do
  # binding.pry

  File.open("the_game.js", "w+") do |out|
  #   Dir["lib/**/*.rb"].each do |path|
  #     code = File.open(path).read
  #     out << Opal.compile(code)
  #   end
  # end

  env = Opal::Environment.new
  env.append_path "lib"
  # # env.use_gem "require_all"

  # # binding.pry




    out << env["the_game"].to_s
  end
end


# Opal.compile(File.open("lib/the_game.rb").read)
