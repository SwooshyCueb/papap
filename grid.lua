require('common')

grid = class()
function grid:init(sz_x, sz_y)
    self.sz = {x = sz_x, y = sz_y}
    self.map = {}
    for xpos = 0, self.sz.x do
        self.map[xpos] = {}
        for ypos = 0, self.sz.y do
            self.map[xpos][ypos] = PIPE_NONE
        end
    end
end
