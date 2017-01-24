require("common")
require("grid")

debug = true

field = nil
nextg = nil
currg = nil

-- bgimg = nil

function love.load(arg)
    field = Grid(8, 8)
    nextg = Grid(4, 1)
    currg = Grid(1, 1)

    field:select(1, 1)

    -- bgimg = love.graphics.newImage("assets/images/background_placeholder.jpg")
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
