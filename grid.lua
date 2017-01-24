require('common')
require('extern/class')

Grid = class()
function Grid:init(sz_x, sz_y)
    self.sz = {x = sz_x, y = sz_y}
    self.selected = {x = 0, y = 0}
    self.map = {}
    for xpos = 0, self.sz.x-1 do
        self.map[xpos] = {}
        for ypos = 0, self.sz.y-1 do
            self.map[xpos][ypos] = PIECE_NONE
        end
    end

    self.basecanvas = love.graphics.newCanvas(self.sz.x*TILE_W, self.sz.y*TILE_H)
    self.canvas = love.graphics.newCanvas(self.sz.x*TILE_W, self.sz.y*TILE_H)
    self:render()

end
function Grid:select(x, y)
    self.selected.x = x
    self.selected.y = y
    self:render()
end
function Grid:render()
    love.graphics.setCanvas(self.basecanvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(255, 255, 255, 255)
        for xpos = 0, self.sz.x-1 do
            for ypos = 0, self.sz.y-1 do
                love.graphics.rectangle("line", xpos*TILE_W, ypos*TILE_H, TILE_W, TILE_H)
            end
        end
    love.graphics.setCanvas()

    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self.basecanvas)
        if (self.selected.x*self.selected.y) ~= 0 then
            love.graphics.setColor(184, 184, 0, 184)
            love.graphics.rectangle("line", (self.selected.x-1)*TILE_W, (self.selected.y-1)*TILE_H, TILE_W, TILE_H)
            love.graphics.setColor(255, 255, 255, 255)
        end
    love.graphics.setCanvas()
end
