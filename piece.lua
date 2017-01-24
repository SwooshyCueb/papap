require('common')
require('extern/class')
require('math')
require('colors')
if not pcall(function() bit =  require('bit32') end) then
    bit = require('extern/numberlua')
end

piece_images = {}

Piece = class()
function Piece:init(type)
    self.type = type
    self.filled = 0
    self.canvas = love.graphics.newCanvas(TILE_W, TILE_H)
    self:render()
end

function Piece:render()
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        if bit.band(self.type, PIECE_NONE) == PIECE_NONE then
            love.graphics.setCanvas()
            return
        end

        love.graphics.clear()
        love.graphics.setLineWidth(2)
        love.graphics.setColor(colors.tile_bg)
            love.graphics.rectangle("fill", 0, 0, TILE_W, TILE_H)
        love.graphics.setColor(colors.tile_border)
            love.graphics.rectangle("line", 0, 0, TILE_W, TILE_H)
        love.graphics.setColor(colors.default)

        if bit.band(self.type, PIECE_DEST) == PIECE_DEST then
            love.graphics.draw(piece_images[PIECE_DEST])

            if bit.band(self.type, PIPE_DOWN) ~= 0 then
                love.graphics.setColor(colors.pipe_inside)
                    love.graphics.rectangle('fill', TILE_W*7/16, TILE_H*3/4, TILE_W*1/8, TILE_H*1/4)
                love.graphics.setColor(colors.pipe_outside)
                    love.graphics.setLineWidth(2)
                    love.graphics.line(TILE_W*7/16, TILE_H*3/4, TILE_W*7/16, TILE_H)
                    love.graphics.line(TILE_W*9/16, TILE_H*3/4, TILE_W*9/16, TILE_H)
                love.graphics.setColor(colors.default)
            end

            if bit.band(self.type, PIPE_UP) ~= 0 then
                love.graphics.setColor(colors.pipe_inside)
                    love.graphics.rectangle('fill', TILE_W*7/16, 0, TILE_W*1/8, TILE_H*1/4)
                love.graphics.setColor(colors.pipe_outside)
                    love.graphics.setLineWidth(2)
                    love.graphics.line(TILE_W*7/16, 0, TILE_W*7/16, TILE_H*1/4)
                    love.graphics.line(TILE_W*9/16, 0, TILE_W*9/16, TILE_H*1/4)
                love.graphics.setColor(colors.default)
            end

            if bit.band(self.type, PIPE_LEFT) ~= 0 then
                love.graphics.setColor(colors.pipe_inside)
                    love.graphics.rectangle('fill', 0, TILE_H*7/16, TILE_W*1/4, TILE_H*1/8)
                love.graphics.setColor(colors.pipe_outside)
                    love.graphics.setLineWidth(2)
                    love.graphics.line(0, TILE_H*7/16, TILE_W*1/4, TILE_H*7/16)
                    love.graphics.line(0, TILE_H*9/16, TILE_W*1/4, TILE_H*9/16)
                love.graphics.setColor(colors.default)
            end

            if bit.band(self.type, PIPE_RIGHT) ~= 0 then
                love.graphics.setColor(colors.pipe_inside)
                    love.graphics.rectangle('fill', TILE_W*3/4, TILE_H*7/16, TILE_W*1/4, TILE_H*1/8)
                love.graphics.setColor(colors.pipe_outside)
                    love.graphics.setLineWidth(2)
                    love.graphics.line(TILE_W*3/4, TILE_H*7/16, TILE_W, TILE_H*7/16)
                    love.graphics.line(TILE_W*3/4, TILE_H*9/16, TILE_W, TILE_H*9/16)
                love.graphics.setColor(colors.default)
            end
        elseif bit.band(self.type, PIECE_PIPE) == PIECE_PIPE then
            if bit.band(self.type, PIPE_DOWN) ~= 0 then
                love.graphics.setColor(colors.pipe_inside)
                    love.graphics.rectangle('fill', TILE_W*7/16, TILE_H*7/16, TILE_W*1/8, TILE_H*9/16)
                love.graphics.setColor(colors.pipe_outside)
                    love.graphics.setLineWidth(2)
                    love.graphics.line(TILE_W*7/16, TILE_H*9/16, TILE_W*7/16, TILE_H)
                    love.graphics.line(TILE_W*9/16, TILE_H*9/16, TILE_W*9/16, TILE_H)
                love.graphics.setColor(colors.default)
            end

            if bit.band(self.type, PIPE_UP) ~= 0 then
                love.graphics.setColor(colors.pipe_inside)
                    love.graphics.rectangle('fill', TILE_W*7/16, 0, TILE_W*1/8, TILE_H*9/16)
                love.graphics.setColor(colors.pipe_outside)
                    love.graphics.setLineWidth(2)
                    love.graphics.line(TILE_W*7/16, 0, TILE_W*7/16, TILE_H*7/16)
                    love.graphics.line(TILE_W*9/16, 0, TILE_W*9/16, TILE_H*7/16)
                love.graphics.setColor(colors.default)
            end

            if bit.band(self.type, PIPE_LEFT) ~= 0 then
                love.graphics.setColor(colors.pipe_inside)
                    love.graphics.rectangle('fill', 0, TILE_H*7/16, TILE_W*9/16, TILE_H*1/8)
                love.graphics.setColor(colors.pipe_outside)
                    love.graphics.setLineWidth(2)
                    love.graphics.line(0, TILE_H*7/16, TILE_W*7/16, TILE_H*7/16)
                    love.graphics.line(0, TILE_H*9/16, TILE_W*7/16, TILE_H*9/16)
                love.graphics.setColor(colors.default)
            end

            if bit.band(self.type, PIPE_RIGHT) ~= 0 then
                love.graphics.setColor(colors.pipe_inside)
                    love.graphics.rectangle('fill', TILE_W*7/16, TILE_H*7/16, TILE_W*9/16, TILE_H*1/8)
                love.graphics.setColor(colors.pipe_outside)
                    love.graphics.setLineWidth(2)
                    love.graphics.line(TILE_W*9/16, TILE_H*7/16, TILE_W, TILE_H*7/16)
                    love.graphics.line(TILE_W*9/16, TILE_H*9/16, TILE_W, TILE_H*9/16)
                love.graphics.setColor(colors.default)
            end

            if bit.band(self.type, bit.bor(PIPE_DOWN, PIPE_UP)) ~= 0 then
                love.graphics.setColor(colors.pipe_outside)
                    if bit.band(self.type, PIPE_LEFT) == 0 then
                        love.graphics.line(TILE_W*7/16, TILE_H*9/16, TILE_W*7/16, TILE_H*7/16)
                    end
                    if bit.band(self.type, PIPE_RIGHT) == 0 then
                        love.graphics.line(TILE_W*9/16, TILE_H*9/16, TILE_W*9/16, TILE_H*7/16)
                    end
                love.graphics.setColor(colors.default)
            end

            if bit.band(self.type, bit.bor(PIPE_LEFT, PIPE_RIGHT)) ~= 0 then
                love.graphics.setColor(colors.pipe_outside)
                    if bit.band(self.type, PIPE_UP) == 0 then
                        love.graphics.line(TILE_W*9/16, TILE_H*7/16, TILE_W*7/16, TILE_H*7/16)
                    end
                    if bit.band(self.type, PIPE_DOWN) == 0 then
                        love.graphics.line(TILE_W*9/16, TILE_H*9/16, TILE_W*7/16, TILE_H*9/16)
                    end
                love.graphics.setColor(colors.default)
            end

        end

        if bit.band(self.type, PIECE_SRC) == PIECE_SRC then
            love.graphics.draw(piece_images[PIECE_SRC])
        end

    love.graphics.setCanvas()
end

function gen_piece_images()

    piece_images[PIECE_DEST] = love.graphics.newCanvas(TILE_W, TILE_H)
    love.graphics.setCanvas(piece_images[PIECE_DEST])
        love.graphics.clear()
        love.graphics.setLineWidth(2)
        love.graphics.setColor(colors.drain_bg)
            love.graphics.rectangle("fill", TILE_W/5, TILE_H/5, TILE_W*3/5, TILE_H*3/5)
        love.graphics.setColor(colors.drain_lines)
            love.graphics.rectangle("line", TILE_W/5, TILE_H/5, TILE_W*3/5, TILE_H*3/5)
        love.graphics.setColor(colors.drain_holes)
            love.graphics.setBlendMode("replace")
                love.graphics.rectangle("fill", TILE_W*06/20, TILE_H*06/20, TILE_W*3/20, TILE_H*3/20)
                love.graphics.rectangle("fill", TILE_W*11/20, TILE_H*06/20, TILE_W*3/20, TILE_H*3/20)
                love.graphics.rectangle("fill", TILE_W*11/20, TILE_H*11/20, TILE_W*3/20, TILE_H*3/20)
                love.graphics.rectangle("fill", TILE_W*06/20, TILE_H*11/20, TILE_W*3/20, TILE_H*3/20)
            love.graphics.setBlendMode("alpha")
        love.graphics.setColor(colors.drain_lines)
            love.graphics.rectangle("line", TILE_W*06/20, TILE_H*06/20, TILE_W*3/20, TILE_H*3/20)
            love.graphics.rectangle("line", TILE_W*11/20, TILE_H*06/20, TILE_W*3/20, TILE_H*3/20)
            love.graphics.rectangle("line", TILE_W*11/20, TILE_H*11/20, TILE_W*3/20, TILE_H*3/20)
            love.graphics.rectangle("line", TILE_W*06/20, TILE_H*11/20, TILE_W*3/20, TILE_H*3/20)
        love.graphics.setColor(colors.default)
    love.graphics.setCanvas()

    piece_images[PIECE_SRC] = love.graphics.newCanvas(TILE_W, TILE_H)
    src_canvas_temp1 = love.graphics.newCanvas(TILE_W, TILE_H)

    love.graphics.setCanvas(src_canvas_temp1)
        inner_scale = 3/4
        love.graphics.clear()
        love.graphics.setLineWidth(2)

        love.graphics.stencil((function() love.graphics.circle("fill", TILE_W/2, TILE_H/2, (TILE_W*9/32)*inner_scale) end), "replace", 1, false)

        love.graphics.setColor(colors.invis)
            love.graphics.circle("fill", TILE_W/2, TILE_H/2, (TILE_W*9/32)*inner_scale)
        love.graphics.setColor(colors.faucet_lines)
            love.graphics.circle("line", TILE_W/2, TILE_H/2, (TILE_W*9/32)*inner_scale)
        love.graphics.setColor(colors.default)

        distance = (TILE_W*11/32)*inner_scale
        size = (TILE_W*1/10)*inner_scale

        love.graphics.setColor(colors.invis)
            love.graphics.setBlendMode("replace")
                love.graphics.circle("fill", TILE_W/2, (TILE_H/2)-distance, size)
                love.graphics.circle("fill", TILE_W/2, (TILE_H/2)+distance, size)
                love.graphics.circle("fill", (TILE_W/2)-distance, TILE_H/2, size)
                love.graphics.circle("fill", (TILE_W/2)+distance, TILE_H/2, size)
                love.graphics.circle("fill", (TILE_W/2)-(distance/math.sqrt(2)), (TILE_H/2)-(distance/math.sqrt(2)), size)
                love.graphics.circle("fill", (TILE_W/2)+(distance/math.sqrt(2)), (TILE_H/2)-(distance/math.sqrt(2)), size)
                love.graphics.circle("fill", (TILE_W/2)-(distance/math.sqrt(2)), (TILE_H/2)+(distance/math.sqrt(2)), size)
                love.graphics.circle("fill", (TILE_W/2)+(distance/math.sqrt(2)), (TILE_H/2)+(distance/math.sqrt(2)), size)
            love.graphics.setBlendMode("alpha")
        love.graphics.setColor(colors.default)
        love.graphics.setStencilTest("equal", 1)
            love.graphics.setColor(colors.faucet_lines)
                love.graphics.circle("line", TILE_W/2, (TILE_H/2)-distance, size)
                love.graphics.circle("line", TILE_W/2, (TILE_H/2)+distance, size)
                love.graphics.circle("line", (TILE_W/2)-distance, TILE_H/2, size)
                love.graphics.circle("line", (TILE_W/2)+distance, TILE_H/2, size)
                love.graphics.circle("line", (TILE_W/2)-(distance/math.sqrt(2)), (TILE_H/2)-(distance/math.sqrt(2)), size)
                love.graphics.circle("line", (TILE_W/2)+(distance/math.sqrt(2)), (TILE_H/2)-(distance/math.sqrt(2)), size)
                love.graphics.circle("line", (TILE_W/2)-(distance/math.sqrt(2)), (TILE_H/2)+(distance/math.sqrt(2)), size)
                love.graphics.circle("line", (TILE_W/2)+(distance/math.sqrt(2)), (TILE_H/2)+(distance/math.sqrt(2)), size)
            love.graphics.setColor(colors.default)
        love.graphics.setStencilTest()

        sp8 = math.sin(math.pi/8)*(TILE_W*9/32)*inner_scale
        cp8 = math.cos(math.pi/8)*(TILE_W*9/32)*inner_scale

        love.graphics.setColor(colors.faucet_lines)
            love.graphics.line(TILE_W/2, TILE_H/2, (TILE_W/2)-cp8, (TILE_H/2)-sp8)
            love.graphics.line(TILE_W/2, TILE_H/2, (TILE_W/2)-cp8, (TILE_H/2)+sp8)
            love.graphics.line(TILE_W/2, TILE_H/2, (TILE_W/2)+cp8, (TILE_H/2)-sp8)
            love.graphics.line(TILE_W/2, TILE_H/2, (TILE_W/2)+cp8, (TILE_H/2)+sp8)
            love.graphics.line(TILE_W/2, TILE_H/2, (TILE_W/2)-sp8, (TILE_H/2)-cp8)
            love.graphics.line(TILE_W/2, TILE_H/2, (TILE_W/2)-sp8, (TILE_H/2)+cp8)
            love.graphics.line(TILE_W/2, TILE_H/2, (TILE_W/2)+sp8, (TILE_H/2)-cp8)
            love.graphics.line(TILE_W/2, TILE_H/2, (TILE_W/2)+sp8, (TILE_H/2)+cp8)
        love.graphics.setColor(colors.default)


    love.graphics.setCanvas(piece_images[PIECE_SRC])
        outer_scale = 7/6
        love.graphics.clear()
        love.graphics.setLineWidth(2)

        love.graphics.stencil((function() love.graphics.circle("fill", TILE_W/2, TILE_H/2, (TILE_W*9/32)*outer_scale) end), "replace", 1, false)

        love.graphics.setColor(colors.faucet_fg)
            love.graphics.circle("fill", TILE_W/2, TILE_H/2, (TILE_W*9/32)*outer_scale)
        love.graphics.setColor(colors.faucet_lines)
            love.graphics.circle("line", TILE_W/2, TILE_H/2, (TILE_W*9/32)*outer_scale)
        love.graphics.setColor(colors.default)

        distance = (TILE_W*11/32)*outer_scale
        size = (TILE_W*1/10)*outer_scale

        love.graphics.setColor(colors.invis)
            love.graphics.setBlendMode("replace")
                love.graphics.circle("fill", TILE_W/2, (TILE_H/2)-distance, size)
                love.graphics.circle("fill", TILE_W/2, (TILE_H/2)+distance, size)
                love.graphics.circle("fill", (TILE_W/2)-distance, TILE_H/2, size)
                love.graphics.circle("fill", (TILE_W/2)+distance, TILE_H/2, size)
                love.graphics.circle("fill", (TILE_W/2)-(distance/math.sqrt(2)), (TILE_H/2)-(distance/math.sqrt(2)), size)
                love.graphics.circle("fill", (TILE_W/2)+(distance/math.sqrt(2)), (TILE_H/2)-(distance/math.sqrt(2)), size)
                love.graphics.circle("fill", (TILE_W/2)-(distance/math.sqrt(2)), (TILE_H/2)+(distance/math.sqrt(2)), size)
                love.graphics.circle("fill", (TILE_W/2)+(distance/math.sqrt(2)), (TILE_H/2)+(distance/math.sqrt(2)), size)
            love.graphics.setBlendMode("alpha")
        love.graphics.setColor(colors.default)
        love.graphics.setStencilTest("equal", 1)
            love.graphics.setColor(colors.faucet_lines)
                love.graphics.circle("line", TILE_W/2, (TILE_H/2)-distance, size)
                love.graphics.circle("line", TILE_W/2, (TILE_H/2)+distance, size)
                love.graphics.circle("line", (TILE_W/2)-distance, TILE_H/2, size)
                love.graphics.circle("line", (TILE_W/2)+distance, TILE_H/2, size)
                love.graphics.circle("line", (TILE_W/2)-(distance/math.sqrt(2)), (TILE_H/2)-(distance/math.sqrt(2)), size)
                love.graphics.circle("line", (TILE_W/2)+(distance/math.sqrt(2)), (TILE_H/2)-(distance/math.sqrt(2)), size)
                love.graphics.circle("line", (TILE_W/2)-(distance/math.sqrt(2)), (TILE_H/2)+(distance/math.sqrt(2)), size)
                love.graphics.circle("line", (TILE_W/2)+(distance/math.sqrt(2)), (TILE_H/2)+(distance/math.sqrt(2)), size)
            love.graphics.setColor(colors.default)
        love.graphics.setStencilTest()

        love.graphics.setBlendMode("replace")
            love.graphics.stencil((function() love.graphics.circle("fill", TILE_W/2, TILE_H/2, (TILE_W*9/32)*inner_scale) end), "replace", 1, false)
            love.graphics.setStencilTest("equal", 1)
                love.graphics.draw(src_canvas_temp1)
            love.graphics.setStencilTest()
        love.graphics.setBlendMode("alpha")

        love.graphics.setLineWidth(1.6)
        love.graphics.setColor(colors.faucet_fg)
            love.graphics.circle("fill", TILE_W/2, TILE_H/2, TILE_W*5/64)
        love.graphics.setColor(colors.faucet_lines)
            love.graphics.circle("line", TILE_W/2, TILE_H/2, TILE_W*5/64)
        love.graphics.setColor(colors.default)

    love.graphics.setCanvas()

end
