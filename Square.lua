Square = class{}
smoving = 100

function Square:init(x, y, width, height)
    self.x = x
    self.y = y 
    self.width = width
    self.height = height
    self.dy = 1
end

function Square:update(dt)
    self.y = self.y + smoving * dt
end

function Square:reset()
    self.y = 100
    smoving = 100
end

function Square:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end


