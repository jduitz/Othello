--# Button
Button = class()

function Button:init(label, posX, posY, width, height)
    self.label = label
    self.posX = posX
    self.posY = posY
    self.width = width
    self.height = height
    self.action = nil
    self.font = "ArialRoundedMTBold"
    self.colorA = color(255, 0, 0)
    self.colorB = color(0, 255, 0)
    self.colorState = 1
end

function Button:draw()
    rectMode(CENTER)
    if ( self.colorState == 1 ) then
        fill(self.colorA) -- a Codea color object
    else
        fill(self.colorB)
    end
    rect(self.posX, self.posY, self.width, self.height)
    textMode(CENTER)
    fill(255)
    font(self.font)
    fontSize(22)
    text(self.label, self.posX, self.posY)
end

function Button:hit(p)
    local l = self.posX - self.width/2
    local r = self.posX + self.width/2
    local t = self.posY + self.height/2
    local b = self.posY - self.height/2
    if p.x > l and p.x < r and
    p.y > b and p.y < t then
        return true
    end
    return false
end

function Button:touched(touch)
    if ( touch.state == BEGAN and
    self:hit(vec2(touch.x,touch.y) ) ) then
        self.colorState = 2
    end
    if ( touch.state == ENDED and
    self:hit(vec2(touch.x,touch.y) ) ) then
        self.colorState = 1
        if self.action then
            self.action()
        end
    end
end

function Button:setLabel(str)
    self.label = str
end

function Button:getLabel()
    return self.label
end