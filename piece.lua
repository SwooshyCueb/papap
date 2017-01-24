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
        love.graphics.setCanvas(self.basecanvas)
            love.graphics.clear()
            love.graphics.setBlendMode("alpha")
            love.graphics.setLineWidth(2)
            love.graphics.setColor(190, 190, 190, 210)
            love.graphics.rectangle("fill", 0, 0, TILE_W, TILE_H)
            love.graphics.setColor(40, 40, 40, 255)
            love.graphics.rectangle("line", 0, 0, TILE_W, TILE_H)

            if bit.band(self.type, PIECE_DEST) ~= 0 then
                love.graphics.setLineWidth(2)
                love.graphics.setColor(215, 215, 215, 255)
                love.graphics.rectangle("fill", TILE_W/5, TILE_H/5, TILE_W*3/5, TILE_H*3/5)
                love.graphics.setColor(40, 40, 40, 255)
                love.graphics.rectangle("line", TILE_W/5, TILE_H/5, TILE_W*3/5, TILE_H*3/5)
                love.graphics.setColor(70, 70,  70, 255)
                love.graphics.rectangle("fill", TILE_W*06/20, TILE_H*06/20, TILE_W*3/20, TILE_H*3/20)
                love.graphics.rectangle("fill", TILE_W*11/20, TILE_H*06/20, TILE_W*3/20, TILE_H*3/20)
                love.graphics.rectangle("fill", TILE_W*11/20, TILE_H*11/20, TILE_W*3/20, TILE_H*3/20)
                love.graphics.rectangle("fill", TILE_W*06/20, TILE_H*11/20, TILE_W*3/20, TILE_H*3/20)
                love.graphics.setColor(40, 40, 40, 255)
                love.graphics.rectangle("line", TILE_W*06/20, TILE_H*06/20, TILE_W*3/20, TILE_H*3/20)
                love.graphics.rectangle("line", TILE_W*11/20, TILE_H*06/20, TILE_W*3/20, TILE_H*3/20)
                love.graphics.rectangle("line", TILE_W*11/20, TILE_H*11/20, TILE_W*3/20, TILE_H*3/20)
                love.graphics.rectangle("line", TILE_W*06/20, TILE_H*11/20, TILE_W*3/20, TILE_H*3/20)
            end

            if bit.band(self.type, PIECE_SRC) ~= 0 then
                love.graphics.setLineWidth(2)
                love.graphics.setColor(215, 215, 215, 255)
                love.graphics.circle("fill", TILE_W/2, TILE_H/2, TILE_W*9/32)
                love.graphics.setColor(40, 40, 40, 255)
                love.graphics.circle("line", TILE_W/2, TILE_H/2, TILE_W*9/32)
            end

        love.graphics.setCanvas()
    end
end

function Piece:renderstg2()
    if bit.band(self.type, PIECE_NONE) == 0 then
        love.graphics.setCanvas(self.canvas)
            love.graphics.clear()
            love.graphics.setBlendMode("alpha")
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(self.basecanvas)
        love.graphics.setCanvas()
    end
end

function Piece:render()
    self:renderstg1()
    self:renderstg2()
end
