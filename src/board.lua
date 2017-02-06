require('common')
require('grid')
require('piece')
require('colors')
require('input')
require('extern/class')

drip_interval = 0.25
drip_interval_fast = 0.0125


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
    dest = Piece(bit.bor(PIPE_DEST, PIPE_CROSS))
    -- difficulty can be increased by reducing the number of entry points for the dest

    -- Place dest piece
    self.field:set(dx, dy, dest)

    -- Choose direction of source
    repeat
        sdir = pdirections[math.random(1, table.getn(pdirections))]
        -- difficulty can be increased by having more than one direction

        -- ensure we're not going straight into a wall
        i = true
        if (sx == 1) and (bit.band(sdir, PIPE_LEFT) ~= 0) then
            i = false
        elseif (sx == x) and (bit.band(sdir, PIPE_RIGHT) ~= 0) then
            i = false
        end
        if (sy == 1) and (bit.band(sdir, PIPE_UP) ~= 0) then
            i = false
        elseif (sy == x) and (bit.band(sdir, PIPE_DOWN) ~= 0) then
            i = false
        end
    until i

    -- Generate source piece
    src = Piece(bit.bor(PIPE_SRC, sdir))

    -- Place source piece
    self.field:set(sx, sy, src)

    self.sourceloc = {x = sx, y = sy}

    -- Fill tray
    self.currg:set(1, 1, get_random_pipe())
    self.nextg:set(1, 1, get_random_pipe())
    self.nextg:set(2, 1, get_random_pipe())
    self.nextg:set(3, 1, get_random_pipe())
    self.nextg:set(4, 1, get_random_pipe())

    self.canvas = love.graphics.newCanvas(w, h)

    self.lastdrip = 0
    self.currdrips = {self.sourceloc}
    --self.currdrip = self.sourceloc

    self:render()
end

function board:render()
    love.graphics.setCanvas(self.canvas)
        love.graphics.setBackgroundColor(colors.invis)
        love.graphics.clear()
        love.graphics.setLineWidth(2)
        love.graphics.draw(self.field.canvas)
        love.graphics.draw(self.currg.canvas, 0, 8+(self.field.sz.y*TILE_H))
        love.graphics.draw(self.nextg.canvas, ((self.field.sz.x - 4)*TILE_W), 8+(self.field.sz.y*TILE_H))
    love.graphics.setCanvas()
end

function board:movsel(dir)
    sel = self.field.selected

    if bit.band(dir, DIR_UP) ~= 0 and (sel.y ~= 1) then
        sel.y = sel.y - 1
    elseif bit.band(dir, DIR_DOWN) ~= 0 and (sel.y ~= self.field.sz.y) then
        sel.y = sel.y + 1
    end

    if bit.band(dir, DIR_LEFT) ~= 0 and (sel.x ~= 1) then
        sel.x = sel.x - 1
    elseif bit.band(dir, DIR_RIGHT) ~= 0 and (sel.x ~= self.field.sz.x) then
        sel.x = sel.x + 1
    end

    self.field:select(sel.x, sel.y)

    self:render()

end

function board:play()
    sel = self.field.selected

    -- Make sure there's not already a piece here
    ovr = self.field:get(sel.x, sel.y)
    if bit.band(ovr.type, PIECE_NONE) == 0 or bit.band(ovr.type, PIECE_SPILL) ~= 0 then
        return
    end

    self.field:set(sel.x, sel.y, self.currg:get(1, 1))
    self.currg:set(1, 1, self.nextg:get(1, 1))
    self.nextg:set(1, 1, self.nextg:get(2, 1))
    self.nextg:set(2, 1, self.nextg:get(3, 1))
    self.nextg:set(3, 1, self.nextg:get(4, 1))
    self.nextg:set(4, 1, get_random_pipe())

    self:render()

end

function board:drip(dt)
    self.lastdrip = self.lastdrip + dt
    if input_state.x ~= 0 then
        if (self.lastdrip < drip_interval_fast) then
            return
        end
    elseif (self.lastdrip < drip_interval) then
        return
    end
    self.lastdrip = 0

    -- TODO: support split drips
    -- TODO: handle running into walls

    i = 1
    repeat
        currdrip = self.currdrips[i]

        dr = self.field:drip(currdrip.x, currdrip.y)
        i = i + 1

        if dr == 0 then
            self:render()
            -- this pipe isn't full yet
            return
        end

        table.remove(self.currdrips, i)
        i = i - 1

        if bit.band(dr, DIR_UP) ~= 0 and (currdrip.y ~= 1) then
            newdrip = {x = currdrip.x, y = currdrip.y - 1}
            self.field:drip(newdrip.x, newdrip.y, DIR_DOWN)
            table.insert(self.currdrips, 1, newdrip)
            i = i + 1
        end
        if bit.band(dr, DIR_DOWN) ~= 0 and (currdrip.y ~= self.field.sz.y) then
            newdrip = {x = currdrip.x, y = currdrip.y + 1}
            self.field:drip(newdrip.x, newdrip.y, DIR_UP)
            table.insert(self.currdrips, 1, newdrip)
            i = i + 1
        end
        if bit.band(dr, DIR_LEFT) ~= 0 and (currdrip.x ~= 1) then
            newdrip = {x = currdrip.x - 1, y = currdrip.y}
            self.field:drip(newdrip.x, newdrip.y, DIR_RIGHT)
            table.insert(self.currdrips, 1, newdrip)
            i = i + 1
        end
        if bit.band(dr, DIR_RIGHT) ~= 0 and (currdrip.x ~= self.field.sz.x) then
            newdrip = {x = currdrip.x + 1, y = currdrip.y}
            self.field:drip(newdrip.x, newdrip.y, DIR_LEFT)
            table.insert(self.currdrips, 1, newdrip)
            i = i + 1
        end

    until i > table.getn(self.currdrips)


end
