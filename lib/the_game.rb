# $:.unshift File.dirname(__FILE__)

require 'opal'
require 'opal-jquery'
require 'browser'

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
require 'the_game/item/water'
require 'the_game/item/waterskin'
require 'the_game/map/generator'
require 'the_game/map/tile'
require 'the_game/map/event'
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
require 'the_game/action/drink_from_waterskin'
require 'the_game/action/fill_waterskin'
require 'the_game/nature/tree'
require 'the_game/nature/berries_bush'
require 'the_game/nature/log_pile'
require 'the_game/engine'
require 'the_game/settlement'
require 'the_game/construction'
require 'the_game/container'

class TheGame
  class Menu
    def initialize(engine)
      @engine = engine
      @time_window             = Element.find("#time")
      @people_stats_window     = Element.find("#people")
      @building_stats_window   = Element.find("#buildings")
      @stash_stats_window      = Element.find("#stash")
      @turns_per_second_window = Element.find("#turns_count")

      @iterations_since_last_count_update = 0
      @time_since_last_count_update = Time.now
    end

    def update
      render_time!
      render_people_stats!
      render_building_stats!
      render_stash!
      render_turns_per_second!
    end

    def render_turns_per_second!
      @iterations_since_last_count_update += 1
      possible_new_time = Time.now
      if possible_new_time - @time_since_last_count_update > 1
        @time_since_last_count_update = possible_new_time
        @turns_per_second_window.text(@iterations_since_last_count_update)
        @iterations_since_last_count_update = 0
      end
    end

    def render_stash!
      @stash_stats_window.empty
      stash = Settlement.instance.stash
      template = "<div>"
      stash.each do |type, count|
        template += "<div>#{type}: #{count}"
      end
      template += "</div>"
      @stash_stats_window.append(template)
    end

    def render_building_stats!
      @building_stats_window.empty

      dormitory = Settlement.instance.dormitory

      unless dormitory.nil?
        template = "<div>"
        template += "<div>DORMITORY:</div>"
        template += "<div>status: #{dormitory.status}</div>"
        if dormitory.status == "plan"
          template += "<div>firewood needed: #{dormitory.firewood_needed}</div>"
        elsif dormitory.status == "building"
          template += "<div>construction left: #{dormitory.minutes_left}</div>"
        end

        @building_stats_window.append(template)
      end
    end

    def render_time!
      @time_window.text(@engine.time)
    end

    def render_people_stats!
      @people_stats_window.empty
      @engine.people.each do |person|
        type   = person.type
        thirst = person.thirst
        hunger = person.hunger
        energy = person.energy
        waterkinPercentage = person.waterskin.percentage
        action_description = person.action.description


        template = "
        <div>
          <div>type: #{type}</div>
          <div>thirst: <progress value='#{thirst}'></progress></div>
          <div>hunger: <progress value='#{hunger}'></progress></div>
          <div>energy: <progress value='#{energy}'></progress></div>

          <div>action_description: #{action_description}</div>
          <div>waterkin capacity: <progress value='#{waterkinPercentage}'></progress>
          <div>items:</div>
        "

        person.inventory.each do |type, count|
          template += "<div>#{type}: #{count}"
        end

        template += "
          <div>
          </div>
          <br>
        </div>
        "

        @people_stats_window.append(template)
      end
    end
  end

  class Window
    def setup
    end

    def render
    end

    def update
    end

    def playing=(value)
    end
  end

  class GameLoop
    def initialize
      @engine      = TheGame::Engine.new
      @menu        = TheGame::Menu.new(@engine)
      @window      = TheGame::Window.new
      @startButton = Element.find("#start")
      @playing     = true
      @turns_per_second = 30
    end

    def setup!
      @startButton.on :click do
        if @playing
          stop!
        else
          start!
        end
      end

      @window.setup

      # TODO
      # add handlers for speed buttons
    end

    def start!
      @interval = $window.every(1.0/@turns_per_second) do
        update!
      end
      @playing = true
      @window.playing = true
      @startButton.text("stop")
    end

    def stop!
      @interval.stop
      @playing = false
      @window.playing = false
      @startButton.text("Start!")
    end

    private

    def update!
      @engine.update
      @menu.update
      @window.update
      @window.render
    end
  end

  def initialize
    Document.ready? do
      @game_loop = GameLoop.new
      @game_loop.setup!
      @game_loop.start!
    end
  end
end

TheGame.new