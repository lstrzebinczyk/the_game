(function() {
  var RenderingDormitory, RenderingPerson, interactive, person, renderer, row, settlement, tile, updatable, _i, _j, _k, _len, _len1, _len2, _ref, _ref1,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

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

  $("#progress").click(function() {
    engine.$update();
    return render_people_stats();
  });

  render_people_stats();

  this.now = new Date;

  this.render_turns_per_second = (function(_this) {
    return function() {
      var ms, new_now, tps;
      new_now = new Date();
      ms = new_now - _this.now;
      _this.now = new_now;
      tps = parseInt(1000.0 / ms);
      return $("#turns_count").text(tps);
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
    return updateRenderObjects();
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

  this.renderedWidth = 60;

  this.renderedHeight = 30;

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
          return _this.y_offset = _this.maxYOffset;
        }
      }
    };
  })(this);

  stage.mouseup = (function(_this) {
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

  requestAnimFrame(animate);

  updatable = [];

  this.RenderingTile = (function() {
    function RenderingTile(mapTile) {
      this.mapTile = mapTile;
      this._setData = __bind(this._setData, this);
      this._isWithinView = __bind(this._isWithinView, this);
      this.update = __bind(this.update, this);
      this._setData();
      this.text = new PIXI.Text(this.content, {
        font: "25px",
        fill: this.color
      });
      this.text.position.x = this.mapTile.$y() * tileSize;
      this.text.position.y = this.mapTile.$x() * tileSize;
      stage.addChild(this.text);
      updatable.push(this);
    }

    RenderingTile.prototype.update = function() {
      if (this._isWithinView()) {
        if (this.text) {
          this.text.position.x = this.mapTile.$y() * tileSize + window.x_offset;
          this.text.position.y = this.mapTile.$x() * tileSize + window.y_offset;
          if (!this.mapTile["$updated?"]()) {
            this._setData();
            this.text.setText(this.content);
            this.text.setStyle({
              font: "25px",
              fill: this.color
            });
            return this.mapTile["$updated!"]();
          }
        } else {
          this._setData();
          this.text = new PIXI.Text(this.content, {
            font: "25px",
            fill: this.color
          });
          this.text.position.x = this.mapTile.$y() * tileSize + window.x_offset;
          this.text.position.y = this.mapTile.$x() * tileSize + window.y_offset;
          return stage.addChild(this.text);
        }
      } else {
        if (this.text) {
          stage.removeChild(this.text);
          return this.text = null;
        }
      }
    };

    RenderingTile.prototype._isWithinView = function() {
      return this.mapTile.$y() * tileSize >= -window.x_offset && this.mapTile.$y() * tileSize < -window.x_offset + renderedWidth * tileSize && this.mapTile.$x() * tileSize >= -window.y_offset && this.mapTile.$x() * tileSize < -window.y_offset + renderedHeight * tileSize;
    };

    RenderingTile.prototype._setData = function() {
      if (this.mapTile["$marked_for_cleaning?"]()) {
        if (this.mapTile.$content().constructor.name === "$Tree") {
          this.content = "t";
          return this.color = "red";
        } else if (this.mapTile.$content().constructor.name === "$FallenTree") {
          this.content = "/";
          return this.color = "red";
        } else if (this.mapTile.$content().constructor.name === "$BerriesBush") {
          this.content = "#";
          return this.color = "red";
        }
      } else {
        if (this.mapTile.$content().constructor.name === "$Tree") {
          this.content = "t";
          return this.color = "green";
        } else if (this.mapTile.$content().constructor.name === "$FallenTree") {
          this.content = "/";
          return this.color = "green";
        } else if (this.mapTile.$content().constructor.name === "$BerriesBush") {
          this.content = "#";
          return this.color = "yellow";
        } else if (this.mapTile.$terrain() === "river") {
          this.content = "~";
          return this.color = "blue";
        } else {
          this.content = ".";
          return this.color = "white";
        }
      }
    };

    return RenderingTile;

  })();

  _ref = engine.$map().$grid();
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    row = _ref[_i];
    for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
      tile = row[_j];
      new RenderingTile(tile);
    }
  }

  settlement = Opal.TheGame.Settlement.$instance();

  this.RenderingFireplace = (function() {
    function RenderingFireplace(mapFireplace) {
      this.mapFireplace = mapFireplace;
      this.update = __bind(this.update, this);
      this.text = new PIXI.Text("F", {
        font: "25px",
        fill: "red"
      });
      this.text.position.x = this.mapFireplace.$y() * tileSize;
      this.text.position.y = this.mapFireplace.$x() * tileSize;
      stage.addChild(this.text);
      updatable.push(this);
    }

    RenderingFireplace.prototype.update = function() {};

    return RenderingFireplace;

  })();

  new RenderingFireplace(settlement.$fireplace());

  this.RenderingStash = (function() {
    function RenderingStash(mapStash) {
      this.mapStash = mapStash;
      this.update = __bind(this.update, this);
      this.text = new PIXI.Text("S", {
        font: "25px",
        fill: "white"
      });
      this.text.position.x = this.mapStash.$y() * tileSize;
      this.text.position.y = this.mapStash.$x() * tileSize;
      stage.addChild(this.text);
      updatable.push(this);
    }

    RenderingStash.prototype.update = function() {};

    return RenderingStash;

  })();

  new RenderingStash(settlement.$stash());

  RenderingPerson = (function() {
    function RenderingPerson(person) {
      var content;
      this.person = person;
      this.update = __bind(this.update, this);
      if (this.person.$type() === "woodcutter") {
        content = "W";
      } else if (this.person.$type() === "leader") {
        content = "L";
      } else if (this.person.$type() === "gatherer") {
        content = "G";
      } else if (this.person.$type() === "fisherman") {
        content = "F";
      }
      this.text = new PIXI.Text(content, {
        font: "25px",
        fill: "white"
      });
      this.text.position.x = this.person.$y() * tileSize;
      this.text.position.y = this.person.$x() * tileSize;
      stage.addChild(this.text);
      updatable.push(this);
    }

    RenderingPerson.prototype.update = function() {
      this.text.position.x = this.person.$y() * tileSize;
      return this.text.position.y = this.person.$x() * tileSize;
    };

    return RenderingPerson;

  })();

  _ref1 = engine.$people();
  for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
    person = _ref1[_k];
    new RenderingPerson(person);
  }

  RenderingDormitory = (function() {
    function RenderingDormitory(dormitory) {
      this.dormitory = dormitory;
      this.update = __bind(this.update, this);
      this.x = this.dormitory.$y() * tileSize;
      this.y = this.dormitory.$x() * tileSize;
      this.x_width = 4 * tileSize;
      this.y_width = 4 * tileSize;
      this.rectangle = new PIXI.Graphics();
      this.rectangle.beginFill(0x0000FF, 0.3);
      this.rectangle.drawRect(this.x, this.y, this.x_width, this.y_width);
      this.rectangle.endFill();
      stage.addChild(this.rectangle);
      updatable.push(this);
    }

    RenderingDormitory.prototype.update = function() {
      if (this.dormitory.$status() === "done") {
        this.rectangle.beginFill(0x6F1C1C, 0.3);
        this.rectangle.drawRect(this.x, this.y, this.x_width, this.y_width);
        return this.rectangle.endFill();
      }
    };

    return RenderingDormitory;

  })();

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

  
    function animate() {

        requestAnimFrame( animate );

        // just for fun, lets rotate mr rabbit a little
        // bunny.rotation += 0.1;


        // render the stage
        renderer.render(stage);
    }
;

}).call(this);
