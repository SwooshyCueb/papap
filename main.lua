debug = true

function love.load(arg)

end

function love.update(dt)

end

function love.draw(dt)
    field_x = 8
    field_y = 8

    -- Grid where pipes are placed
    for xpos=0,field_x-1,1 do
        for ypos=0,field_y-1,1 do
            love.graphics.rectangle("line", 8+(xpos*64), 8+(ypos*64), 64, 64)
        end
    end

    -- Slot for active pipe section
    love.graphics.rectangle("line", 8, 16+(field_y*64), 64, 64)

    -- Slots for upcoming pipe sections
    for xpos=1,4,1 do
        love.graphics.rectangle("line", 8+((field_x-xpos)*64), 16+(field_y*64), 64, 64)
    end

end
