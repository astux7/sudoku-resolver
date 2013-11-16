#interactive menu
def interactive_menu
  full_program_menu
  loop do
    menu_choice($stdin.gets.chomp.to_i)
  end
end

# program menu selection text only
def program_menu 
    puts "   Launch in terminal: > ruby sudoku_resolver.rb sr.csv"
    puts "   The folowing menu:"
    puts "   1 - Read sudoku from the file #{@filename}"
    puts "   2 - Create sudoku from console input"
    puts "   3 - Show solution of the sudoku"
    puts "   4 - About the program"
    puts "   8 - Clear the screan"
    puts "   0 - Exit"
end
#print full menu description
def full_program_menu
    print_header
    program_menu
    print_footer
end
#header of the list of the students
def print_header
    puts "-------------------------------------------".center(50)
    puts "    SUDOKU RESOLVER                        ".center(50)
    puts "-------------------------------------------".center(50)

end

#footer of the list of the students with the size of list
def print_footer
    puts "-------------------------------------------".center(50)
    puts "-------------------------------------------".center(50)
end
#menu choice
def menu_choice(choice)
  case choice
      when 1
        try_load_sudoku
      when 2
        sudoku_from_console
      when 3
        solving(0,0)
        print_board
      when 4
        about_program
      when 8
        system("clear")
        program_menu
      when 0
        exit
      else
        program_menu
    end
end
#load sudoku from file
def load_sudoku
  sudoku = []
  file = File.open(@filename, "r")
  file.readlines.each do |line| 
    sudoku << line.chomp.split(',').map { |x| x.to_i }
  end
  @board = sudoku
  file.close
end

#reading students from the file
def try_load_sudoku
  if File.exists?(@filename) # if it exists
    load_sudoku
    print_board
  else # if it doesn't exist
    puts "Sorry, #{@filename} doesn't exist."
    exit # quit the program
  end
end

#reading sudoku from console
def sudoku_from_console
  puts "Please write 9 rows with semicoma "," merge numbers of sudoku, after every row press enter"
  puts "Please use 0 as missing number in sudoku"
  puts "If you make mistake do 'q' and try again"
  i = 0
  sudoku = []
  
  while i <9 do
    mm = $stdin.gets.chomp 
    break if mm == "q"
     sudoku << mm.split(',').map { |x| x.to_i }
     i+=1
  end
  @board = sudoku
  print_board
end

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
            [2,4,6,7,9,1,0,3,0]
          ]
  @board = soli
end
#recursion which starts from 0,0 to check all the matric of sudoku
def solving(i,j)
  if i == 9
    i = 0
    j += 1
    return true if j == 9
  end
  #skip filled places in matrix
  return solving(i+1,j) if @board[i][j] != 0  

  9.times do |val|
      if legaly?(i,j,val+1)
        @board[i][j] = val+1
        return true if solving(i+1,j)
      end
    end
  
  @board[i][j] = 0
  return false

end
#check if not exis in row collumn and squares 3x3
def legaly?(i,j,val)
  9.times do |k|
      return false if val == @board[k][j] 
  end
  9.times do |k|
      return false if val == @board[i][k] 
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
@filename = ARGV.first || "sr.csv"
interactive_menu
=begin test
print_board
test2
print_board
=end

