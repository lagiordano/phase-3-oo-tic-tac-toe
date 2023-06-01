# class TicTacToe 
    

#     WIN_COMBINATIONS = [ [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]]

#     def initialize 
#         @board = [" "," "," "," "," "," "," "," "," "]
#     end

#     def display_board 
#         puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
#         puts "-----------"
#         puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
#         puts "-----------"
#         puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
#     end

#     def input_to_index(user_input)
#         user_input.to_i - 1
#     end

#     def move(index, token)
#         @board[index] = token
#     end

#     def position_taken?(index)
#         @board[index] != " " 
#     end 

#     def valid_move?(index)
#         !position_taken?(index) && index.between?(0,8)
#     end

#     def turn_count 
#         @board.count { |square| square != " " }
#     end

#     def current_player 
#         turn_count.even? ? "X" : "O"
#     end

#     def turn 
#         puts "Please enter your move/number:"
#         user_input = gets.strip
#         index = input_to_index(user_input)
#         if valid_move?(index) 
#             token = current_player
#             move(index, token)
#             display_board
#         else
#             turn
#         end
       
#     end

#     def won? 
#         WIN_COMBINATIONS.any? do |combo| 
#             if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
#                 return combo 
#             end
#         end
#     end

#     def full? 
#         @board.all? { |square| square != " " }
#     end

#     def draw?
#         (full? && !won? ) ? true : false
#     end

#     def over?
#         (won? || draw?) ? true : false
#     end

#     def winner 
#         if combo = won? 
#             @board[combo[0]]
#         end
#     end

#     def play 
#         turn until over? 
#         puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
#     end

        

# end

class TicTacToe 

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6], 
        [1, 4, 7], 
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    def display_board 
        @board.map.with_index do |cell, i|
            if (i+1)%3 == 0
                print " #{cell} \n"
                if (i+1) != 9 
                    print "-------------\n"
                end
            else
                print " #{cell} |"
            end
        end
    end

    def input_to_index input
        input.to_i - 1
    end

    def move index, token="X"
        @board[index] = token
    end

    def position_taken? index
        @board[index] == " " ? false : true
    end

    def valid_move? index
        !position_taken?(index) && index >= 0 && index <= 8
    end

    def turn_count 
        occupied = @board.reject { |cell| cell == " "}
        occupied.length
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn 
        puts "Player #{current_player}, please enter move:"
        
        input = gets.chomp
        index = input != "invalid" ? self.input_to_index(input) : -1

        if self.valid_move? index
            
            self.move index, self.current_player
            self.display_board
        else
            puts "invalid"
            self.turn
        end
    end

    def won?
        combo = []
        WIN_COMBINATIONS.each do |com|
            if com.all? { |cell| @board[cell] == "X" } || com.all? { |cell| @board[cell] == "O"}
                combo = com
                break
            else
                combo = nil
            end
        end
        combo
    end

    def full?
        @board.none? { |cell| cell == " " }
    end

    def draw? 
        full? && !won?
    end

    def over? 
        draw? || won? 
    end

    def winner 
        if won? 
            current_player == "X" ? "O" : "X"
        else
            nil
        end
    end

    def play
        while !over? 
            turn
        end

        if won? 
            puts "Congratulations #{winner}!"
        elsif draw? 
            puts "Cat's Game!"
        end
    end

end