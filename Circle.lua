Circle = class{}
cmoving = 100


function Circle:init(x, y, radius)
    self.x = x
    self.y = y
    self.radius = radius
    self.dy = 0
end

function Circle:update(dt)
    self.y = self.y + cmoving * dt
end

function Circle:reset()
    self.y = 30
    cmoving = 100
end

function Circle:render()
    love.graphics.circle('fill', self.x, self.y, self.radius)
end