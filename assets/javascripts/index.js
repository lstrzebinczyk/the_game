(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine = (function() {
    function GameEngine() {
      this.eachPerson = __bind(this.eachPerson, this);
      this.eachTile = __bind(this.eachTile, this);
      this.update = __bind(this.update, this);
      this.time = __bind(this.time, this);
      this.mapHeight = __bind(this.mapHeight, this);
      this.mapWidth = __bind(this.mapWidth, this);
      var person, row, tile, _i, _j, _k, _len, _len1, _len2, _ref, _ref1;
      this.engine = Opal.TheGame.Engine.$new();
      this.stash = new GameEngine.Stash();
      this.dormitory = new GameEngine.Dormitory();
      this.fireplace = new GameEngine.Fireplace();
      this.people = [];
      _ref = this.engine.$people();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        person = _ref[_i];
        this.people.push(new GameEngine.Person(person));
      }
      this.tiles = [];
      _ref1 = this.engine.$map().$grid();
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        row = _ref1[_j];
        for (_k = 0, _len2 = row.length; _k < _len2; _k++) {
          tile = row[_k];
          this.tiles.push(new GameEngine.Tile(tile));
        }
      }
    }

    GameEngine.prototype.mapWidth = function() {
      return this.engine.map.$width();
    };

    GameEngine.prototype.mapHeight = function() {
      return this.engine.map.$height();
    };

    GameEngine.prototype.time = function() {
      return this.engine.$time().$strftime("%T");
    };

    GameEngine.prototype.update = function() {
      return this.engine.$update();
    };

    GameEngine.prototype.eachTile = function(block) {
      var tile, _i, _len, _ref, _results;
      _ref = this.tiles;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        tile = _ref[_i];
        _results.push(block(tile));
      }
      return _results;
    };

    GameEngine.prototype.eachPerson = function(block) {
      var person, _i, _len, _ref, _results;
      _ref = this.people;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        person = _ref[_i];
        _results.push(block(person));
      }
      return _results;
    };

    return GameEngine;

  })();

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine.Dormitory = (function() {
    function Dormitory() {
      this.y = __bind(this.y, this);
      this.x = __bind(this.x, this);
      this.dormitory = __bind(this.dormitory, this);
      this.minutesLeft = __bind(this.minutesLeft, this);
      this.firewoodNeeded = __bind(this.firewoodNeeded, this);
      this.status = __bind(this.status, this);
      this.isNil = __bind(this.isNil, this);
      this.settlement = Opal.TheGame.Settlement.$instance();
    }

    Dormitory.prototype.isNil = function() {
      return this.settlement.$dormitory()["$nil?"]();
    };

    Dormitory.prototype.status = function() {
      return this.settlement.$dormitory().$status();
    };

    Dormitory.prototype.firewoodNeeded = function() {
      return this.settlement.$dormitory().$firewood_needed();
    };

    Dormitory.prototype.minutesLeft = function() {
      return this.settlement.$dormitory().$minutes_left();
    };

    Dormitory.prototype.dormitory = function() {
      return Opal.TheGame.Settlement.$instance().$dormitory();
    };

    Dormitory.prototype.x = function() {
      return this.settlement.$dormitory().$x();
    };

    Dormitory.prototype.y = function() {
      return this.settlement.$dormitory().$y();
    };

    return Dormitory;

  })();

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine.Fireplace = (function() {
    function Fireplace() {
      this.y = __bind(this.y, this);
      this.x = __bind(this.x, this);
      this.fireplace = Opal.TheGame.Settlement.$instance().$fireplace();
    }

    Fireplace.prototype.x = function() {
      return this.fireplace.$x();
    };

    Fireplace.prototype.y = function() {
      return this.fireplace.$y();
    };

    return Fireplace;

  })();

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine.Person = (function() {
    function Person(person) {
      this.person = person;
      this.y = __bind(this.y, this);
      this.x = __bind(this.x, this);
      this.actionDescription = __bind(this.actionDescription, this);
      this.energy = __bind(this.energy, this);
      this.hunger = __bind(this.hunger, this);
      this.thirst = __bind(this.thirst, this);
      this.type = __bind(this.type, this);
    }

    Person.prototype.type = function() {
      return this.person.$type();
    };

    Person.prototype.thirst = function() {
      return this.person.$thirst();
    };

    Person.prototype.hunger = function() {
      return this.person.$hunger();
    };

    Person.prototype.energy = function() {
      return this.person.$energy();
    };

    Person.prototype.actionDescription = function() {
      return this.person.$action().$description();
    };

    Person.prototype.x = function() {
      return this.person.$x();
    };

    Person.prototype.y = function() {
      return this.person.$y();
    };

    return Person;

  })();

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine.Stash = (function() {
    function Stash() {
      this.y = __bind(this.y, this);
      this.x = __bind(this.x, this);
      this.count = __bind(this.count, this);
      this.itemTypes = __bind(this.itemTypes, this);
      this.stash = Opal.TheGame.Settlement.$instance().$stash();
    }

    Stash.prototype.itemTypes = function() {
      return this.stash.$item_types();
    };

    Stash.prototype.count = function(type) {
      return this.stash.$count(type);
    };

    Stash.prototype.x = function() {
      return this.stash.$x();
    };

    Stash.prototype.y = function() {
      return this.stash.$y();
    };

    return Stash;

  })();

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine.Tile = (function() {
    function Tile(tile) {
      this.tile = tile;
      this.y = __bind(this.y, this);
      this.x = __bind(this.x, this);
      this.updated = __bind(this.updated, this);
      this.isUpdated = __bind(this.isUpdated, this);
      this.contentName = __bind(this.contentName, this);
      this.isMarkedForCleaning = __bind(this.isMarkedForCleaning, this);
      this.cachedContentName = this.contentName();
      this.cachedIsMarkedForCleaning = this.isMarkedForCleaning();
    }

    Tile.prototype.isMarkedForCleaning = function() {
      return this.tile["$marked_for_cleaning?"]();
    };

    Tile.prototype.contentName = function() {
      if (this.tile.$terrain() === "river") {
        return "river";
      } else {
        return this.tile.$content().constructor.name;
      }
    };

    Tile.prototype.isUpdated = function() {
      return (this.cachedContentName !== this.contentName()) || (this.cachedIsMarkedForCleaning !== this.isMarkedForCleaning());
    };

    Tile.prototype.updated = function() {
      this.cachedContentName = this.contentName();
      return this.cachedIsMarkedForCleaning = this.isMarkedForCleaning();
    };

    Tile.prototype.x = function() {
      return this.tile.$x();
    };

    Tile.prototype.y = function() {
      return this.tile.$y();
    };

    return Tile;

  })();

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameLoop = (function() {
    function GameLoop() {
      this.stopGame = __bind(this.stopGame, this);
      this.startGame = __bind(this.startGame, this);
      this.update = __bind(this.update, this);
      this.setup = __bind(this.setup, this);
      this.gameEngine = new GameEngine();
      this.gameMenu = new GameMenu(this.gameEngine);
      this.gameWindow = new GameWindow(this.gameEngine);
      this.startButton = $("#start");
      this.expectedTurnsPerSecond = 120;
    }

    GameLoop.prototype.setup = function() {
      this.startButton.click((function(_this) {
        return function() {
          if (_this.playing) {
            return _this.stopGame();
          } else {
            return _this.startGame();
          }
        };
      })(this));
      return this.gameWindow.setup();
    };

    GameLoop.prototype.update = function() {
      this.gameEngine.update();
      this.gameMenu.update();
      this.gameWindow.update();
      return this.gameWindow.render();
    };

    GameLoop.prototype.startGame = function() {
      this.gameLoop = setInterval(this.update, 1000 / this.expectedTurnsPerSecond);
      this.playing = true;
      this.gameWindow.playing = true;
      return this.startButton.text("Stop!");
    };

    GameLoop.prototype.stopGame = function() {
      clearInterval(this.gameLoop);
      this.playing = false;
      this.gameWindow.playing = false;
      return this.startButton.text("Start!");
    };

    return GameLoop;

  })();

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameWindow = (function() {
    function GameWindow(engine) {
      var interactive;
      this.engine = engine;
      this.setup = __bind(this.setup, this);
      this.removeChild = __bind(this.removeChild, this);
      this.addChild = __bind(this.addChild, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      interactive = true;
      this.stage = new PIXI.Stage('000', interactive);
      this.playing = true;
      this.x_offset = 0;
      this.y_offset = 0;
      this.change_offset = false;
      this.width = this.engine.mapWidth();
      this.height = this.engine.mapHeight();
      this.renderedWidth = 14 * 4;
      this.renderedHeight = 14 * 3;
      this.tileSize = 16;
      this.maxXOffset = (this.renderedWidth - this.width) * this.tileSize;
      this.maxYOffset = (this.renderedHeight - this.height) * this.tileSize;
      this.renderer = PIXI.autoDetectRenderer(this.renderedWidth * this.tileSize, this.renderedHeight * this.tileSize);
      this.updatable = [];
    }

    GameWindow.prototype.update = function() {
      var object, _i, _len, _ref, _results;
      if (!this.engine.dormitory.isNil()) {
        if (!this.renderingDormitory) {
          this.renderingDormitory = new RenderingDormitory(this.engine.dormitory, this);
        }
      }
      _ref = this.updatable;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        object = _ref[_i];
        _results.push(object.update());
      }
      return _results;
    };

    GameWindow.prototype.render = function() {
      return this.renderer.render(this.stage);
    };

    GameWindow.prototype.addChild = function(child) {
      this.stage.addChild(child.content);
      return this.updatable.push(child);
    };

    GameWindow.prototype.removeChild = function(child) {
      this.stage.removeChild(child.content);
      return child.content = null;
    };

    GameWindow.prototype.setup = function() {
      $("#view").append(this.renderer.view);
      this.engine.eachTile((function(_this) {
        return function(tile) {
          return new RenderingTile(tile, _this);
        };
      })(this));
      new RenderingFireplace(this.engine.fireplace, this);
      new RenderingStash(this.engine.stash, this);
      this.engine.eachPerson((function(_this) {
        return function(person) {
          return new RenderingPerson(person, _this);
        };
      })(this));
      this.stage.mousemove = (function(_this) {
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
            _this.update();
            return _this.render();
          }
        };
      })(this);
      this.stage.mouseup = (function(_this) {
        return function() {
          return _this.change_offset = false;
        };
      })(this);
      this.stage.mouseupoutside = (function(_this) {
        return function() {
          return _this.change_offset = false;
        };
      })(this);
      return this.stage.mousedown = (function(_this) {
        return function() {
          return _this.change_offset = true;
        };
      })(this);
    };

    return GameWindow;

  })();

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameMenu = (function() {
    function GameMenu(engine) {
      this.engine = engine;
      this.renderTurnsPerSecond = __bind(this.renderTurnsPerSecond, this);
      this.renderPeopleStats = __bind(this.renderPeopleStats, this);
      this.renderStashStats = __bind(this.renderStashStats, this);
      this.renderBuildingsStats = __bind(this.renderBuildingsStats, this);
      this.renderTime = __bind(this.renderTime, this);
      this.update = __bind(this.update, this);
      this.peopleStatsWindow = $("#people");
      this.stashStatsWindow = $("#stash");
      this.buildingStatsWindow = $("#buildings");
      this.timeWindow = $("#time");
      this.timeSinceLastCountUpdate = new Date();
      this.iterationsSinceLastCountUpdate = 0;
      this.turnsPerSecondWindow = $("#turns_count");
    }

    GameMenu.prototype.update = function() {
      this.renderTime();
      this.renderBuildingsStats();
      this.renderStashStats();
      this.renderPeopleStats();
      return this.renderTurnsPerSecond();
    };

    GameMenu.prototype.renderTime = function() {
      return this.timeWindow.text(this.engine.time());
    };

    GameMenu.prototype.renderBuildingsStats = function() {
      var template;
      this.buildingStatsWindow.empty();
      if (!this.engine.dormitory.isNil()) {
        template = "<div>";
        template += "<div>DORMITORY:</div>";
        template += "<div>status: " + (this.engine.dormitory.status()) + "</div>";
        if (this.engine.dormitory.status() === "plan") {
          template += "<div>firewood needed: " + (this.engine.dormitory.firewoodNeeded()) + "</div>";
        }
        if (this.engine.dormitory.status() === "building") {
          template += "<div>construction left: " + (this.engine.dormitory.minutesLeft()) + "</div>";
        }
        return this.buildingStatsWindow.append(template);
      }
    };

    GameMenu.prototype.renderStashStats = function() {
      var template, type, _i, _len, _ref;
      this.stashStatsWindow.empty();
      template = "<div>";
      _ref = this.engine.stash.itemTypes();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        type = _ref[_i];
        template += "<div>" + type + ": " + (this.engine.stash.count(type));
      }
      template += "</div>";
      return this.stashStatsWindow.append(template);
    };

    GameMenu.prototype.renderPeopleStats = function() {
      this.peopleStatsWindow.empty();
      return this.engine.eachPerson((function(_this) {
        return function(person) {
          var action_description, energy, hunger, progress, template, thirst, type;
          type = person.type();
          thirst = person.thirst();
          hunger = person.hunger();
          energy = person.energy();
          action_description = person.actionDescription();
          progress = function(value) {
            return "<progress value='" + value + "'></progress>";
          };
          template = "<div>\n  <div>type: " + type + "</div>\n  <div>thirst: " + (progress(thirst)) + "</div>\n  <div>hunger: " + (progress(hunger)) + "</div>\n  <div>energy: " + (progress(energy)) + "</div>\n  <div>action_description: " + action_description + "</div>\n  <br>\n</div>";
          return _this.peopleStatsWindow.append(template);
        };
      })(this));
    };

    GameMenu.prototype.renderTurnsPerSecond = function() {
      var possibleNewTime;
      this.iterationsSinceLastCountUpdate += 1;
      possibleNewTime = new Date();
      if (possibleNewTime - this.timeSinceLastCountUpdate > 1000) {
        this.timeSinceLastCountUpdate = possibleNewTime;
        this.turnsPerSecondWindow.text(this.iterationsSinceLastCountUpdate);
        return this.iterationsSinceLastCountUpdate = 0;
      }
    };

    return GameMenu;

  })();

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.Renderable = (function() {
    function Renderable(object, gameWindow) {
      this.object = object;
      this.gameWindow = gameWindow;
      this.updateContentPosition = __bind(this.updateContentPosition, this);
      this.removeContent = __bind(this.removeContent, this);
      this.isWithinView = __bind(this.isWithinView, this);
      this.update = __bind(this.update, this);
      this.createContent();
      this.renderedWidth = this.gameWindow.renderedWidth;
      this.renderedHeight = this.gameWindow.renderedHeight;
      this.gameWindow.addChild(this);
    }

    Renderable.prototype.update = function() {
      if (this.isWithinView()) {
        if (this.content) {
          this.updateSelf();
          return this.updateContentPosition();
        } else {
          this.createContent();
          this.gameWindow.stage.addChild(this.content);
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
      return this.object.y() * this.gameWindow.tileSize >= -this.gameWindow.x_offset && this.object.y() * this.gameWindow.tileSize < -this.gameWindow.x_offset + this.renderedWidth * this.gameWindow.tileSize && this.object.x() * this.gameWindow.tileSize >= -this.gameWindow.y_offset && this.object.x() * this.gameWindow.tileSize < -this.gameWindow.y_offset + this.renderedHeight * this.gameWindow.tileSize;
    };

    Renderable.prototype.removeContent = function() {
      return this.gameWindow.removeChild(this);
    };

    Renderable.prototype.updateContentPosition = function() {
      this.content.position.x = this.object.y() * this.gameWindow.tileSize + this.gameWindow.x_offset;
      return this.content.position.y = this.object.x() * this.gameWindow.tileSize + this.gameWindow.y_offset;
    };

    return Renderable;

  })();

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.RenderingDormitory = (function(_super) {
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
      this.content.drawRect(0, 0, 4 * this.gameWindow.tileSize, 4 * this.gameWindow.tileSize);
      return this.content.endFill();
    };

    RenderingDormitory.prototype.updateSelf = function() {
      if (this.object.status() === "done") {
        this.color = 0x6F1C1C;
        return this.draw();
      }
    };

    return RenderingDormitory;

  })(Renderable);

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

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

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.RenderingPerson = (function(_super) {
    __extends(RenderingPerson, _super);

    function RenderingPerson() {
      this.createContent = __bind(this.createContent, this);
      return RenderingPerson.__super__.constructor.apply(this, arguments);
    }

    RenderingPerson.prototype.createContent = function() {
      var content;
      if (this.object.type() === "woodcutter") {
        content = "W";
      } else if (this.object.type() === "leader") {
        content = "L";
      } else if (this.object.type() === "gatherer") {
        content = "G";
      } else if (this.object.type() === "fisherman") {
        content = "F";
      }
      return this.content = new PIXI.Text(content, {
        font: "25px",
        fill: "white"
      });
    };

    return RenderingPerson;

  })(Renderable);

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

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

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

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
      if (this.object.isUpdated()) {
        this.removeContent();
        this.createContent();
        this.gameWindow.stage.addChild(this.content);
        return this.object.updated();
      }
    };

    RenderingTile.prototype.setData = function() {
      if (this.object.isMarkedForCleaning()) {
        if (this.object.contentName() === "$Tree") {
          this.contentString = "t";
          return this.contentColor = "red";
        } else if (this.object.contentName() === "$FallenTree") {
          this.contentString = "/";
          return this.contentColor = "red";
        } else if (this.object.contentName() === "$BerriesBush") {
          this.contentString = "#";
          return this.contentColor = "red";
        }
      } else {
        if (this.object.contentName() === "$Tree") {
          this.contentString = "t";
          return this.contentColor = "green";
        } else if (this.object.contentName() === "$FallenTree") {
          this.contentString = "/";
          return this.contentColor = "green";
        } else if (this.object.contentName() === "$BerriesBush") {
          this.contentString = "#";
          return this.contentColor = "yellow";
        } else if (this.object.contentName() === "river") {
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

}).call(this);
(function() {
  jQuery(function() {
    var gameLoop;
    gameLoop = new GameLoop();
    gameLoop.setup();
    return gameLoop.startGame();
  });

}).call(this);
