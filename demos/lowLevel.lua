function love.load()
    multouch = require("libs/multouch")
    touches = multouch.new()
end

function love.draw()
    touches:display()
end

function love.update()
    for i, touch in ipairs(touches:getTouches()) do
        local id, x, y, dx, dy, pressure = touches:update(touch)
        print("Touch", i, x, y, dx, dy, pressure)
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