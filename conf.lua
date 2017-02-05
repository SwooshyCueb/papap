-- Configuration
function love.conf(game)
    game.title = 'pipes and pipes and pipes'
    game.identity = 'papap'
    game.version = '0.10.2'
    game.window.width = 400
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
