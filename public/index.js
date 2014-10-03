(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine = (function() {
    function GameEngine() {
      this.findTile = __bind(this.findTile, this);
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

    GameEngine.prototype.findTile = function(x, y) {
      return this.engine.$map().$fetch(x, y);
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
      this.waterskinPercentage = __bind(this.waterskinPercentage, this);
      this.inventoryCount = __bind(this.inventoryCount, this);
      this.inventoryItemTypes = __bind(this.inventoryItemTypes, this);
      this.actionDescription = __bind(this.actionDescription, this);
      this.energy = __bind(this.energy, this);
      this.hunger = __bind(this.hunger, this);
      this.thirst = __bind(this.thirst, this);
      this.type = __bind(this.type, this);
    }

    Person.prototype.id = function() {
      return this.person._id;
    };

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

    Person.prototype.inventoryItemTypes = function() {
      return this.person.$inventory().$item_types();
    };

    Person.prototype.inventoryCount = function(itemType) {
      return this.person.$inventory().$count(itemType);
    };

    Person.prototype.waterskinPercentage = function() {
      return this.person.$waterskin().$units() / this.person.$waterskin().$capacity();
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
      this.terrain = __bind(this.terrain, this);
      this.updated = __bind(this.updated, this);
      this.isUpdated = __bind(this.isUpdated, this);
      this.contentName = __bind(this.contentName, this);
      this.isNotMarkedForCleaning = __bind(this.isNotMarkedForCleaning, this);
      this.cachedContentName = this.contentName();
      this.cachedIsMarkedForCleaning = this.isNotMarkedForCleaning();
    }

    Tile.prototype.isNotMarkedForCleaning = function() {
      return this.tile["$not_marked_for_cleaning?"]();
    };

    Tile.prototype.contentName = function() {
      if (this.terrain() === "river") {
        return "river";
      } else {
        return this.tile.$content().$type();
      }
    };

    Tile.prototype.isUpdated = function() {
      return (this.cachedContentName !== this.contentName()) || (this.cachedIsMarkedForCleaning !== this.isNotMarkedForCleaning());
    };

    Tile.prototype.updated = function() {
      this.cachedContentName = this.contentName();
      return this.cachedIsMarkedForCleaning = this.isNotMarkedForCleaning();
    };

    Tile.prototype.terrain = function() {
      return this.tile.$terrain();
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
      this.expectedTurnsPerSecond = 30;
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
      this.gameWindow.setup();
      $("#slow").click((function(_this) {
        return function() {
          $(".speed_control").removeClass("active");
          $("#slow").addClass("active");
          _this.expectedTurnsPerSecond = 30;
          _this.stopGame();
          return _this.startGame();
        };
      })(this));
      $("#fast").addClass("active");
      $("#fast").click((function(_this) {
        return function() {
          $(".speed_control").removeClass("active");
          $("#fast").addClass("active");
          _this.expectedTurnsPerSecond = 60;
          _this.stopGame();
          return _this.startGame();
        };
      })(this));
      return $("#max").click((function(_this) {
        return function() {
          $(".speed_control").removeClass("active");
          $("#max").addClass("active");
          _this.expectedTurnsPerSecond = 1000;
          _this.stopGame();
          return _this.startGame();
        };
      })(this));
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
      this.buildingStatsWindow.empty();
      if (!this.engine.dormitory.isNil()) {
        this.buildingTemplate = "<div>";
        this.buildingTemplate += "<div>DORMITORY:</div>";
        this.buildingTemplate += "<div>status: " + (this.engine.dormitory.status()) + "</div>";
        if (this.engine.dormitory.status() === "plan") {
          this.buildingTemplate += "<div>firewood needed: " + (this.engine.dormitory.firewoodNeeded()) + "</div>";
        }
        if (this.engine.dormitory.status() === "building") {
          this.buildingTemplate += "<div>construction left: " + (this.engine.dormitory.minutesLeft()) + "</div>";
        }
        return this.buildingStatsWindow.append(this.buildingTemplate);
      }
    };

    GameMenu.prototype.renderStashStats = function() {
      var type, _i, _len, _ref;
      this.stashStatsWindow.empty();
      this.stashTemplate = "<div>";
      _ref = this.engine.stash.itemTypes();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        type = _ref[_i];
        this.stashTemplate += "<div>" + type + ": " + (this.engine.stash.count(type));
      }
      this.stashTemplate += "</div>";
      return this.stashStatsWindow.append(this.stashTemplate);
    };

    GameMenu.prototype.renderPeopleStats = function() {
      this.peopleStatsWindow.empty();
      return this.engine.eachPerson((function(_this) {
        return function(person) {
          var action_description, count, energy, hunger, thirst, type, waterkinPercentage, _i, _len, _ref;
          type = person.type();
          thirst = person.thirst();
          hunger = person.hunger();
          energy = person.energy();
          waterkinPercentage = person.waterskinPercentage();
          action_description = person.actionDescription();
          _this.peopleTemplate = "<div>\n  <div>type: " + type + "</div>\n  <div>thirst: <progress value='" + thirst + "'></progress></div>\n  <div>hunger: <progress value='" + hunger + "'></progress></div>\n  <div>energy: <progress value='" + energy + "'></progress></div>\n\n  <div>action_description: " + action_description + "</div>\n  <div>waterkin capacity: <progress value='" + waterkinPercentage + "'></progress>\n  <div>items:</div>";
          _ref = person.inventoryItemTypes();
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            type = _ref[_i];
            count = person.inventoryCount(type);
            if (count > 0) {
              _this.peopleTemplate += "<div>" + type + ": " + count;
            }
          }
          _this.peopleTemplate += "  <div>\n  </div>\n  <br>\n</div>";
          return _this.peopleStatsWindow.append(_this.peopleTemplate);
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

  this.GameWindow = (function() {
    function GameWindow(engine) {
      this.engine = engine;
      this.setup = __bind(this.setup, this);
      this.reRenderTerrain = __bind(this.reRenderTerrain, this);
      this.reRenderPeople = __bind(this.reRenderPeople, this);
      this.renderTerrain = __bind(this.renderTerrain, this);
      this.reRenderFireplace = __bind(this.reRenderFireplace, this);
      this.renderFireplace = __bind(this.renderFireplace, this);
      this.findStageTile = __bind(this.findStageTile, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.stage = $("#stage");
      this.renderedWidth = 14 * 4;
      this.renderedHeight = 14 * 3;
      this.xOffset = 0;
      this.yOffset = 0;
      this.maxYOffset = this.engine.mapWidth() - this.renderedWidth;
      this.maxXOffset = this.engine.mapHeight() - this.renderedHeight;
      this.tileSize = 16;
    }

    GameWindow.prototype.update = function() {
      this.reRenderPeople();
      return this.renderFireplace();
    };

    GameWindow.prototype.render = function() {};

    GameWindow.prototype.findStageTile = function(height, width) {
      return this.stage.find("#row_" + height).find("#column_" + width);
    };

    GameWindow.prototype.renderFireplace = function() {
      var fireplace, stageTile, x, y;
      fireplace = this.engine.fireplace;
      x = fireplace.x() + this.xOffset;
      y = fireplace.y() + this.yOffset;
      stageTile = this.findStageTile(x, y);
      return stageTile.addClass("structure-campfire");
    };

    GameWindow.prototype.reRenderFireplace = function() {
      this.stage.find(".structure-campfire").removeClass("structure-campfire");
      return this.renderFireplace();
    };

    GameWindow.prototype.renderTerrain = function() {
      return this.engine.eachTile((function(_this) {
        return function(tile) {
          var stageTile, terrainType, x, y;
          x = tile.x() + _this.xOffset;
          y = tile.y() + _this.yOffset;
          stageTile = _this.findStageTile(x, y);
          terrainType = tile.terrain();
          return stageTile.addClass("terrain-" + terrainType);
        };
      })(this));
    };

    GameWindow.prototype.reRenderPeople = function() {
      return this.engine.eachPerson((function(_this) {
        return function(person) {
          var id, tile, type, x, y;
          x = person.x() + _this.xOffset;
          y = person.y() + _this.yOffset;
          tile = _this.findStageTile(x, y);
          type = person.type();
          id = person.id();
          _this.stage.find(".person-" + type + ".person-" + id).removeClass("person-" + type + " person-" + id);
          return tile.addClass("person-" + type + " person-" + id);
        };
      })(this));
    };

    GameWindow.prototype.reRenderTerrain = function() {
      this.stage.find(".terrain-river").removeClass("terrain-river");
      this.stage.find(".terrain-ground").removeClass("terrain-ground");
      return this.renderTerrain();
    };

    GameWindow.prototype.setup = function() {
      var columnIndex, rowIndex, stage, _i, _j, _ref, _ref1;
      stage = "";
      for (rowIndex = _i = 0, _ref = this.renderedHeight; 0 <= _ref ? _i <= _ref : _i >= _ref; rowIndex = 0 <= _ref ? ++_i : --_i) {
        stage += "<div class='row' id='row_" + rowIndex + "'>";
        for (columnIndex = _j = 0, _ref1 = this.renderedWidth; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; columnIndex = 0 <= _ref1 ? ++_j : --_j) {
          stage += "<span class='tile' id='column_" + columnIndex + "'></span>";
        }
        stage += "</div>";
      }
      this.stage.append(stage);
      this.renderTerrain();
      this.reRenderPeople();
      this.renderFireplace();
      this.stage.mousemove((function(_this) {
        return function(e) {
          var diffX, diffY;
          if (_this.moving) {
            diffY = parseInt((_this.moveStartY - e.clientY) / _this.tileSize);
            diffX = parseInt((_this.moveStartX - e.clientX) / _this.tileSize);
            if (diffX !== 0 || diffY !== 0) {
              _this.xOffset -= diffY;
              _this.yOffset -= diffX;
              _this.moveStartY = e.clientY;
              _this.moveStartX = e.clientX;
              if (_this.xOffset < -_this.maxXOffset) {
                _this.xOffset = -_this.maxXOffset;
              }
              if (_this.yOffset < -_this.maxYOffset) {
                _this.yOffset = -_this.maxYOffset;
              }
              if (_this.xOffset > 0) {
                _this.xOffset = 0;
              }
              if (_this.yOffset > 0) {
                _this.yOffset = 0;
              }
              _this.reRenderTerrain();
              _this.reRenderPeople();
              return _this.reRenderFireplace();
            }
          }
        };
      })(this));
      $("body").mouseup((function(_this) {
        return function() {
          return _this.moving = false;
        };
      })(this));
      return this.stage.mousedown((function(_this) {
        return function(e) {
          _this.moving = true;
          _this.moveStartX = e.clientX;
          return _this.moveStartY = e.clientY;
        };
      })(this));
    };

    return GameWindow;

  })();

}).call(this);
(function() {
  jQuery(function() {
    var gameLoop;
    gameLoop = new GameLoop();
    gameLoop.setup();
    return gameLoop.startGame();
  });

}).call(this);
