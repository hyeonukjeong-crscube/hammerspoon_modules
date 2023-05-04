local boxes = {}
local inputEnglish = "com.apple.keylayout.ABC"
local alpha = 1
local color = {white = 1}

hs.keycodes.inputSourceChanged(function()
    disable_show()
    if hs.keycodes.currentSourceID() ~= inputEnglish then
        enable_show()
    end
end)

function enable_show()
    reset_boxes()

    hs.fnutils.each(hs.screen.allScreens(), function(scr)
        local frame = scr:fullFrame()
        local box = newBox()

        if scr:name() == "Built-in Retina Display" then
            draw_rectangle(box, frame.x + 5, frame.y + 5, 42, 25.5, color)
        else
            draw_rectangle(box, frame.x + 5, frame.y, 42, 24, color)
        end

        table.insert(boxes, box)
    end)
end

function disable_show()
    hs.fnutils.each(boxes, function(box)
        if box ~= nil then
            box:delete()
        end
    end)
    reset_boxes()
end

function newBox()
    return hs.drawing.rectangle(hs.geometry.rect(0,0,0,0))
end

function reset_boxes()
    boxes = {}
end

function draw_rectangle(target_draw, x, y, width, height, fill_color)
  target_draw:setSize(hs.geometry.rect(x, y, width, height))
  target_draw:setTopLeft(hs.geometry.point(x, y))
  target_draw:setFillColor(fill_color)
  target_draw:setFill(true)
  target_draw:setAlpha(alpha)
  target_draw:setLevel(hs.drawing.windowLevels.overlay)
  target_draw:setStroke(false)
  target_draw:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
  target_draw:show()
end
