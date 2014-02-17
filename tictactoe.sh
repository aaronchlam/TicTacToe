#!/bin/bash

#Author: Aaron Lam
#Tic Tac Toe on your shell!

print_board () {
	#Print the board
	echo " ${board[1]} | ${board[2]} | ${board[3]}"
	echo "- - - - - -"
	echo " ${board[4]} | ${board[5]} | ${board[6]} "
	echo "- - - - - -"
	echo " ${board[7]} | ${board[8]} | ${board[9]}"
}

check_board () {
	#Check the rows
	for i in 1 4 7; do
		mid=`expr $i + 1`
		right=`expr $i + 2`
		if [[ ${board[$mid]} == ${board[$i]} && ${board[$right]} == ${board[$i]} ]]; then
			game_loop="win"
			return
		fi
	done
	#Check the columns
	for i in 1 2 3; do
		mid=`expr $i + 3`
		low=`expr $i + 6`
		if [[ ${board[$mid]} == ${board[$i]} && ${board[$low]} == ${board[$i]} ]]; then
			game_loop="win"
			return
		fi
	done
	#Check the diagonals
	if [[ ${board[5]} == ${board[1]} && ${board[9]} == ${board[1]} ]]; then
		game_loop="win"
		return
	fi
	if [[ ${board[5]} == ${board[3]} && ${board[7]} == ${board[3]} ]]; then
		game_loop="win"
		return
	fi
	#Check if game is a draw
	game_loop="draw"
	for i in {0..9}; do
		#if any cells is still a numeral then the game is not a draw
		if [[ ${board[$i]} == $i ]]; then
			game_loop="true"
			return
		fi
	done
}

#Initialize the game board
for i in {1..9}; do
	board[$i]=$i
done

#Welcome Message
echo "Welcome to Tic Tac Toe!"
echo "--------------------------------------------------------------------------"
echo "Players alternate placing Xs and Os on the board until:"
echo "(a) one player has three in a row, horizontally, vertically, or diagonally"
echo "OR"
echo "(b) all nine squares are filled."
echo "If a player is able to draw three Xs or three Os in a row,"
echo "then that player wins!"
echo "If all nine squares are filled and neither player has three in a row,"
echo "then the game is a draw."
echo "-------------------------------------------------------------------------"

#Start the game
echo "GAME START"

#The game loop
game_loop="true"
player="X"
while [ $game_loop == "true" ]; do
	print_board
	echo "Player ${player}'s turn. Type the cell number and <RETURN> key to place your piece:"
	read input
	while [[ !($input =~ ^[1-9]$) ]]; do
		echo "Input was not valid. Please enter an integer between 1 to 9 (inclusive):"
		read input
	done
	while [[ ${board[i]} == "X" || ${board[i]} == "O" ]]; do
		echo "Cell ${board[i]} is already occupied. Please choose another cell:"
		read input
	done
	board[$input]=$player
	check_board
	echo "game_loop:$game_loop"
	if [[ $game_loop == "win" ]]; then
		print_board
		echo "Player $player wins!"
	elif [[ $game_loop == "draw" ]]; then
		print_board
		echo "The game is a draw!"
	fi
	if [[ $player == "X" ]]; then
		player="O"
	elif [[ $player == "O" ]]; then
		player="X"
	fi
done