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
    @dice = []
    @turn = 1

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
        if @isVulnerable team , (di-1)
          @board[di-1] = 0
          @jailem team

        if (@isBlocked 'white', di-1)
          return false

        @jail[0] -= 1
        @board[di-1] += 1
      when 'black'
        if @isBlocked team, (24-di)
          console.log 'blocked'
          return false
        @jail[1] -= 1

        if @isVulnerable team , (di-1)
          @board[di-1] = 0
          @jailem team


        if (@isBlocked 'black', 24-di)
          return false

        @board[24-di] -= 1

    @display()
    return true

  display:()->
    #x = [0..23]
    #y = new Array(24).fill(0)
    #for i in x
    #  y[i]=i
    #console.log 'board:', y
    console.log 'board:' , @board
    console.log 'Jail:' , @jail

  roll: ()->
    @dice = []
    @dice.push (Math.floor(Math.random()*6) + 1)
    @dice.push (Math.floor(Math.random()*6) + 1)
    if @dice[0] == @dice[1]
      @dice.push @dice[0]
      @dice.push @dice[0]
    @turn *= -1
    console.log 'dice:' , @dice

  canRollOff: (team)->
    console.log 'checking if able to roll off board'
    switch team
      when 'white'
        console.log 'checking white'
        if @jail[0] == 0
          console.log 'not in jail'
          i = 0
          sum = 0
          while i <= 17
            console.log i
            if @board[i] > 0
              console.log 'can\'t roll off!'
              return false
            i++
        console.log 'can roll off!'
        return true

      when 'black'
        if @jail[1] == 0
          i = 6
          sum = 0
          while  i <= 23
            if @board[i] < 0
              console.log 'can\'t roll off!'
              return false
            i++
        console.log 'can roll off!'
        return true


x = new Backgammon('dave', 'fred')

x.roll() # 5 5
x.display()
x.move 'black',12 , 5
x.move 'black',12, 5
x.move 'black',12 , 5
x.move 'black',12 , 5
x.move 'white',11, 2
x.move 'white',13, 3
x.move 'black',7 , 5
x.move 'black',5 , 2
x.move 'white',0, 3
x.move 'white',11, 1
x.escape 'black', 4
x.move 'white',0, 2
x.move 'white',2, 6
x.escape 'black' , 3
x.move 'white',16, 2
x.move 'white',11, 1
x.escape 'black' , 3
x.move 'black', 23, 1
x.move 'white',3, 1
x.move 'white',4, 4
x.move 'black', 5, 4
x.move 'black', 7, 6
x.move 'white',11, 1
x.move 'white',11, 5
x.move 'black', 5, 3
x.move 'black', 7, 5
x.move 'white',18, 2
x.move 'white',12, 1
x.escape 'black', 1
x.move 'black' , 22, 2
x.escape 'white', 3
x.move 'black',23, 6
x.move 'black',23, 4
x.roll()
