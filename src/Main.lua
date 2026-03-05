--# Main
-- Final Project
BORDER = 150
SIZE = 60
NUM_COLS = 8
NUM_ROWS = 8
BLACK = 1
WHITE = 2
player = 1
Sound1 = true
Sound2 = true
Sound3 = true
Sound4 = true
Sound5 = true
Sound6 = true

function setup()
    board = Board(8, 8, SIZE, BORDER)
    pieces = {}
    for r = 1, NUM_ROWS do
        pieces[r] = {}
        for c = 1, NUM_COLS do
            pieces[r][c] = nil
        end
    end
    pcA = Piece(SIZE*0.8, WHITE, Location(4,4))
    pieces[4][4] = pcA
    pcB = Piece(SIZE*0.8, BLACK, Location(5,4))
    pieces[5][4] = pcB
    pcC = Piece(SIZE*0.8, WHITE, Location(5,5))
    pieces[5][5] = pcC
    pcD = Piece(SIZE*0.8, BLACK, Location(4,5))
    pieces[4][5] = pcD
    button = Button("Pass", 770, 600, 100, 50)
end

function draw()
    background(200)
    board:draw()
    if (boardFull() ~= true) then
        button:draw()
    end
    for r = 1, NUM_ROWS do
        for c = 1, NUM_COLS do
            if ( pieces[r][c] ~= nil ) then
                pieces[r][c]:draw()
            end
        end
    end
    if (player % 2 == 1) then
        if (boardFull() ~= true) then
            textMode(CORNER)
            fontSize(35)
            font("ArialRoundedMTBold")
            fill(0, 0, 255)
            text("Black's Turn", 710, 360)
        end
    end
    if (player % 2 == 0) then
        if (boardFull() ~= true) then
            textMode(CORNER)
            fontSize(35)
            font("ArialRoundedMTBold")
            fill(0, 0, 255)
            text("White's Turn", 710, 360)
        end
    end
    if (boardFull() ~= true) then
        rectMode(CORNER)
        textMode(CORNER)
        fontSize(50)
        font("ArialRoundedMTBold")
        w, h = textSize("Othello")
        fill(222, 37, 228)
        rect(298, 631, w+8, h+8)
        fill(0, 0, 255)
        text("Othello", 302, 635)
    end
    if (boardFull() == true) then
        rectMode(CORNER)
        textMode(CORNER)
        fontSize(50)
        font("ArialRoundedMTBold")
        w, h = textSize("Game Over")
        fill(222, 37, 228)
        rect(249, 631, w+8, h+8)
        fill(0, 0, 255)
        text("Game Over", 253, 635)
        countPieces()
        fill(0, 0, 255)
        fontSize(35)
        font("ArialRoundedMTBold")
        text("White = "..whiteCount, 710, 500)
        text("Black = "..blackCount, 710, 400)
        if (whiteCount > blackCount) then
            text("White Wins", 710, 300)
        elseif (blackCount > whiteCount) then
            text("Black Wins", 710, 300)
        else
            text("Tie", 710, 300)
        end
    end
end

function touched(touch)
    if (touch.state == ENDED) then
        print(touch.x)
        print(touch.y)
        if (xyToLoc(touch.x, touch.y, board) ~= nil) then
            loc = xyToLoc(touch.x, touch.y, board)
            row = loc:getRow()
            col = loc:getCol()
            if (isRowValid(row) == true and isColValid(col) == true) then
                if (pieces[row][col] == nil) then
                    if (player % 2 == 1) then
                        pieces[row][col] = Piece(SIZE*0.8, BLACK, Location(row, col))
                        player = player + 1
                    else
                        pieces[row][col] = Piece(SIZE*0.8, WHITE, Location(row, col))
                        player = player + 1
                    end
                    if (flipTop(row, col) == false and
                        flipBottom(row, col) == false and
                        flipLeft(row, col) == false and
                        flipRight(row, col) == false and
                        flipTopLeft(row, col) == false and
                        flipTopRight(row, col) == false and
                        flipBottomLeft(row, col) == false and
                        flipBottomRight(row, col) == false) then
                        pieces[row][col] = nil
                        player = player +1
                    else
                        flipTop(row, col)
                        flipBottom(row, col)
                        flipLeft(row, col)
                        flipRight(row, col)
                        flipTopLeft(row, col)
                        flipTopRight(row, col)
                        flipBottomLeft(row, col)
                        flipBottomRight(row, col)
                    end
                end
            end
        end
    end
    
    button:touched(touch)
    if (touch.state == BEGAN) then
        if (button.colorState == 2) then
            player = player + 1
        end
    end
    
    if (touch.state == ENDED) then
        if (boardFull() == true) then
            countPieces()
            print("White = "..whiteCount)
            print("Black = "..blackCount)
            if (whiteCount > blackCount) then
                print("White Wins")
            elseif (blackCount > whiteCount) then
                print("Black Wins")
            else
                print("Tie")
            end
        end
    end
    
    if (touch.state == ENDED) then
        if (pieces[1][1] ~= nil) then
            if (Sound1 == true) then
                speech.say("Nice Move")
                Sound1 = false
            end
        end
    end
    if (touch.state == ENDED) then
        if (pieces[1][8] ~= nil) then
            if (Sound2 == true) then
                speech.say("Nice Move")
                Sound2 = false
            end
        end
    end
    if (touch.state == ENDED) then
        if (pieces[8][1] ~= nil) then
            if (Sound3 == true) then
                speech.say("Nice Move")
                Sound3 = false
            end
        end
    end
    if (touch.state == ENDED) then
        if (pieces[8][8] ~= nil) then
            if (Sound4 == true) then
                speech.say("Nice Move")
                Sound4 = false
            end
        end
    end
    if (touch.state == ENDED) then
        if (boardFull() == true) then
            if (Sound5 == true) then
                speech.say("Game Over")
                Sound5 = false
            end
        end
    end
    if (touch.state == ENDED) then
        if (boardFull() == true) then
            if (Sound6 == true) then
                if (whiteCount > blackCount) then
                    speech.say("White Wins")
                    Sound6 = false
                elseif (blackCount > whiteCount) then
                    speech.say("Black Wins")
                    Sound6 = false
                else
                    speech.say("Tie Game")
                    Sound6 = false
                end
            end
        end
    end
    
end

function flipTop(r, c)
    color = pieces[r][c]:getColor()
    for i = 1, NUM_COLS do
        if (isRowValid(r-i) == false or
            pieces[r-i][c] == nil or
            pieces[r-1][c].color == color) then
            return false
        elseif (pieces[r-i][c]:getColor() == color) then
            index = i
            break
        end
    end
    for i = 1, index-1 do
        pieces[r-i][c].color = color
    end
end

function flipBottom(r, c)
    color = pieces[r][c]:getColor()
    for i = 1, NUM_COLS do
        if (isRowValid(r+i) == false or
            pieces[r+i][c] == nil or
            pieces[r+1][c].color == color) then
            return false
        elseif (pieces[r+i][c]:getColor() == color) then
            index = i
            break
        end
    end
    for i = 1, index-1 do
        pieces[r+i][c].color = color
    end
end

function flipLeft(r, c)
    color = pieces[r][c]:getColor()
    for i = 1, NUM_COLS do
        if (isColValid(c-i) == false or
            pieces[r][c-i] == nil or
            pieces[r][c-1].color == color) then
            return false
        elseif (pieces[r][c-i]:getColor() == color) then
            index = i
            break
        end
    end
    for i = 1, index-1 do
        pieces[r][c-i].color = color
    end
end

function flipRight(r, c)
    color = pieces[r][c]:getColor()
    for i = 1, NUM_COLS do
        if (isColValid(c+i) == false or
            pieces[r][c+i] == nil or
            pieces[r][c+1].color == color) then
            return false
        elseif (pieces[r][c+i]:getColor() == color) then
            index = i
            break
        end
    end
    for i = 1, index-1 do
        pieces[r][c+i].color = color
    end
end

function flipTopLeft(r, c)
    color = pieces[r][c]:getColor()
    for i = 1, NUM_COLS do
        if (isLocValid(r-i, c-i) == false or
            pieces[r-i][c-i] == nil or
            pieces[r-1][c-1].color == color) then
            return false
        elseif (pieces[r-i][c-i]:getColor() == color) then
            index = i
            break
        end
    end
    for i = 1, index-1 do
        pieces[r-i][c-i].color = color
    end
end

function flipTopRight(r, c)
    color = pieces[r][c]:getColor()
    for i = 1, NUM_COLS do
        if (isLocValid(r-i, c+i) == false or
            pieces[r-i][c+i] == nil or
            pieces[r-1][c+1].color == color) then
            return false
        elseif (pieces[r-i][c+i]:getColor() == color) then
            index = i
            break
        end
    end
    for i = 1, index-1 do
        pieces[r-i][c+i].color = color
    end
end

function flipBottomLeft(r, c)
    color = pieces[r][c]:getColor()
    for i = 1, NUM_COLS do
        if (isLocValid(r+i, c-i) == false or
            pieces[r+i][c-i] == nil or
            pieces[r+1][c-1].color == color) then
            return false
        elseif (pieces[r+i][c-i]:getColor() == color) then
            index = i
            break
        end
    end
    for i = 1, index-1 do
        pieces[r+i][c-i].color = color
    end
end

function flipBottomRight(r, c)
    color = pieces[r][c]:getColor()
    for i = 1, NUM_COLS do
        if (isLocValid(r+i, c+i) == false or
            pieces[r+i][c+i] == nil or
            pieces[r+1][c+1].color == color) then
            return false
        elseif (pieces[r+i][c+i]:getColor() == color) then
            index = i
            break
        end
    end
    for i = 1, index-1 do
        pieces[r+i][c+i].color = color
    end
end

function isRowValid(r)
    if ( r < 1 or r > NUM_ROWS ) then
        return false
    else
        return true
    end
end

function isColValid(c)
    if ( c < 1 or c > NUM_COLS ) then
        return false
    else
        return true
    end
end

function isLocValid(r, c)
    if ( r < 1 or r > NUM_ROWS or
         c < 1 or c > NUM_COLS) then
        return false
    else
        return true
    end
end

-- convert a location on the board to x,y pixel values
function locToXY(loc)
    local border = BORDER
    local size = SIZE
    local r = loc:getRow()
    local c = loc:getCol()
    local x = border + (c - 0.5)*size
    local y = HEIGHT - border - (r - 0.5)*size
    return x, y
end

 -- convert a x, y pixel values to a location on the board
function xyToLoc(x, y, board)
    local brdr = BORDER
    local sz = SIZE
    local nr = NUM_ROWS
    local nc = NUM_COLS
    if ( x < brdr or
         x > (brdr + nc * sz) or
         y > (HEIGHT - brdr) or
         y < (HEIGHT - brdr - nr * sz) ) then
        return nil -- x,y not on board
    end
    for r = 1, nr do
        for c = 1, nc do
            if ( x > (brdr + (c - 1)*sz) and
                 x < (brdr + c*sz) and
                 y < (HEIGHT - brdr - (r - 1)*sz) and
                 y > (HEIGHT - brdr - r*sz) ) then
                return Location(r, c)
            end
        end
    end
end

function boardFull()
    for r = 1, NUM_ROWS do
        for c = 1, NUM_COLS do
            if ( pieces[r][c] == nil ) then
                return false
            end
        end
    end
    return true
end

function countPieces()
    whiteCount = 0
    blackCount = 0
    for r = 1, NUM_ROWS do
        for c = 1, NUM_COLS do
            if (pieces[r][c] ~= nil) then
                if (pieces[r][c].color == WHITE) then
                    whiteCount = whiteCount + 1
                elseif (pieces[r][c].color == BLACK) then
                    blackCount = blackCount + 1
                end
            end
        end
    end
end