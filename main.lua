class = require 'class'
--push = require 'push'

require 'Square'
require 'Circle'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--VIRTUAL_WIDTH = 432
--VIRTUAL_HEIGHT = 243


function love.load()
    --love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('tap')

    love.window.setMode( WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    sounds = {
		['paddle_hit'] = love.audio.newSource('paddle_hit.wav', 'static'),
		['wall_hit'] = love.audio.newSource('wall_hit.wav', 'static')
	}
	

    

    circle = Circle( 900, 90, 75)
    square = Square(300, 50, 150, 150)
    
    

    Big_font = love.graphics.newFont('font.ttf', 32)
    Small_font = love.graphics.newFont('font.ttf', 25)
    Score_font = love.graphics.newFont('font.ttf', 16)


    playerscore = 0

    gamestate = 'start'




end



function love.resize(w, h)
	push:resize(w, h)
end


function love.update(dt)
    if gamestate == 'play' then
        square:update(dt)
        circle:update(dt)


        if square.y > 520 - square.height/2 and square.y < 520 and square.x == 300 and love.keyboard.isDown('f') then
            square:reset()
            smoving = smoving * 1.03
            playerscore = playerscore + 1
            sounds['paddle_hit']:play()
        elseif square.y >  520 and square.x == 300 and not(love.keyboard.isDown('f')) then
            square:reset()
            sounds['wall_hit']:play()
        end
    
        if circle.y > 590 - circle.radius and circle.y < 520 and circle.x == 900 and love.keyboard.isDown('j') then
            circle:reset()
            cmoving = cmoving * 1.03
            playerscore = playerscore + 1
            sounds['paddle_hit']:play()
        elseif circle.y > 590 and circle.x == 900 and not (love.keyboard.isDown('j')) then
            circle:reset()
            sounds['wall_hit']:play()
        end

    end
    

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif (key == 'enter' or key == 'return') then
        if gamestate == 'start' then
            gamestate = 'play'
        end

    end
    
    if gamestate == 'play'  and playerscore == 10 then
        gamestate = 'won'
        elseif gamestate == 'won' then
            gamestate = 'start'

            playerscore = 0
        end
end


function love.draw()
    love.graphics.clear(90/255, 0/255, 200/255, 255/255)
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    love.graphics.printf('Press F for square', 80, WINDOW_HEIGHT/2, WINDOW_WIDTH)
    love.graphics.printf('Press J for circle', WINDOW_WIDTH - 210, WINDOW_HEIGHT/2, WINDOW_WIDTH)

    if gamestate == 'start' then

        love.graphics.setFont(Big_font)

        love.graphics.printf('Welcome!', 0, 15, WINDOW_WIDTH, 'center')
        love.graphics.printf('Press enter to start the game!', 0, 45, WINDOW_WIDTH, 'center' )
    elseif gamestate == 'play' then
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
        square:render()
        love.graphics.setColor(200/255, 0/255, 255/255, 255/255)
        circle:render()
    elseif gamestate == 'win' then
        love.graphics.printf('CONGRATULATIONS!', 0, 10, WINDOW_WIDTH, 'center')
        love.graphics.printf('YOU WIN!', 0, 25, WINDOW_WIDTH, 'center')
    end
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

    displayscore()

    love.graphics.setColor(200/255, 0/255, 255/255, 255/255)
    love.graphics.rectangle('fill', 300, 520, 150, 150)

    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    love.graphics.circle('fill', 900, 590, 75)

    displayFPS()

end

function displayscore()
 love.graphics.setFont(Big_font)
 love.graphics.print(tostring('Your score: ' .. tostring(playerscore)), 50, 40)
end

function displayFPS()
    love.graphics.setFont(Score_font)
    love.graphics.setColor(0,255, 255/255, 0/255, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10, WINDOW_WIDTH)
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end