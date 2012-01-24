helpers = if typeof require is 'undefined' then window.viewHelpers else require './view_helper'

QUnit.module 'Batman.View form bindings'

asyncTest 'FileBinding works', 2,  ->
  context = Batman
    theFile: 'theFile'

  helpers.render '<input type="file" data-bind="theFile" />', context, (node) ->
    delay => # wait for select's data-bind listener to receive the rendered event
      equal node[0].files.length, 0

      node[0].files[0] = 'differentFile'
      helpers.triggerChange node[0]
      delay =>
        equal context.get('theFile'), 'differentFile'
