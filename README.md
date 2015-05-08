# DynamicWumpusWorld

Remake of a beloved text-based game in which the Wumpus is brought to life using basic path-finding algorithms to chase the player. The game is turn-based but if you stay still for too long, the Wumpus might catch you...

## How to run the game
DynamicWumpusWorld was developed in Processing v2.2.1 and you will need to have this installed in order to run it (we have not tested the game with older versions of Processing). You may download Processing from <a href="https://processing.org/download/">https://processing.org/download/</a>

Once you've installed Processing 2.2.1, run the program, <b>click</b> on the <b>File tab</b> and open the main/main.pde file located in the game folder. 

## Files and Classes
- <b>main.pde:</b> Driver class that creates the wumpus, the board, the player, and starts the game.
- <b>Player.pde:</b> Player class
- <b>Board.pde:</b> Board class which describes an 8 x 8 grid
- <b>Tile.pde:</b> Tile class which has properties such as hasPit, hasPlayer, hasWumpus, etc.
- <b>Arrow.pde:</b> Player's arrow (currently not implemented in the game as of 5/7/2015)
- <b>Knowledgebase:</b> Board of tiles that the Wumpus or Player knows about
- <b>RandomWumpus:</b> Wumpus that randomly picks a move regardless of the presence of pits or distance to the player
- <b>GreedyWumpus:</b> Wumpus that uses sound (straight-line distance to player) as heuristic for determining best possible move
- <b>AvoidingWumpus:</b> Also known as 'Inference Wumpus', looks at potential pits and combines that with 'sound' to make a decision on best possible move.
- <b>A* Wumpus</b>: Smartest Wumpus that uses the 'sound' and distance traveled as well as potential pits and known pits to make decisions on best possible move.
