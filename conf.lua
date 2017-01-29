-- Configuration
function love.conf(game)
    game.title = 'GAME_NAME_PRETTY'
    game.identity = 'GAME_NAME_IDSTR'
    game.version = '0.10.2'
    -- game.window.width = 528
    game.window.width = 1600
    -- game.window.height = 600
    game.window.height = 700
    game.window.resizable = false
    game.window.fullscreen = false
    game.window.vsync = false

    -- debugging
    game.console = true

    -- we (probably) won't need physics
    game.modules.physics = false

    -- mouse/touchscreen support is not currently a priority
    game.modules.mouse = false
    game.modules.touch = false

    -- game.window.icon =
end
