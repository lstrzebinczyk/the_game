(function() {
  this.render_people_stats = function() {
    var action_description, element, energy, hunger, person, template, thirst, type, _i, _len, _ref, _results;
    element = $("#people");
    element.empty();
    _ref = this.engine.$people();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      person = _ref[_i];
      type = person.$type();
      thirst = person.$thirst();
      hunger = person.$hunger();
      energy = person.$energy();
      action_description = person.$action().$description();
      template = "<div>\n  <div>type: " + type + "</div>\n  <div>thirst: " + thirst + "</div>\n  <div>hunger: " + hunger + "</div>\n  <div>energy: " + energy + "</div>\n  <div>action_description: " + action_description + "</div>\n  <br>\n</div>";
      _results.push(element.append(template));
    }
    return _results;
  };

  this.engine = Opal.TheGame.Engine.$new();

  $("#start").click(function() {
    return this.engine = Opal.TheGame.Engine.$new();
  });

  $("#progress").click(function() {
    engine.$update();
    return render_people_stats();
  });

  render_people_stats();

}).call(this);
