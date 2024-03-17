-- Score system
pad1Score = 0
pad2Score = 0

-- init the game
startmsg = "Tap SPACE to start the game"
start = false
soundWall = love.audio.newSource("mur.wav", "static")
soundLose = love.audio.newSource("perdu.wav", "static")

-- init the middle line
middleLine = {}
middleLine.x = 400
middleLine.y = 0
middleLine.width = 5
middleLine.height = 600

-- init the left pad
pad = {}
pad.x = 0
pad.y = love.graphics.getHeight() / 2 - 40
pad.width = 20
pad.height = 80

-- init the right pad
pad2 = {}
pad2.x = love.graphics.getWidth() - 20
pad2.y = love.graphics.getHeight() / 2 - 40
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
    soundLose:play()
    -- center the ball on the screen
    ball.x = love.graphics.getWidth() / 2
    ball.x = ball.x - ball.width / 2
    ball.y = love.graphics.getHeight() / 2
    ball.y = ball.y - ball.height / 2
end

function newGame()
    pad1Score = 0
    pad2Score = 0
    ballReset()
end

function love.load()
    -- ballReset()
    middleLine.x = love.graphics.getWidth() / 2
    middleLine.x = middleLine.x - middleLine.width / 2
    middleLine.y = love.graphics.getHeight() / 2
    middleLine.y = middleLine.y - middleLine.height / 2
end

function love.update(dt)
    -- start the game
    if love.keyboard.isDown("space") then
        start = true
    end

    -- lose condition
    if pad1Score == 10 or pad2Score == 10 then
        start = false
        newGame()
    end

    -- check if the game is started
    if start == true then
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
            ball.speedY = -ball.speedY -- set the speed to the opposite
            soundWall:play()
        end
        if ball.x < 0 or ball.x > love.graphics.getWidth() - ball.width then
            if ball.x < 0 then
                pad2Score = pad2Score + 1
                ball.speedX = -ball.speedX
            else
                pad1Score = pad1Score + 1
                ball.speedX = -ball.speedX
            end
            ballReset()
        end

        -- check for collision with the left pad
        if ball.x < pad.x + pad.width and ball.y > pad.y and ball.y < pad.y + pad.height then
            ball.speedX = -ball.speedX
            soundWall:play()
        end

        -- check for collision with the right pad
        if ball.x + ball.width > pad2.x and ball.y > pad2.y and ball.y < pad2.y + pad2.height then
            ball.speedX = -ball.speedX
            soundWall:play()
        end
    end
end

function love.draw()
    -- draw the start message
    if pad1Score == 0 and pad2Score == 0 and start == false then
        love.graphics.print(startmsg, love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() / 2 - 10)
    end
    if start == true then
        -- draw the left pad
        love.graphics.rectangle("fill", pad.x, pad.y, pad.width, pad.height)

        -- draw the right pad
        love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.width, pad2.height)

        -- draw the ball
        love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)

        -- draw the middle line
        love.graphics.rectangle("fill", middleLine.x, middleLine.y, middleLine.width, middleLine.height)

        -- draw the score
        love.graphics.print(pad1Score, love.graphics.getWidth() / 2 - 50, 10)
        love.graphics.print(pad2Score, love.graphics.getWidth() / 2 + 30, 10)
    end
end
