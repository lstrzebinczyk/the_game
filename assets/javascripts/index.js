(function() {
  var RenderingDormitory, RenderingPerson, interactive, person, renderer, row, settlement, tile, updatable, _i, _j, _k, _len, _len1, _len2, _ref, _ref1,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.render_people_stats = function() {
    var action_description, element, energy, hunger, person, progress, template, thirst, type, _i, _len, _ref, _results;
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
      progress = function(value) {
        return "<progress value='" + value + "'></progress>";
      };
      template = "<div>\n  <div>type: " + type + "</div>\n  <div>thirst: " + (progress(thirst)) + "</div>\n  <div>hunger: " + (progress(hunger)) + "</div>\n  <div>energy: " + (progress(energy)) + "</div>\n  <div>action_description: " + action_description + "</div>\n  <br>\n</div>";
      _results.push(element.append(template));
    }
    return _results;
  };

  this.render_stash_stats = function() {
    var element, stash, template, type, _i, _len, _ref;
    element = $("#stash");
    element.empty();
    stash = Opal.TheGame.Settlement.$instance().$stash();
    template = "<div>";
    _ref = stash.$item_types();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      type = _ref[_i];
      template += "<div>" + type + ": " + (stash.$count(type));
    }
    template += "</div>";
    return element.append(template);
  };

  this.render_buildings_stats = function() {
    var dormitory, element, template;
    element = $("#buildings");
    element.empty();
    dormitory = Opal.TheGame.Settlement.$instance().$dormitory();
    if (!dormitory["$nil?"]()) {
      template = "<div>";
      template += "<div>DORMITORY:</div>";
      template += "<div>status: " + (dormitory.$status()) + "</div>";
      if (dormitory.$status() === "plan") {
        template += "<div>firewood needed: " + (dormitory.$firewood_needed()) + "</div>";
      }
      if (dormitory.$status() === "building") {
        template += "<div>construction left: " + (dormitory.$minutes_left()) + "</div>";
      }
      return element.append(template);
    }
  };

  this.engine = Opal.TheGame.Engine.$new();

  $("#start").click((function(_this) {
    return function() {
      if (playing) {
        clearInterval(gameLoop);
        _this.playing = false;
        return $("#start").text("Start!");
      } else {
        _this.gameLoop = setInterval(updateWorld, 1000 / 30);
        _this.playing = true;
        return $("#start").text("Stop!");
      }
    };
  })(this));

  render_people_stats();

  this.now = new Date;

  this.iterations = 0;

  this.render_turns_per_second = (function(_this) {
    return function() {
      var new_now;
      _this.iterations += 1;
      new_now = new Date();
      if (new_now - _this.now > 1000) {
        _this.now = new_now;
        $("#turns_count").text(_this.iterations);
        return _this.iterations = 0;
      }
    };
  })(this);

  this.render_time = function() {
    var time;
    time = engine.$time().$strftime("%T");
    return $("#time").text(time);
  };

  this.updateWorld = function() {
    engine.$update();
    render_people_stats();
    render_turns_per_second();
    render_stash_stats();
    render_time();
    render_buildings_stats();
    updateRenderObjects();
    return renderer.render(stage);
  };

  this.gameLoop = setInterval(updateWorld, 1000 / 30);

  this.playing = true;

  interactive = true;

  this.stage = new PIXI.Stage('000', interactive);

  this.x_offset = 0;

  this.y_offset = 0;

  this.change_offset = false;

  this.width = engine.map.$width();

  this.height = engine.map.$height();

  this.renderedWidth = 14 * 4;

  this.renderedHeight = 14 * 3;

  this.tileSize = 16;

  this.maxXOffset = (this.renderedWidth - this.width) * this.tileSize;

  this.maxYOffset = (this.renderedHeight - this.height) * this.tileSize;

  stage.mousemove = (function(_this) {
    return function(data) {
      var x, y;
      if (_this.change_offset) {
        x = data.originalEvent.movementX;
        y = data.originalEvent.movementY;
        _this.x_offset += x;
        _this.y_offset += y;
        if (_this.x_offset > 0) {
          _this.x_offset = 0;
        }
        if (_this.y_offset > 0) {
          _this.y_offset = 0;
        }
        if (_this.x_offset < _this.maxXOffset) {
          _this.x_offset = _this.maxXOffset;
        }
        if (_this.y_offset < _this.maxYOffset) {
          _this.y_offset = _this.maxYOffset;
        }
      }
      if (!_this.playing) {
        updateRenderObjects();
        return renderer.render(stage);
      }
    };
  })(this);

  stage.mouseup = (function(_this) {
    return function() {
      return _this.change_offset = false;
    };
  })(this);

  stage.mouseupoutside = (function(_this) {
    return function() {
      return _this.change_offset = false;
    };
  })(this);

  stage.mousedown = (function(_this) {
    return function() {
      return _this.change_offset = true;
    };
  })(this);

  renderer = PIXI.autoDetectRenderer(renderedWidth * tileSize, renderedHeight * tileSize);

  $("#view").append(renderer.view);

  updatable = [];

  this.Renderable = (function() {
    function Renderable(object) {
      this.object = object;
      this.updateContentPosition = __bind(this.updateContentPosition, this);
      this.removeContent = __bind(this.removeContent, this);
      this.isWithinView = __bind(this.isWithinView, this);
      this.update = __bind(this.update, this);
      this.createContent();
      this.renderedWidth = renderedWidth;
      this.renderedHeight = renderedHeight;
      stage.addChild(this.content);
      updatable.push(this);
    }

    Renderable.prototype.update = function() {
      if (this.isWithinView()) {
        if (this.content) {
          this.updateSelf();
          return this.updateContentPosition();
        } else {
          this.createContent();
          stage.addChild(this.content);
          return this.updateContentPosition();
        }
      } else {
        if (this.content) {
          return this.removeContent();
        }
      }
    };

    Renderable.prototype.updateSelf = function() {};

    Renderable.prototype.isWithinView = function() {
      return this.object.$y() * tileSize >= -window.x_offset && this.object.$y() * tileSize < -window.x_offset + this.renderedWidth * tileSize && this.object.$x() * tileSize >= -window.y_offset && this.object.$x() * tileSize < -window.y_offset + this.renderedHeight * tileSize;
    };

    Renderable.prototype.removeContent = function() {
      stage.removeChild(this.content);
      return this.content = null;
    };

    Renderable.prototype.updateContentPosition = function() {
      this.content.position.x = this.object.$y() * tileSize + window.x_offset;
      return this.content.position.y = this.object.$x() * tileSize + window.y_offset;
    };

    return Renderable;

  })();

  this.RenderingTile = (function(_super) {
    __extends(RenderingTile, _super);

    function RenderingTile() {
      this.setData = __bind(this.setData, this);
      this.updateSelf = __bind(this.updateSelf, this);
      this.createContent = __bind(this.createContent, this);
      return RenderingTile.__super__.constructor.apply(this, arguments);
    }

    RenderingTile.prototype.createContent = function() {
      this.setData();
      this.content = new PIXI.Text(this.contentString, {
        font: "25px",
        fill: this.contentColor
      });
      return this.updateContentPosition();
    };

    RenderingTile.prototype.updateSelf = function() {
      if (!this.object["$updated?"]()) {
        this.removeContent();
        this.createContent();
        stage.addChild(this.content);
        return this.object["$updated!"]();
      }
    };

    RenderingTile.prototype.setData = function() {
      if (this.object["$marked_for_cleaning?"]()) {
        if (this.object.$content().constructor.name === "$Tree") {
          this.contentString = "t";
          return this.contentColor = "red";
        } else if (this.object.$content().constructor.name === "$FallenTree") {
          this.contentString = "/";
          return this.contentColor = "red";
        } else if (this.object.$content().constructor.name === "$BerriesBush") {
          this.contentString = "#";
          return this.contentColor = "red";
        }
      } else {
        if (this.object.$content().constructor.name === "$Tree") {
          this.contentString = "t";
          return this.contentColor = "green";
        } else if (this.object.$content().constructor.name === "$FallenTree") {
          this.contentString = "/";
          return this.contentColor = "green";
        } else if (this.object.$content().constructor.name === "$BerriesBush") {
          this.contentString = "#";
          return this.contentColor = "yellow";
        } else if (this.object.$terrain() === "river") {
          this.contentString = "~";
          return this.contentColor = "blue";
        } else {
          this.contentString = ".";
          return this.contentColor = "white";
        }
      }
    };

    return RenderingTile;

  })(Renderable);

  _ref = engine.$map().$grid();
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    row = _ref[_i];
    for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
      tile = row[_j];
      new RenderingTile(tile);
    }
  }

  settlement = Opal.TheGame.Settlement.$instance();

  this.RenderingFireplace = (function(_super) {
    __extends(RenderingFireplace, _super);

    function RenderingFireplace() {
      this.createContent = __bind(this.createContent, this);
      return RenderingFireplace.__super__.constructor.apply(this, arguments);
    }

    RenderingFireplace.prototype.createContent = function() {
      return this.content = new PIXI.Text("F", {
        font: "25px",
        fill: "red"
      });
    };

    return RenderingFireplace;

  })(Renderable);

  new RenderingFireplace(settlement.$fireplace());

  this.RenderingStash = (function(_super) {
    __extends(RenderingStash, _super);

    function RenderingStash() {
      this.createContent = __bind(this.createContent, this);
      return RenderingStash.__super__.constructor.apply(this, arguments);
    }

    RenderingStash.prototype.createContent = function() {
      return this.content = new PIXI.Text("S", {
        font: "25px",
        fill: "white"
      });
    };

    return RenderingStash;

  })(Renderable);

  new RenderingStash(settlement.$stash());

  RenderingPerson = (function(_super) {
    __extends(RenderingPerson, _super);

    function RenderingPerson() {
      this.createContent = __bind(this.createContent, this);
      return RenderingPerson.__super__.constructor.apply(this, arguments);
    }

    RenderingPerson.prototype.createContent = function() {
      var content;
      if (this.object.$type() === "woodcutter") {
        content = "W";
      } else if (this.object.$type() === "leader") {
        content = "L";
      } else if (this.object.$type() === "gatherer") {
        content = "G";
      } else if (this.object.$type() === "fisherman") {
        content = "F";
      }
      return this.content = new PIXI.Text(content, {
        font: "25px",
        fill: "white"
      });
    };

    return RenderingPerson;

  })(Renderable);

  _ref1 = engine.$people();
  for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
    person = _ref1[_k];
    new RenderingPerson(person);
  }

  RenderingDormitory = (function(_super) {
    __extends(RenderingDormitory, _super);

    function RenderingDormitory() {
      this.updateSelf = __bind(this.updateSelf, this);
      this.draw = __bind(this.draw, this);
      this.createContent = __bind(this.createContent, this);
      return RenderingDormitory.__super__.constructor.apply(this, arguments);
    }

    RenderingDormitory.prototype.createContent = function() {
      if (!this.color) {
        this.color = 0x0000FF;
      }
      this.content = new PIXI.Graphics();
      return this.draw();
    };

    RenderingDormitory.prototype.draw = function() {
      this.content.beginFill(this.color, 0.3);
      this.content.drawRect(0, 0, 4 * tileSize, 4 * tileSize);
      return this.content.endFill();
    };

    RenderingDormitory.prototype.updateSelf = function() {
      if (this.object.$status() === "done") {
        this.color = 0x6F1C1C;
        return this.draw();
      }
    };

    return RenderingDormitory;

  })(Renderable);

  this.updateRenderObjects = (function(_this) {
    return function() {
      var dormitory, object, _l, _len3, _results;
      if (!settlement.$dormitory()["$nil?"]()) {
        if (!_this.renderingDormitory) {
          dormitory = settlement.$dormitory();
          _this.renderingDormitory = new RenderingDormitory(dormitory);
        }
      }
      _results = [];
      for (_l = 0, _len3 = updatable.length; _l < _len3; _l++) {
        object = updatable[_l];
        _results.push(object.update());
      }
      return _results;
    };
  })(this);

}).call(this);
