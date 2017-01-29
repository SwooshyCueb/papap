TILE_H = 64
TILE_W = 64

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
