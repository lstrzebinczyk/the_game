# $:.unshift File.dirname(__FILE__)

require 'opal'

# Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each do |file|
#   require File.basename(file, File.extname(file))
# end

# require "pry"
# binding.pry


# generates the following
# except = ["the_game", "logger", "the_game/window"]
# Dir["lib/**/*.rb"].each do |file|
#   file_to_require = file.gsub("lib/", "").gsub(".rb", "")
#   unless except.include?(file_to_require)
#     puts "require '#{file_to_require}'"
#   end
# end

require 'support/countdown'
require 'the_game/map'
require 'the_game/construction/stash'
require 'the_game/construction/dormitory'
require 'the_game/construction/fireplace'
require 'the_game/construction/fallen_tree'
require 'the_game/person/woodcutter'
require 'the_game/person/gatherer'
require 'the_game/person/fisherman'
require 'the_game/person/leader'
require 'the_game/item/axe'
require 'the_game/item/fish'
require 'the_game/item/cooked_fish'
require 'the_game/item/fishing_rod'
require 'the_game/item/firewood'
require 'the_game/item/berries'
require 'the_game/item/log'
require 'the_game/map/generator'
require 'the_game/map/tile'
require 'the_game/action'
require 'the_game/item'
require 'the_game/person'
require 'the_game/has_position'
require 'the_game/action/check_fireplace'
require 'the_game/action/drink_from_river'
require 'the_game/action/go_fishing'
require 'the_game/action/wonder_for_no_reason'
require 'the_game/action/sleep'
require 'the_game/action/look_for_something_to_drink'
require 'the_game/action/catch_fish'
require 'the_game/action/carry'
require 'the_game/action/go_to'
require 'the_game/action/look_for_tree_to_cut'
require 'the_game/action/plan_dormitory_building'
require 'the_game/action/eat'
require 'the_game/action/cook'
require 'the_game/action/fetch_food'
require 'the_game/action/look_for_place_to_sleep'
require 'the_game/action/look_for_food_to_harvest'
require 'the_game/action/look_for_food'
require 'the_game/action/supply'
require 'the_game/action/cut_tree'
require 'the_game/action/construction'
require 'the_game/action/get'
require 'the_game/action/harvest'
require 'the_game/action/cut_log_into_firewood'
require 'the_game/action/move_content'
require 'the_game/nature/tree'
require 'the_game/nature/tree/piece'
require 'the_game/nature/berries_bush'
require 'the_game/engine'
require 'the_game/settlement'
require 'the_game/construction'
require 'the_game/container'

class TheGame
end
