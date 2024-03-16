
-- @todo: add a score system
-- @todo: add defeat condition

-- init the left pad
pad = {}
pad.x = 0
pad.y = 0
pad.width = 20
pad.height = 80

-- init the right pad
pad2 = {}
pad2.x = 780
pad2.y = 0
pad2.width = 20
pad2.height = 80

-- init the ball
ball = {}
ball.x = 400
ball.y = 300
ball.width = 20
ball.height = 20
ball.speedX = 2
ball.speedY = 2

function ballReset()
    -- center the ball on the screen
    ball.x = love.graphics.getWidth() / 2
    ball.x = ball.x - ball.width / 2
    ball.y = love.graphics.getHeight() / 2
    ball.y = ball.y - ball.height / 2
end

function love.load()

    ballReset()

end

function love.update(dt)
    
    -- move the left pad
    local window_width = love.graphics.getHeight()
    if love.keyboard.isDown("z") and pad.y > 0 then
        pad.y = pad.y - 2
    end
    if love.keyboard.isDown("s") and pad.y < window_width - pad.height then
        pad.y = pad.y + 2
    end

    -- move the right pad
    if love.keyboard.isDown("up") and pad2.y > 0 then
        pad2.y = pad2.y - 2
    end
    if love.keyboard.isDown("down") and pad2.y < window_width - pad2.height then
        pad2.y = pad2.y + 2
    end

    -- move the ball
    ball.x = ball.x + ball.speedX
    ball.y = ball.y + ball.speedY

    -- check for collision with the window borders
    if ball.y < 0 or ball.y > love.graphics.getHeight() - ball.height then
        ball.speedY = -ball.speedY
    end
    if ball.x < 0 or ball.x > love.graphics.getWidth() - ball.width then
        ball.speedX = -ball.speedX
    end

    -- check for collision with the left pad
    if ball.x < pad.x + pad.width and ball.y > pad.y and ball.y < pad.y + pad.height then
        ball.speedX = -ball.speedX
    end

    -- check for collision with the right pad
    if ball.x + ball.width > pad2.x and ball.y > pad2.y and ball.y < pad2.y + pad2.height then
        ball.speedX = -ball.speedX
    end


    
end

function love.draw()
    -- draw the left pad
    love.graphics.rectangle("fill", pad.x, pad.y, pad.width, pad.height)
    
    -- draw the right pad
    love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.width, pad2.height)

    -- draw the ball
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end