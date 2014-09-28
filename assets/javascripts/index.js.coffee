@render_people_stats = ->
  element = $("#people")
  element.empty()

  for person in @engine.$people()
    type   = person.$type()
    thirst = person.$thirst()
    hunger = person.$hunger()
    energy = person.$energy()
    action_description = person.$action().$description()

    template = """
    <div>
      <div>type: #{type}</div>
      <div>thirst: #{thirst}</div>
      <div>hunger: #{hunger}</div>
      <div>energy: #{energy}</div>
      <div>action_description: #{action_description}</div>
      <br>
    </div>
    """

    element.append(template)

@engine = Opal.TheGame.Engine.$new()

$("#start").click ->
  @engine = Opal.TheGame.Engine.$new()

$("#progress").click ->
  engine.$update()
  render_people_stats()

render_people_stats()




    # def render_people_stats
    #   setpos(0, map.width + 2)
    #   addstr " " * 50
    #   setpos(0, map.width + 2)
    #   addstr("Alive: #{people.size}")

    #   people.each_with_index do |person, index|
    #     setpos(2 + 6 * index, map.width + 2)
    #     addstr " " * 50
    #     setpos(2 + 6 * index, map.width + 2)
    #     addstr("Person (#{person.type}) stats:")

    #     setpos(3 + 6 * index, map.width + 2)
    #     addstr " " * 50
    #     setpos(3 + 6 * index, map.width + 2)
    #     addstr("  thirst: #{progress_bar(person.thirst)}")

    #     setpos(4 + 6 * index, map.width + 2)
    #     addstr " " * 50
    #     setpos(4 + 6 * index, map.width + 2)
    #     addstr("  hunger: #{progress_bar(person.hunger)}")

    #     setpos(5 + 6 * index, map.width + 2)
    #     addstr " " * 50
    #     setpos(5 + 6 * index, map.width + 2)
    #     addstr("  energy: #{progress_bar(person.energy)}")

    #     setpos(6 + 6 * index, map.width + 2)
    #     addstr " " * 50
    #     setpos(6 + 6 * index, map.width + 2)
    #     addstr("  action: #{person.action.description}")
    #   end
    # end

# for person in engine.people
#   console.log person

# engine.$update()

# for person in engine.people
#   console.log person

# console.log "penis"

# engine = Opal.TheGame.Engine.$new()
# console.log(engine)

# engine.$people(function(entry) {
#   console.log(entry);
# });
# for person in temp1.$people(){
#   console.log person
# }

# class TheGame
#   # def setup
#   #   @engine = Engine.new
#   #   @window = Window.new(@engine)
#   # end

#   # def window
#   #   @window
#   # end

#   # def start
#   #   @window.init
#   #   begin
#   #     while true
#   #       @engine.update
#   #       @window.render
#   #       sleep(0.033)
#   #       # sleep 0.1
#   #     end
#   #   ensure
#   #     @window.close
#   #   end
#   # end

#   # def map
#   #   @engine.map
#   # end
# end
