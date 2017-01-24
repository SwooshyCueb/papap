require('common')
require('extern/class')
require('piece')
if not pcall(function() bit =  require('bit32') end) then
    bit = require('extern/numberlua')
end

Grid = class()
function Grid:init(sz_x, sz_y)
    self.sz = {x = sz_x, y = sz_y}
    self.selected = {x = 0, y = 0}
    self.map = {}
    for xpos = 0, self.sz.x-1 do
        self.map[xpos] = {}
        for ypos = 0, self.sz.y-1 do
            self.map[xpos][ypos] = Piece(PIECE_NONE)
        end
    end

    self.basecanvas = love.graphics.newCanvas(self.sz.x*TILE_W, self.sz.y*TILE_H)
    self.pipecanvas = love.graphics.newCanvas(self.sz.x*TILE_W, self.sz.y*TILE_H)
    self.canvas = love.graphics.newCanvas(self.sz.x*TILE_W, self.sz.y*TILE_H)
    self:render()

end

function Grid:select(x, y)
    if x == -1 then
    elseif x > self.sz.x then
        self.selected.x = self.sz.x
    elseif x < 1 then
        self.selected.x = 1
    else
        self.selected.x = x
    end

    if y == -1 then
    elseif y > self.sz.y then
        self.selected.y = self.sz.y
    elseif y < 1 then
        self.selected.y = 1
    else
        self.selected.y = y
    end

    self:renderstg3()
end

function Grid:set(x, y, piece)
    self.map[x-1][y-1] = piece
    self:renderstg2()
    self:renderstg3()
end

function Grid:renderstg1()
    love.graphics.setCanvas(self.basecanvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setLineWidth(1)
        for xpos = 0, self.sz.x-1 do
            for ypos = 0, self.sz.y-1 do
                love.graphics.setColor(0, 0, 0, 130)
                love.graphics.rectangle("fill", xpos*TILE_W, ypos*TILE_H, TILE_W, TILE_H)
                love.graphics.setColor(255, 255, 255, 255)
                love.graphics.rectangle("line", xpos*TILE_W, ypos*TILE_H, TILE_W, TILE_H)
            end
        end
    love.graphics.setCanvas()
end

function Grid:renderstg2()
    love.graphics.setCanvas(self.pipecanvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self.basecanvas)
        for xpos = 0, self.sz.x-1 do
            for ypos = 0, self.sz.y-1 do
                if bit.band(self.map[xpos][ypos].type, PIECE_NONE) == 0 then
                    love.graphics.draw(self.map[xpos][ypos].canvas, xpos*TILE_W, ypos*TILE_H)
                end
            end
        end
    love.graphics.setCanvas()
end

function Grid:renderstg3()
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self.pipecanvas)
        love.graphics.setLineWidth(3)
        if (self.selected.x*self.selected.y) ~= 0 then
            love.graphics.setColor(184, 184, 0, 184)
            love.graphics.rectangle("line", (self.selected.x-1)*TILE_W, (self.selected.y-1)*TILE_H, TILE_W, TILE_H)
            love.graphics.setColor(255, 255, 255, 255)
        end
    love.graphics.setCanvas()
end

function Grid:render()
    self:renderstg1()
    self:renderstg2()
    self:renderstg3()
end
