--# Board
Board = class()

function Board:init(nr, nc, sz, brdr)
    self.nr = nr
    self.nc = nc
    self.sz = sz
    self.brdr = brdr
end

function Board:getNumRows()
    return self.nr
end

function Board:getNumCols()
    return self.nc
end

function Board:getSize()
    return self.sz
end

function Board:getBorder()
    return self.brdr
end

function Board:draw()
    rectMode(CENTER)
    for r = 1, self.nr do
        for c = 1, self.nc do
            local x, y = locToXY(Location(r, c), self)
            fill(77, 169, 24)
            strokeWidth(3)
            stroke(0)
            rect(x, y, self.sz + 3, self.sz + 3)
        end
    end
end