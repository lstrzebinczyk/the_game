# class @Renderable
#   constructor: (@object) ->
#     @createContent()

#     # cache these so that you don't have to ask window for them
#     @renderedWidth = renderedWidth
#     @renderedHeight = renderedHeight

#     window.stage.addChild(@content)
#     window.updatable.push(@)

#   update: =>
#     if @isWithinView()
#       if @content
#         @updateSelf()
#         @updateContentPosition()
#       else
#         @createContent()
#         stage.addChild(@content)
#         @updateContentPosition()
#     else
#       if @content
#         @removeContent()

#   updateSelf: ->

#   isWithinView: =>
#     @object.$y() * tileSize >= - window.x_offset and
#     @object.$y() * tileSize < - window.x_offset + @renderedWidth*tileSize and
#     @object.$x() * tileSize >= - window.y_offset and
#     @object.$x() * tileSize < - window.y_offset + @renderedHeight*tileSize

#   removeContent: =>
#     stage.removeChild(@content)
#     @content = null

#   updateContentPosition: =>
#     @content.position.x = @object.$y() * tileSize + window.x_offset
#     @content.position.y = @object.$x() * tileSize + window.y_offset
