--# Piece
Piece = class()
function Piece:init(radius, color, loc)
    self.radius = radius
    self.color = color
    self.loc = loc
    self.selected = false
end

function Piece:isSelected()
    return self.selected
end

function Piece:draw()
    ellipseMode(CENTER)
    noStroke()
    local x = 0; local y = 0
    if ( self.loc ~= nil ) then
        x, y = locToXY(self.loc, self.board)
    end
    if ( self.color == BLACK ) then
        fill(0)
    elseif ( self.color == WHITE ) then
        fill(255)
    end
    if ( self.selected ) then
        fill(0, 255, 0)
    end
    ellipse(x, y, self.radius)
end

function Piece:getLoc()
    return self.loc
end

function Piece:getColor()
    return self.color
end

function Piece:moveTo(r, c)
    self.loc = Location(r, c)
end

function Piece:contains(x, y)
    -- x, y are pixels presumably returned by a touch
    local xC, yC = locToXY(self.loc, self.board)
    local left = xC - self.radius
    local right = xC + self.radius
    local bottom = yC - self.radius
    local top = yC + self.radius
    if ( x >= left and x <= right and
    y >= bottom and y <= top ) then
        return true
    else
        return false
    end
end

function Piece:toString()
    return ("" .. self.letter)
end

function Piece:setPlayer(plyr)
    self.player = plyr
end

function Piece:setIndex(indx)
    self.index = indx
end

function Piece:select()
    self.selected = true
end

function Piece:deselect()
    self.selected = false
end