require('common')
require('grid')
require('piece')
require('board')
require('math')
require('input')
require('menu')
if not pcall(function() bit = require('bit32') end) then
    bit = require('extern/numberlua')
end

debug = true

gb = nil
state = nil

bgimg = nil

bc = 0
flood = 30
currtimer = 30
tt = nil

function love.load(arg)
    math.randomseed(os.time())
    love.graphics.setBlendMode('alpha')
    gen_piece_images()

    love.window.setIcon(piece_images[PIECE_SRC]:newImageData())

    gb = board(8, 12)

    -- For some reason this breaks things.
    -- love.window.setMode(gb.sz.x, gb.sz.y)

    --bgimg = love.graphics.newImage('assets/images/background_placeholder.jpg')

    love.keyboard.setKeyRepeat(false)

    bc = love.timer.getTime()
    tt = love.graphics.newText(igfont_fxw, nil)

	temp = menu()
	temp:renderstart()
	state = 0
end

function love.keypressed(key, sc, rpt)
    btnpressed(key, sc, rpt, nil)
    proc_input(key, sc, nil, true)
end

function love.keyreleased(key, sc)
    proc_input(key, sc, nil, false)
end

function love.gamepadpressed(js, btn)
    btnpressed(nil, nil, nil, btn)
    proc_input(nil, nil, btn, true)
end

function love.gamepadreleased(js, btn)
    proc_input(nil, nil, btn, false)
end

function btnpressed(key, sc, rpt, btn)
    if key == 'left' or sc == 'a' or btn == 'dpleft' then
        gb:movsel(DIR_LEFT)
    end
    if key == 'right' or sc == 'd' or btn == 'dpright' then
        gb:movsel(DIR_RIGHT)
    end

    if key == 'up' or sc == 'w' or btn == 'dpup' then
        if state == 0 then
			temp:movesel("up")
		elseif state == 1 then
			gb:movsel(DIR_UP)
		end
    end
    if key == 'down' or sc == 's' or btn == 'dpdown' then
		if state == 0 then
			temp:movesel("down")
		elseif state == 1 then
			gb:movsel(DIR_DOWN)
		end
    end

    -- TODO: Drop this input if directional button pressed
    if sc == 'return' or sc == 'e' or sc == 'space' or btn == 'a' then
        if state == 0 then
			state = temp:movesel("return")
		elseif state == 1 then
			gb:play()
		end
    end

    -- TODO: make this do stuff
    if sc == 'escape' or btn == 'start' then
        if state == 1 then
            state = 0
            temp:renderpause()
        end
    end

end

function love.update(dt)
    if state == 1 then
        if input_state.x ~= 0 then
            currtimer = currtimer - dt*20
        else
            --currtimer = currtimer - dt
        end
    end
    if currtimer > 0 then
        tt:set(string.format('%05.2f', currtimer))
    elseif state == 1 then
        tt:set(string.format('%05.2f', 0.0))
        gostate = gb:drip(dt)
        if gostate == GAME_OVER_LOSE then
            state = 0
            temp:rendergameover()
        elseif gostate == GAME_OVER_WIN then
            state = 0
            temp:rendervictory()
        end
    end
    if state == 3 then
        gb = board(8, 12)
        state = 1
    end
end

function love.draw(dt)
    love.graphics.setBackgroundColor(colors.game_bg)
    love.graphics.clear()
	if state == 0 then
		love.graphics.draw(temp.base)
	elseif state == 1 then
        -- love.graphics.draw(bgimg, 0, 0)
		love.graphics.draw(gb.canvas)
		love.graphics.draw(tt, 12 + TILE_W, gb.sz.y - (6 + TILE_H))
	elseif state == 2 then
		os.exit()
	end
end
