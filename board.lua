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

    -- Choose location of pieces
    repeat
        -- Choose location of dest
        dx = math.random(1, x)
        dy = math.random(1, y)

        -- Choose location of source
        sx = math.random(1, x)
        sy = math.random(1, y)

        -- Make sure they're not too close
    until ((sx - dx)^2 + (sy - dy)^2) > 2.5

    -- Generate dest piece
    dest = Piece(bit.bor(PIECE_DEST, PIPE_CROSS))
    -- difficulty can be increased by reducing the number of entry points for the dest

    -- Place dest piece
    self.field:set(dx, dy, dest)

    -- Choose direction of source
    repeat
        sdir = pdirections[math.random(1, table.getn(pdirections))]
        -- difficulty can be increased by having more than one direction

        -- ensure we're not going straight into a wall
        i = true
        if (sx == 1) and (bit.band(sdir, PIPE_LEFT) == PIPE_LEFT) then
            i = false
        elseif (sx == x) and (bit.band(sdir, PIPE_RIGHT) == PIPE_RIGHT) then
            i = false
        end
        if (sy == 1) and (bit.band(sdir, PIPE_UP) == PIPE_UP) then
            i = false
        elseif (sy == x) and (bit.band(sdir, PIPE_DOWN) == PIPE_DOWN) then
            i = false
        end
    until i

    -- Generate source piece
    src = Piece(bit.bor(PIECE_SRC, sdir))

    -- Place source piece
    self.field:set(sx, sy, src)

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

