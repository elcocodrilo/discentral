# For whatever reason I have decided to try to implement backgammon.
# It is a great game.
#
# Need to design the state of the game,
# Design a way to validate changes to that state that follow the rules.
#
# Need to design a way to display the game board.
# Need to design an intuitive way for the user to move.
#
# On the server side need to design a fair way to roll the dice especially
# if I may want to update to play for money.


# Design the game.

# Backgammon is a one dimentional game.
# Each piece has a position on the board and can move
# the value indicated on the dice.

# Need to choose if the main object is going to be the pieces
# the positions, or the board itself. Going with the pieces:

# idea:
# represent an empty board as array of 24 zeroes.
# Positive numbers indicate the number of white pieces
# Negative numbers indicate the number of black pieces
# White starts a [0] goes to [23].
# Black starts at [23] goes to [0]

# blacks home
# 0 1 2 3 4 5        | 6 7 8 9 10 11

# whites home
# 23 22 21 20 19 18 | 17 16 15 14 13 12

# Jail is an array of two. First spot whites jail,
# second spot blacks jail.

#    # hard part, need to validate all the moves.
#
#    # Can't move beyond the end of the board.
#    if position +- di
#    # Can't move to a place with more than 1 of the opposing team.
#
#    # Must move the chits in jail first.
#
#    # If an open (single) chit is landed on, it is sent to jail
#
#    # Rolling out if all your chits are at home.


class Backgammon
  # construct a new game with the players names
  constructor: (white, black)->
    @players = {white,black}
    @board = new Array(24).fill(0)
    @jail = new Array(2).fill(0)
    @off = new Array(2).fill(0)

    # initialize the opening position (see backgammon rules)
    @board[23] = -2
    @board[0]  =  2

    @board[5]  = -5
    @board[18] =  5

    @board[7]  = -3
    @board[16] =  3

    @board[11] =  5
    @board[12] = -5

  move: (team, position, di)->
    o = 1
    if team is 'black'
      o *= -1;
      di *= -1;

    unless @isFree team
      console.log 'not free, must escape'
      return false

    unless @isHeld team, position
      return false

    if @isBlocked team , (position + di)
      return false

    if @isVulnerable team , (position + di)
      @board[position+di] = 0
      @jailem team


    @board[position] -= o
    @board[position+di] += o
    @display()
    return true

  isBlocked: (team, position)->
    switch team
      when 'white'
        if @board[position] < -1
          console.log 'is blocked'
          return true
        else
          return false
      when 'black'
        if @board[position] > 1
          console.log 'is blocked'
          return true
        else
          return false

  isHeld: (team, position)->
    switch team
      when 'white'
        if @board[position] > 0
          return true
        else
          console.log 'not held'
          return false
      when 'black'
        if @board[position] < 0
          return true
        else
          console.log 'not held'
          return false

  isVulnerable: (team, position)->
    switch team
      when 'white'
        if @board[position] == -1
          return true
        else
          return false
      when 'black'
        if @board[position] == 1
          return true
        else
          return false

  jailem:(team)->
    switch team
      when 'white' then @jail[1] += 1
      when 'black' then @jail[0] += 1

  isFree:(team)->
    switch team
      when 'white' then return (@jail[0]<1)
      when 'black' then return (@jail[1]<1)

  escape: (team, di)->
    console.log 'attempting escape'
    switch team
      when 'white'
        if @isBlocked team, di
          console.log 'blocked'
          return false
        if @isVulnerable team , di
          @board[di] = 0
          @jailem team

        @jail[0] -= 1
        @board[di] += 1
      when 'black'
        if @isBlocked team, (24-di)
          console.log 'blocked'
          return false
        @jail[0] -= 1
        @board[di] += 1
    @display()
    return true

  display:()->
    console.log @board
    console.log @jail


x = new Backgammon('dave', 'fred')
x.move 'white', 18, 3
x.move 'white', 16, 5
x.move 'black' , 23, 1
x.move 'black', 23, 6
x.move 'white', 0, 4
x.move 'black', 5,1
x.escape 'white', 4
x.move 'black', 5,1
