class @RenderingStash extends Renderable
  createContent: =>
    @content = new PIXI.Text("S", {font: "25px", fill: "white"})
