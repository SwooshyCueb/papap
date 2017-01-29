require('common')
require('grid')
require('piece')
require('board')
require('math')
if not pcall(function() bit = require('bit32') end) then
    bit = require('extern/numberlua')
end

debug = true

gb = nil

selchgcounter = 1.5
-- bgimg = nil

function love.load(arg)
    math.randomseed(os.time())
    love.graphics.setBlendMode('alpha')
    gen_piece_images()

    gb = board(16, 8)

    -- For some reason this breaks things.
    -- love.window.setMode(gb.sz.x, gb.sz.y)

    -- bgimg = love.graphics.newImage("assets/images/background_placeholder.jpg")

    love.keyboard.setKeyRepeat(false)


end

function love.keypressed(key, sc, rpt)
    btnpressed(key, sc, rpt, nil)
end

function love.gamepadpressed(js, btn)
    btnpressed(nil, nil, nil, btn)
end

function btnpressed(key, sc, rpt, btn)
    if key == 'left' or sc == 'a' or btn == "dpleft" then
        gb:movsel(DIR_LEFT)
    end
    if key == 'right' or sc == 'd' or btn == "dpright" then
        gb:movsel(DIR_RIGHT)
    end

    if key == 'up' or sc == 'w' or btn == "dpup" then
        gb:movsel(DIR_UP)
    end
    if key == 'down' or sc == 's' or btn == "dpdown" then
        gb:movsel(DIR_DOWN)
    end

    -- TODO: Drop this input if directional button pressed
    if sc == 'return' or sc == 'e' or sc == 'space' or btn == 'a' then
        gb:play()
    end

    -- TODO: make this do stuff
    if sc == 'escape' or btn == 'start' then
        -- Pause menu? Show controls? wat do
    end

end

function love.update(dt)

end

function love.draw(dt)
    -- love.graphics.draw(bgimg, 0, 0)

    love.graphics.draw(gb.canvas)

end
