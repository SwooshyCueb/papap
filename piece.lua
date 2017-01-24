require('common')
require('extern/class')
if not pcall(function() bit =  require('bit32') end) then
    bit = require('extern/numberlua')
end

Piece = class()
function Piece:init(type)
    self.type = type
    self.filled = 0
    self.basecanvas = love.graphics.newCanvas(TILE_W, TILE_H)
    self.canvas = love.graphics.newCanvas(TILE_W, TILE_H)
    self:render()
end

function Piece:renderstg1()
    if bit.band(self.type, PIECE_NONE) == 0 then
        print("renderpipe")
        love.graphics.setCanvas(self.basecanvas)
            love.graphics.clear()
            love.graphics.setBlendMode("alpha")
            love.graphics.setLineWidth(2)
            love.graphics.setColor(190, 190, 190, 210)
            love.graphics.rectangle("fill", 0, 0, TILE_W, TILE_H)
            love.graphics.setColor(40, 40, 40, 255)
            love.graphics.rectangle("line", 0, 0, TILE_W, TILE_H)
        love.graphics.setCanvas()
    end
end

function Piece:renderstg2()
    if bit.band(self.type, PIECE_NONE) == 0 then
        love.graphics.setCanvas(self.canvas)
            love.graphics.clear()
            love.graphics.setBlendMode("alpha")
            love.graphics.draw(self.basecanvas)
        love.graphics.setCanvas()
    end
end

function Piece:render()
    self:renderstg1()
    self:renderstg2()
end
