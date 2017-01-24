require("common")
require("grid")

debug = true

field = nil
nextg = nil
currg = nil

function love.load(arg)
    field = Grid(8, 8)
    nextg = Grid(4, 1)
    currg = Grid(1, 1)
end

function love.update(dt)

end

function love.draw(dt)
    -- grid where pipes are placed
    love.graphics.draw(field.canvas, 8, 8)

    -- Slot for active pipe section
    love.graphics.draw(currg.canvas, 8, 16+(8*32))

    -- Slots for upcoming pipe sections
    love.graphics.draw(nextg.canvas, 8+(4*32), 16+(8*32))

end
