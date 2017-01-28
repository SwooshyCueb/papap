require('common')
require('grid')
require('piece')
require('colors')
require('extern/class')


board = class()
function board:init(x, y)
    x = x or 8
    y = y or 8

    self.field = Grid(x, y)
    self.nextg = Grid(4, 1)
    self.currg = Grid(1, 1)

    self.field:select(1, 1)

    h = 0
    w = 0

    -- Field
    w = w + 8 + x*TILE_W + 8
    h = h + 8 + y*TILE_H + 8
    -- "Tray"
    h = h + 8 + TILE_H + 8

    self.sz = {x = w, y = h}

    -- Temporary
    self.field:set(3, 3, Piece(bit.bor(PIECE_DEST, PIPE_DOWN)))
    self.field:set(7, 5, Piece(bit.bor(PIECE_SRC, PIPE_LEFT)))

    -- Fill tray
    self.currg:set(1, 1, get_random_pipe())
    self.nextg:set(1, 1, get_random_pipe())
    self.nextg:set(2, 1, get_random_pipe())
    self.nextg:set(3, 1, get_random_pipe())
    self.nextg:set(4, 1, get_random_pipe())

    self.canvas = love.graphics.newCanvas(w, h)

    self:render()
end

function board:render()
    love.graphics.setCanvas(self.canvas)
        love.graphics.draw(self.field.canvas, 8, 8)
        love.graphics.draw(self.currg.canvas, 8, 16+(self.field.sz.y*TILE_H))
        love.graphics.draw(self.nextg.canvas, 8+((self.field.sz.x - 4)*TILE_W), 16+(self.field.sz.y*TILE_H))
    love.graphics.setCanvas()
end

-- TODO: replace this with relative cursor movement
function board:select(x, y)
    self.field:select(x, y)
    self:render()
end

