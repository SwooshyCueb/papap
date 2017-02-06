TILE_H = 48
TILE_W = 48

constraints = {
    field_sz = {
        x = {
            min = 6,
            max = 32 -- might increase this later
        },
        y = {
            min = 4,
            max = 32 -- might increase this later
        }
    }
}


DIR_UP              = 0x0010
DIR_DOWN            = 0x0020
DIR_RIGHT           = 0x0040
DIR_LEFT            = 0x0080

DIRMASK             = 0x00F0

GAME_OVER_LOSE      = 0x0001
GAME_OVER_WIN       = 0x0002

stdfont = love.graphics.newFont('assets/fonts/NovaSquare.ttf', 18)
titlefont = love.graphics.newFont('assets/fonts/NovaSquare.ttf', 28)
monofont = love.graphics.newFont('assets/fonts/NovaMono.ttf', 18)

function clamp(low, high, n) return math.min(math.max(n, low), high) end

function printf(s,...)
    return io.write(s:format(...))
end
