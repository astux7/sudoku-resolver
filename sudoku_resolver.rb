##################################################
#  Made by: Asta B. astux7                       #
#  program from file or console reads the sudoku #
#  and gives the output wiht solution            #
#################################################


#interactive menu
def interactive_menu
  full_program_menu
  menu_loop
end

#menu loop
def menu_loop
  loop do
    print "Choose menu option: "
    menu_choice($stdin.gets.chomp.to_i)
    @board = []
  end
end

# program menu selection text only
def program_menu 
    puts "   Launch in terminal: > ruby sudoku_resolver.rb filename.csv"
    puts "   The folowing menu:"
    puts "   1 - Read sudoku from the file #{@filename}"
    puts "   2 - Create sudoku from console input"
    puts "   8 - Clear the screen"
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
  file = File.open(@filename, "r")
  file.readlines.each do |line| 
    @board << line.chomp.split(',').map { |x| x.to_i }
  end
  file.close
  print_board
end

#reading lines from the file
def try_load_sudoku
  if File.exists?(@filename) # if it exists
    load_sudoku  
    solving(0,0)
    print_board
  else # if it doesn't exist
    puts "Sorry, #{@filename} doesn't exist."
    exit # quit the program
  end        
end

#console instructions
def print_console_instructions
  puts "Please write 9 rows with semicomma "," merge numbers of sudoku, after every row press enter."
  puts "Please use 0 as missing number in sudoku."
  puts "If you make mistake do 'q' and try again choosing menu option 2:"
end

#looping from console
def looping_via_console
  i = 0
  while i < 9 do
    input = $stdin.gets.chomp 
    break if input == "q"
    @board << input.split(',').map { |x| x.to_i }
    i += 1
  end
end

#reading sudoku from console
def sudoku_from_console
  print_console_instructions
  looping_via_console
  print_board
  solving(0,0)
  print_board
end

#recursion which starts from 0,0 to fill all the matric elements of 0
def solving(i,j)
  return false if i > 9 || i < 0 || j > 9 || j < 0  #incase checking..
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

#check if not exist in row, column and squares 3x3
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

#printing board
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
#################################################################
# MAIN program 
#################################################################
@board = []
@filename = ARGV.first || "sr.csv"
interactive_menu
