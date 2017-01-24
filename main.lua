require("common")
require("grid")
if not pcall(function() require('bit32') end) then
    require('extern/numberlua')
end

debug = true

field = nil
nextg = nil
currg = nil

selchgcounter = 1.5
-- bgimg = nil

function love.load(arg)
    field = Grid(8, 8)
    nextg = Grid(4, 1)
    currg = Grid(1, 1)

    field:select(1, 1)

    -- bgimg = love.graphics.newImage("assets/images/background_placeholder.jpg")

    love.keyboard.setKeyRepeat(false)
end

function love.keypressed(key, sc, rpt)
    btnpressed(key, sc, rpt, nil)
end

function love.gamepadpressed(js, btn)
    btnpressed(nil, nil, nil, btn)
end

function btnpressed(key, sc, rpt, btn)
    if key == 'left' or sc == 'a' or btn == "dpleft" then
        field:select(field.selected.x - 1, -1)
    end
    if key == 'right' or sc == 'd' or btn == "dpright" then
        field:select(field.selected.x + 1, -1)
    end

    if key == 'up' or sc == 'w' or btn == "dpup" then
        field:select(-1, field.selected.y - 1)
    end
    if key == 'down' or sc == 's' or btn == "dpdown" then
        field:select(-1, field.selected.y + 1)
    end
end

function love.update(dt)

end

function love.draw(dt)
    -- love.graphics.draw(bgimg, 0, 0)

    -- grid where pipes are placed
    love.graphics.draw(field.canvas, 8, 8)

    -- Slot for active pipe section
    love.graphics.draw(currg.canvas, 8, 16+(8*TILE_H))

    -- Slots for upcoming pipe sections
    love.graphics.draw(nextg.canvas, 8+(4*TILE_W), 16+(8*TILE_H))

end
