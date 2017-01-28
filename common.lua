TILE_H = 64
TILE_W = 64

PIECE_NONE           = 0x0001
PIECE_PIPE           = 0x0002
PIECE_SPILL          = 0x0004

PIECE_SRC            = 0x1002
PIECE_DEST           = 0x2002

PIPE_UP              = 0x0010
PIPE_DOWN            = 0x0020
PIPE_RIGHT           = 0x0040
PIPE_LEFT            = 0x0080

PIPE_STRAIGHT        = 0x0102
PIPE_ANGLE           = 0x0202
PIPE_X               = 0x0402

PIPE_HORIZONTAL      = 0x01C2
PIPE_VERTICAL        = 0x0132
PIPE_CROSS           = 0x04F2
PIPE_ANGLE_LEFTUP    = 0x0292
PIPE_ANGLE_LEFTDOWN  = 0x02A2
PIPE_ANGLE_UPRIGHT   = 0x0252
PIPE_ANGLE_DOWNRIGHT = 0x0262

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
