class @RenderingFireplace extends Renderable
  createContent: =>
    @content = new PIXI.Text("F", {font: "25px", fill: "red"})
