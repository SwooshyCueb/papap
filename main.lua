require("common")
require("grid")
require("piece")
if not pcall(function() bit = require('bit32') end) then
    bit = require('extern/numberlua')
end

debug = true

field = nil
nextg = nil
currg = nil

selchgcounter = 1.5
-- bgimg = nil

function love.load(arg)
    gen_piece_images()

    field = Grid(8, 8)
    nextg = Grid(4, 1)
    currg = Grid(1, 1)

    field:select(1, 1)

    -- bgimg = love.graphics.newImage("assets/images/background_placeholder.jpg")

    love.keyboard.setKeyRepeat(false)

    field:set(3, 3, Piece(bit.bor(PIECE_DEST, PIPE_DOWN)))
    -- field:set(3, 3, Piece(bit.bor(PIECE_DEST, PIPE_CROSS)))
    field:set(7, 5, Piece(bit.bor(PIECE_SRC, PIPE_LEFT)))
    currg:set(1, 1, Piece(bit.bor(PIECE_PIPE, PIPE_VERTICAL)))
    nextg:set(1, 1, Piece(bit.bor(PIECE_PIPE, PIPE_ANGLE_LEFTDOWN)))
    nextg:set(2, 1, Piece(bit.bor(PIECE_PIPE, PIPE_CROSS)))
    nextg:set(3, 1, Piece(bit.bor(PIECE_PIPE, PIPE_ANGLE_UPRIGHT)))
    nextg:set(4, 1, Piece(bit.bor(PIECE_PIPE, PIPE_ANGLE_UPRIGHT)))
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
