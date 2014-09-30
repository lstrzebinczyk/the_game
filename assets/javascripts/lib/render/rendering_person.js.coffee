class @RenderingPerson extends Renderable
  createContent: =>
    if @object.type() == "woodcutter"
      content = "W"
    else if @object.type() == "leader"
      content = "L"
    else if @object.type() == "gatherer"
      content = "G"
    else if @object.type() == "fisherman"
      content = "F"

    @content = new PIXI.Text(content, {font: "25px", fill: "white"})
