function love.load()
    multouch = require("libs/multouch")
    touches = multouch.new()
    touches:registerArea('leftside', 0, 0, love.graphics.getWidth()/2, love.graphics.getHeight())
    touches:registerArea('rightside', love.graphics.getWidth()/2, 0, love.graphics.getWidth()/2, love.graphics.getHeight())
end

function love.update(deltaTime)
    if touches:isHit('leftside') then
        print("left:", touches:getTouchesInArea('left'))
    elseif touches:isHit('rightside') then
        print("right:", touches:getTouchesInArea('right'))
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