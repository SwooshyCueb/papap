require('common')
require('extern/class')

Grid = class()
function Grid:init(sz_x, sz_y)
    self.sz = {x = sz_x, y = sz_y}
    self.map = {}
    for xpos = 0, self.sz.x-1 do
        self.map[xpos] = {}
        for ypos = 0, self.sz.y-1 do
            self.map[xpos][ypos] = PIECE_NONE
        end
    end

    self.canvas = love.graphics.newCanvas(self.sz.x*TILE_W, self.sz.y*TILE_H)
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(255, 255, 255, 255)
        for xpos = 0, self.sz.x-1 do
            for ypos = 0, self.sz.y-1 do
                love.graphics.rectangle("line", xpos*TILE_W, ypos*TILE_H, TILE_W, TILE_H)
            end
        end
    love.graphics.setCanvas()
end
