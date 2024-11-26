function love.load()
    multouch = require("libs/multouch")
    touches = multouch.new()
    
    snake = {
        body = { { 8, 8 }, { 7, 8 }, { 6, 8 } },
        direction = 'right',
        alive = true
    }
    map = {}
    for y = 1, 16, 1 do
        map[y] = {}
        for x = 1, 16, 1 do
            map[y][x] = 0 -- no apple
        end
    end
    for i, part in pairs(snake.body) do
        map[part[1]][part[2]] = -1 -- snake 
    end

    local canPlaceApple = {}
    for y = 1, 16, 1 do
        for x = 1, 16, 1 do
            if map[y][x] ~= -1 then
                table.insert(canPlaceApple, { x, y })
            end
        end
    end
    local applePosition = love.math.random(1. #canPlaceApple)
    local newAppleX, newAppleY = canPlaceApple[applePosition][1], canPlaceApple[applePosition][2]
    map[newAppleY][newAppleX] = 1 -- apple
end

function love.draw()
    love.graphics.rectangle('line', love.graphics.getWidth()/2 - 8*32, love.graphics.getHeight()/2 - 8*32, 16*32, 16*32)
    for i, part in pairs(snake.body) do
        love.graphics.rectangle('fill', love.graphics.getWidth()/2 - 8*32 + part[1]*32, love.graphics.getHeight()/2 - 8*32 + part[2]*32, 32, 32)
    end
    if not snake.alive then
        local currentFont = love.graphics.getFont()

        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle('line', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("Game over", love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 1, 1, currentFont:getWidth("Game over")/2, currentFont:getHeight(" ")/2)
    end
end

function love.update(deltaTime)
    if not snake.alive then
        return
    end

    snake.direction = touches:swipe() ~= 'none' and touches:swipe() or snake.direction
    local lastBodyPositionX, lastBodyPositionY =  snake.body[1], snake.body[2]

    if snake.direction == 'left' then
        snake.body[1][1] = snake.body[1][2] - 1
    elseif snake.direction == 'up' then
        snake.body[1][2] = snake.body[1][2] - 1
    elseif snake.direction == 'right' then
        snake.body[1][1] = snake.body[1][1] + 1 
    elseif snake.direction == 'down' then
        snake.body[1][2] = snake.body[1][2] + 1
    end

    if map[snake.body[1][1]][snake.body[1][1]] == 1 then
        table.insert(snake.body, { snake.body[#snake.body][1], snake.body[#snake.body][2] })
    elseif map[snake.body[1][1]][snake.body[1][1]] == -1 then
        snake.alive = false
    elseif snake.body[1][1] > 16 then
        snake.body[1][1] = 1
    elseif snake.body[1][2] > 16 then
        snake.body[1][2] = 1
    end

    for i, part in ipairs(snake.body) do
        local newPositionX, newPositionY = lastBodyPositionX, lastBodyPositionY
        lastBodyPositionX, lastBodyPositionY = part[1], part[2]
        part[1] = newPositionX
        part[2] = newPositionY
        map[part[1]][part[2]] = -1 -- snake 
    end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
    touches:touchpressed(id, x, y, dx, dy, pressure)
end

function love.touchmoved(id, x, y, dx, dy, pressure)
    touches:touchmoved(id, x, y, dx, dy, pressure)
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    touches:touchreleased(id, x, y, dx, dy, pressure)
end