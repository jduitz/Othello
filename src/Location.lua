--# Location
Location = class()

function Location:init(row, col)
    self.row = row
    self.col = col
end

function Location:getRow()
    return self.row
end

function Location:getCol()
    return self.col
end

function Location:equals(other)
    if ( self.row == other.row and
    self.col == other.col ) then
        return true
    else
        return false
    end
end