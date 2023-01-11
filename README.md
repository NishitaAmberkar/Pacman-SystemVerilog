# PAC Man Game on FPGA 
by Nishita Amberkar and Megna Biederman

![Pacman_gif Small](https://user-images.githubusercontent.com/86085312/210874581-55c69a31-d795-49ae-982b-d766a2ab8c1d.jpeg)

Usage
First you will need to fully build the code and program your FPGA to run our game. Then you will need to plug a USB keyboard into the FPGA and connect the FPGA to a VGA monitor via a VGA output.
Once the code is programmed onto the device, you will need to create a BSP template project folder on eclipse and connect it to the soc files created in platform designer. Then generate BSP, Build the project and run the code. 

Once the game is displaying on the VGA monitor, you will see a start game screen. In order to run the game, press Key 1 which is the run button. 
In the event that you either die or win and want to restart, press the reset button (key 0). 

This game is a multiplayer game, which allows one or two people to play at the same time. Player 1 is the pacman, that can be controlled via WASD keys, and the blue ghost can be controlled via the up, down, left, and right arrows. 

In order to win, you need to eat all the dots. The goal is to get the highest score, you can increase your score by eating the cherries which will give you 50 points, where as the dots will give you 5 points each. 

There are two different power ups. The pink power up freezes the ghosts, allowing you to move while avoiding the ghosts. The second power up is the purple one that makes the ghost go into a frightened state and allows the ghosts to be eaten by pacman. 

You have three lives displayed below, when you collide with the ghosts when they are not in their frightened state they will kill you and reset pacmans position to its starting position. If you die 3 times, the game ends. If you win by eating all the dots the win game screen will display. 

