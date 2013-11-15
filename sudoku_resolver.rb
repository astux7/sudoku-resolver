
def test
  soli = [[7,1,2,3,4,5,6,8,9],
          [3,8,5,1,6,9,2,4,7],
          [6,9,4,2,7,8,1,5,3],
          [1,2,3,6,5,4,7,9,8],
          [4,5,8,9,1,7,3,6,2],
          [9,6,7,8,2,3,5,1,4],
          [5,3,1,4,8,2,9,7,6],
          [8,7,9,5,3,6,4,2,1],
          [2,4,6,7,9,1,8,3,5]
          ]          
    
  @board = soli
end

def test2
  soli = [  [7,1,0,3,4,5,6,8,9],
            [3,8,5,1,6,0,2,4,7],
            [6,0,4,2,7,8,1,5,3],
            [1,2,3,6,5,4,7,9,8],
            [4,5,8,9,1,7,3,0,2],
            [9,6,0,8,2,3,5,1,4],
            [5,0,1,4,8,2,9,7,6],
            [8,7,9,5,3,6,4,2,0],
            [2,4,6,7,9,1,0,3,5]
          ]
  @board = soli
end

def solving(i,j)
  if i==9
      i = 0
      j= j+1
      if j==9
        return true
      end
  end

  if @board[i][j] != 0
    return solving(i+1,j)
  
end
   #return true
  9.times do |val|
      if legaly?(i,j,val+1)
        @board[i][j] = val+1
      
      if solving(i+1,j)
          return true
      end
    end
  end
  @board[i][j] = 0
  return false

end

def legaly?(i,j,val)
  9.times do |k|
      return false if val ==@board[k][j] 
  end
  9.times do |k|
      return false if val ==@board[i][k] 
  end

  boxrowoffset = (i/3) * 3
  boxcoloffser = (j/3) * 3

  3.times do |k|
    3.times do |m|
        return false if val == @board[boxrowoffset+k][boxcoloffser+m]
    end
  end
  return true
end

def zero_board
		Array.new(9,[0,0,0,0,0,0,0,0,0])
end

def print_board
    print "  ------------------------------   \n"
    @board.each_with_index do |m,x|
		  m.each_with_index do |l,y|
        print "| " if y==0 || y%3==0 
			  print l.to_s + "  "
        print "|" if y==8
	    end
      print " \n"
      print "| ------------------------------ | \n" if (x+1)%3==0 && x!=8
    end
    print "  ------------------------------   \n"
end

@board = zero_board
@change = zero_board

test
print_board
test2
print_board
solving(0,0)
print_board

