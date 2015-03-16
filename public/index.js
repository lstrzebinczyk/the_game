(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine = (function() {
    function GameEngine() {
      this.findTile = bind(this.findTile, this);
      this.eachPerson = bind(this.eachPerson, this);
      this.eachTile = bind(this.eachTile, this);
      this.update = bind(this.update, this);
      this.time = bind(this.time, this);
      this.mapEvents = bind(this.mapEvents, this);
      this.mapHeight = bind(this.mapHeight, this);
      this.mapWidth = bind(this.mapWidth, this);
      var i, j, k, len, len1, len2, person, ref, ref1, row, tile;
      this.engine = Opal.TheGame.Engine.$new();
      this.stash = new GameEngine.Stash();
      this.dormitory = new GameEngine.Dormitory();
      this.fireplace = new GameEngine.Fireplace();
      this.people = [];
      ref = this.engine.$people();
      for (i = 0, len = ref.length; i < len; i++) {
        person = ref[i];
        this.people.push(new GameEngine.Person(person));
      }
      this.tiles = [];
      ref1 = this.engine.$map().$grid();
      for (j = 0, len1 = ref1.length; j < len1; j++) {
        row = ref1[j];
        for (k = 0, len2 = row.length; k < len2; k++) {
          tile = row[k];
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

    GameEngine.prototype.mapEvents = function() {
      return this.engine.map.$events();
    };

    GameEngine.prototype.time = function() {
      return this.engine.$time().$strftime("%T");
    };

    GameEngine.prototype.update = function() {
      return this.engine.$update();
    };

    GameEngine.prototype.eachTile = function(block) {
      var i, len, ref, results, tile;
      ref = this.tiles;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        tile = ref[i];
        results.push(block(tile));
      }
      return results;
    };

    GameEngine.prototype.eachPerson = function(block) {
      var i, len, person, ref, results;
      ref = this.people;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        person = ref[i];
        results.push(block(person));
      }
      return results;
    };

    GameEngine.prototype.findTile = function(x, y) {
      var i, len, ref, tile;
      ref = this.tiles;
      for (i = 0, len = ref.length; i < len; i++) {
        tile = ref[i];
        if (tile.x() === x && tile.y() === y) {
          return tile;
        }
      }
    };

    return GameEngine;

  })();

}).call(this);
(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine.Dormitory = (function() {
    function Dormitory() {
      this.y = bind(this.y, this);
      this.x = bind(this.x, this);
      this.dormitory = bind(this.dormitory, this);
      this.minutesLeft = bind(this.minutesLeft, this);
      this.firewoodNeeded = bind(this.firewoodNeeded, this);
      this.status = bind(this.status, this);
      this.isNil = bind(this.isNil, this);
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
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine.Fireplace = (function() {
    function Fireplace() {
      this.y = bind(this.y, this);
      this.x = bind(this.x, this);
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
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine.Person = (function() {
    function Person(person) {
      this.person = person;
      this.y = bind(this.y, this);
      this.x = bind(this.x, this);
      this.waterskinPercentage = bind(this.waterskinPercentage, this);
      this.inventoryCount = bind(this.inventoryCount, this);
      this.inventoryItemTypes = bind(this.inventoryItemTypes, this);
      this.actionDescription = bind(this.actionDescription, this);
      this.energy = bind(this.energy, this);
      this.hunger = bind(this.hunger, this);
      this.thirst = bind(this.thirst, this);
      this.type = bind(this.type, this);
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
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine.Stash = (function() {
    function Stash() {
      this.y = bind(this.y, this);
      this.x = bind(this.x, this);
      this.tilesCoords = bind(this.tilesCoords, this);
      this.count = bind(this.count, this);
      this.itemTypes = bind(this.itemTypes, this);
      this.stash = Opal.TheGame.Settlement.$instance().$stash();
    }

    Stash.prototype.itemTypes = function() {
      return this.stash.$item_types();
    };

    Stash.prototype.count = function(type) {
      return this.stash.$count(type);
    };

    Stash.prototype.tilesCoords = function() {
      return this.stash.$tiles_coords();
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
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameEngine.Tile = (function() {
    function Tile(tile) {
      this.tile = tile;
      this.y = bind(this.y, this);
      this.x = bind(this.x, this);
      this.isNil = bind(this.isNil, this);
      this.terrain = bind(this.terrain, this);
      this.buildingType = bind(this.buildingType, this);
      this.contentType = bind(this.contentType, this);
      this.isNotMarkedForCleaning = bind(this.isNotMarkedForCleaning, this);
    }

    Tile.prototype.isNotMarkedForCleaning = function() {
      return this.tile["$not_marked_for_cleaning?"]();
    };

    Tile.prototype.contentType = function() {
      return this.tile.$content().$type();
    };

    Tile.prototype.buildingType = function() {
      return this.tile.$building().$type();
    };

    Tile.prototype.terrain = function() {
      return this.tile.$terrain();
    };

    Tile.prototype.isNil = function() {
      return this.tile.$content()["$nil?"]();
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
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameLoop = (function() {
    function GameLoop() {
      this.stopGame = bind(this.stopGame, this);
      this.startGame = bind(this.startGame, this);
      this.update = bind(this.update, this);
      this.setup = bind(this.setup, this);
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
      if (this.expectedTurnsPerSecond === 30) {
        $("#slow").addClass("active");
      }
      $("#slow").click((function(_this) {
        return function() {
          $(".speed_control").removeClass("active");
          $("#slow").addClass("active");
          _this.expectedTurnsPerSecond = 30;
          _this.stopGame();
          return _this.startGame();
        };
      })(this));
      if (this.expectedTurnsPerSecond === 60) {
        $("#fast").addClass("active");
      }
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
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameMenu = (function() {
    function GameMenu(engine) {
      this.engine = engine;
      this.renderTurnsPerSecond = bind(this.renderTurnsPerSecond, this);
      this.renderPeopleStats = bind(this.renderPeopleStats, this);
      this.renderStashStats = bind(this.renderStashStats, this);
      this.renderBuildingsStats = bind(this.renderBuildingsStats, this);
      this.renderTime = bind(this.renderTime, this);
      this.update = bind(this.update, this);
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
      var i, len, ref, type;
      this.stashStatsWindow.empty();
      this.stashTemplate = "<div>";
      ref = this.engine.stash.itemTypes();
      for (i = 0, len = ref.length; i < len; i++) {
        type = ref[i];
        this.stashTemplate += "<div>" + type + ": " + (this.engine.stash.count(type));
      }
      this.stashTemplate += "</div>";
      return this.stashStatsWindow.append(this.stashTemplate);
    };

    GameMenu.prototype.renderPeopleStats = function() {
      this.peopleStatsWindow.empty();
      return this.engine.eachPerson((function(_this) {
        return function(person) {
          var action_description, count, energy, hunger, i, len, ref, thirst, type, waterkinPercentage;
          type = person.type();
          thirst = person.thirst();
          hunger = person.hunger();
          energy = person.energy();
          waterkinPercentage = person.waterskinPercentage();
          action_description = person.actionDescription();
          _this.peopleTemplate = "<div>\n  <div>type: " + type + "</div>\n  <div>thirst: <progress value='" + thirst + "'></progress></div>\n  <div>hunger: <progress value='" + hunger + "'></progress></div>\n  <div>energy: <progress value='" + energy + "'></progress></div>\n\n  <div>action_description: " + action_description + "</div>\n  <div>waterkin capacity: <progress value='" + waterkinPercentage + "'></progress>\n  <div>items:</div>";
          ref = person.inventoryItemTypes();
          for (i = 0, len = ref.length; i < len; i++) {
            type = ref[i];
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
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GameWindow = (function() {
    function GameWindow(engine) {
      this.engine = engine;
      this.setup = bind(this.setup, this);
      this.renderContentTile = bind(this.renderContentTile, this);
      this.renderContent = bind(this.renderContent, this);
      this.cleanTile = bind(this.cleanTile, this);
      this.renderBuilding = bind(this.renderBuilding, this);
      this.rerenderContentBasedOnEvent = bind(this.rerenderContentBasedOnEvent, this);
      this.reRenderTerrain = bind(this.reRenderTerrain, this);
      this.reRenderPeople = bind(this.reRenderPeople, this);
      this.renderTerrain = bind(this.renderTerrain, this);
      this.reRenderStash = bind(this.reRenderStash, this);
      this.renderStash = bind(this.renderStash, this);
      this.reRenderFireplace = bind(this.reRenderFireplace, this);
      this.renderFireplace = bind(this.renderFireplace, this);
      this.findStageTile = bind(this.findStageTile, this);
      this.render = bind(this.render, this);
      this.update = bind(this.update, this);
      this.stage = $("#stage");
      this.renderedWidth = 14 * 4;
      this.renderedHeight = 14 * 3;
      this.xOffset = 0;
      this.yOffset = 0;
      this.maxYOffset = this.engine.mapWidth() - this.renderedWidth;
      this.maxXOffset = this.engine.mapHeight() - this.renderedHeight;
      this.oftenUpdated = [];
      this.tileSize = 16;
    }

    GameWindow.prototype.update = function() {
      var blueprint, event, i, len, ref, tile;
      if (this.engine.mapEvents().$size() > 0) {
        event = this.engine.mapEvents().$pop();
        this.rerenderContentBasedOnEvent(event);
        this.oftenUpdated = this.oftenUpdated.filter(function(tile) {
          return !tile.isNil();
        });
      }
      ref = this.oftenUpdated;
      for (i = 0, len = ref.length; i < len; i++) {
        tile = ref[i];
        this.cleanTile(tile);
        this.renderContentTile(tile);
      }
      if (this.engine.dormitory.status() === "plan") {
        blueprint = $(".structure-shelter-blueprint");
        if (blueprint.hasClass("cleaning")) {
          blueprint.removeClass("cleaning");
          blueprint.addClass("plan");
        }
      }
      if (this.engine.dormitory.status() === "done") {
        blueprint = $(".structure-shelter-blueprint");
        blueprint.removeClass("plan");
        blueprint.removeClass("structure-shelter-blueprint");
        blueprint.addClass("structure-shelter");
      }
      return this.reRenderPeople();
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
      stageTile = this.findStageTile(x, y).find(".content");
      return stageTile.addClass("structure-campfire");
    };

    GameWindow.prototype.reRenderFireplace = function() {
      this.stage.find(".structure-campfire").removeClass("structure-campfire");
      return this.renderFireplace();
    };

    GameWindow.prototype.renderStash = function() {
      var coords, i, len, ref, results, stageTile, stash, x, y;
      stash = this.engine.stash;
      ref = stash.tilesCoords();
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        coords = ref[i];
        x = stash.x() + this.xOffset + coords[0];
        y = stash.y() + this.yOffset + coords[1];
        stageTile = this.findStageTile(x, y).find(".content");
        results.push(stageTile.addClass("structure-stash structure-stash-" + coords[0] + "-" + coords[1]));
      }
      return results;
    };

    GameWindow.prototype.reRenderStash = function() {
      this.stage.find(".structure-stash").attr("class", "content");
      return this.renderStash();
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
          tile = _this.findStageTile(x, y).find(".content");
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

    GameWindow.prototype.rerenderContentBasedOnEvent = function(mapEvent) {
      var building, i, len, mapTile, ref, tile, x, y;
      x = mapEvent.$x();
      y = mapEvent.$y();
      tile = this.engine.findTile(x, y);
      this.cleanTile(tile);
      if (mapEvent.$type() === "clean") {

      } else if (mapEvent.$type() === "update") {
        this.oftenUpdated.push(tile);
        return this.renderContentTile(tile);
      } else if (mapEvent.$type() === "building_created") {
        building = mapEvent.opts.$first()[1];
        ref = building.$fields();
        for (i = 0, len = ref.length; i < len; i++) {
          mapTile = ref[i];
          if (!mapTile["$not_marked_for_cleaning?"]()) {
            this.findStageTile(mapTile.$x(), mapTile.$y()).addClass("marked-for-cleaning");
          }
        }
        return this.renderBuilding(tile, building);
      }
    };

    GameWindow.prototype.renderBuilding = function(tile, building) {
      var html, stageTile, x, y;
      x = tile.x() + this.xOffset;
      y = tile.y() + this.yOffset;
      stageTile = this.findStageTile(x, y).find(".content");
      html = $("<span class='structure-shelter-blueprint cleaning'></span>");
      html.css("left", y * 16 + 8);
      html.css("top", x * 16 + 64 - 6);
      return $("#buildings").append(html);
    };

    GameWindow.prototype.cleanTile = function(tile) {
      var stageBackground, stageTile, x, y;
      x = tile.x() + this.xOffset;
      y = tile.y() + this.yOffset;
      stageBackground = this.findStageTile(x, y);
      stageBackground.removeClass("marked-for-cleaning");
      stageTile = stageBackground.find(".content");
      return stageTile.attr("class", "content");
    };

    GameWindow.prototype.renderContent = function() {
      return this.engine.eachTile((function(_this) {
        return function(tile) {
          return _this.renderContentTile(tile);
        };
      })(this));
    };

    GameWindow.prototype.renderContentTile = function(tile) {
      var logsCount, stageTile, x, y;
      x = tile.x() + this.xOffset;
      y = tile.y() + this.yOffset;
      stageTile = this.findStageTile(x, y).find(".content");
      if (tile.contentType() === "tree") {
        return stageTile.addClass("nature-tree");
      } else if (tile.contentType() === "berries_bush") {
        return stageTile.addClass("berries-bush");
      } else if (tile.contentType() === "log_pile") {
        logsCount = tile.tile.content.logs_count;
        return stageTile.addClass("nature-logs-" + logsCount);
      }
    };

    GameWindow.prototype.setup = function() {
      var columnIndex, i, j, ref, ref1, rowIndex, stage;
      this.stage.append("<div id='buildings'></div>");
      stage = "";
      for (rowIndex = i = 0, ref = this.renderedHeight; 0 <= ref ? i <= ref : i >= ref; rowIndex = 0 <= ref ? ++i : --i) {
        stage += "<div class='row' id='row_" + rowIndex + "'>";
        for (columnIndex = j = 0, ref1 = this.renderedWidth; 0 <= ref1 ? j <= ref1 : j >= ref1; columnIndex = 0 <= ref1 ? ++j : --j) {
          stage += "<span class='tile' id='column_" + columnIndex + "'><span class='content'></span></span>";
        }
        stage += "</div>";
      }
      this.stage.append(stage);
      this.renderTerrain();
      this.reRenderPeople();
      this.renderFireplace();
      this.renderStash();
      this.renderContent();
      return this.stage.click((function(_this) {
        return function(e) {
          var column, row, tile, x, y;
          column = $(e.target).parent();
          x = parseInt(column.attr("id").replace("column_", ""));
          row = column.parent();
          y = parseInt(row.attr("id").replace("row_", ""));
          tile = _this.engine.findTile(y, x);
          return console.log(tile);
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
