function love.load()
    multouch = require("libs/multouch")
    touches = multouch.new()
    textureSize = 1
    textureTest = love.graphics.newImage('assets/images/testImage.png')
end

function love.draw()
    love.graphics.draw(textureTest, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, textureSize, textureSize. textureTest:getWidth()/2, textureTest:getHeight()/2)
end

function love.update(deltaTime)
    textureSize = touches:pinch(0, textureSize, 2)
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