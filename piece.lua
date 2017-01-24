require('common')
require('extern/class')
if not pcall(function() require('bit32') end) then
    require('extern/numberlua')
end

Piece = class()
function Piece:init(type)
    self.type = type
    self.filled = 0
    self.basecanvas = love.graphics.newCanvas(TILE_W, TILE_H)
    self.canvas = love.graphics.newCanvas(TILE_W, TILE_H)
end

function Piece:renderstg1()
    if not bit32.band(self.type, PIECE_NONE) then
        love.graphics.setCanvas(self.basecanvas)
            love.graphics.clear()
            love.graphics.setBlendMode("alpha")
            love.graphics.setLineWidth(2)
            love.graphics.setColor(190, 190, 190, 210)
            love.graphics.rectangle("fill", 0, 0, TILE_W, TILE_H)
            love.graphics.setColor(90, 90, 90, 255)
            love.graphics.rectangle("line", 0, 0, TILE_W, TILE_H)
        love.graphics.setCanvas()
    end
end

function Piece:renderstg2()
    if not bit32.band(self.type, PIECE_NONE) then
        love.graphics.setCanvas(self.canvas)
            love.graphics.clear()
            love.graphics.setBlendMode("alpha")
            love.graphics.draw(self.basecanvas)
        love.graphics.setCanvas()
    end
end

function Grid:render()
    self:renderstg1()
    self:renderstg2()
end
