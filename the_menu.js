engine = Opal.TheGame.Engine.$new()
console.log(engine)

engine.$people(function(entry) {
  console.log(entry);
});
// for person in temp1.$people(){
//   console.log person
// }

// class TheGame
//   # def setup
//   #   @engine = Engine.new
//   #   @window = Window.new(@engine)
//   # end

//   # def window
//   #   @window
//   # end

//   # def start
//   #   @window.init
//   #   begin
//   #     while true
//   #       @engine.update
//   #       @window.render
//   #       sleep(0.033)
//   #       # sleep 0.1
//   #     end
//   #   ensure
//   #     @window.close
//   #   end
//   # end

//   # def map
//   #   @engine.map
//   # end
// end
