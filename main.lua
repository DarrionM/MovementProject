function love.load()
    anim8 = require 'Libraries/anim8'
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- player object
    player = {}
    player.x = 50
    player.y = 70
    player.speed = 2
    player.spriteSheet = love.graphics.newImage('Sprites/spritesheet.png')
    player.grid = anim8.newGrid(32, 32, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
    player.animations = {}
    player.animations.idle = anim8.newAnimation(player.grid('1-10', 1), 0.2)

    background = love.graphics.newImage('Sprites/background.jpg')
end

-- love.update runs every frame
function love.update(dt)
    -- store booleans after first calculation to optimize performance
    right = (love.keyboard.isDown("right") or love.keyboard.isDown("d"))
    left = (love.keyboard.isDown("left") or love.keyboard.isDown("a"))
    up = (love.keyboard.isDown("up") or love.keyboard.isDown("w"))
    down = (love.keyboard.isDown("down") or love.keyboard.isDown("s"))

    -- normalize speed vector when moving in multiple directions by
    -- rearranging pythagorean theorem (x^2 + y^2 = diagonalMovement^2)
    speed_diag = math.sqrt((player.speed ^ 2 ) / 2)

    if right and up then
        player.x = player.x + speed_diag
        player.y = player.y - speed_diag
    elseif left and up then
        player.x = player.x - speed_diag
        player.y = player.y - speed_diag
    elseif right and down then
        player.x = player.x + speed_diag
        player.y = player.y + speed_diag
    elseif left and down then
        player.x = player.x - speed_diag
        player.y = player.y + speed_diag
    elseif right then
        player.x = player.x + player.speed
    elseif left then
        player.x = player.x - player.speed
    elseif up then
        player.y = player.y - player.speed
    elseif down then
        player.y = player.y + player.speed
    end

function width()
    return 100
    -- update idle animation each frame using deltaTime (dt)
    player.animations.idle:update(dt) 
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    player.animations.idle:draw(player.spriteSheet, player.x, player.y, nil, 2.25)
end