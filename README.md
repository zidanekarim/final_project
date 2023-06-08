# Blobs In Space

## Required libraries: Sound (plays music during the game)

## A game like agar.io, where the player controls a blob by moving the mouse. The blob eats pellets to grow in size and consumes enemy blobs smaller than itself, but gets consumed (loses) if it is eaten by a blob greater than itself. 




How does it work?

The player must first type their name in with the keyboard and press enter to start the game. Then, their blob will spawn on the screen, with their name to indicate who the player is controlling. The blob will follow the player’s mouse at a constant rate that scales with the blob’s size. The player can split their blob by pressing space, which creates double the amount of blobs with half the radii. These blobs both follow the same path, but if they are stuck together for ~3-4 seconds, they will recombine. 
 
Pellets will spawn every second, which the player can consume to grow, increasing their score. Enemy blobs also spawn at the same rate. These blobs can consume pellets as well. If they are bigger than the player’s main blob, they will move towards it. If they are smaller or equal to the player’s main blob, they will move away. If the player touches an enemy smaller than itself, they consume the enemy, adding its size and color, as well as increasing the score. However, if the player touches an equal or bigger size enemy, the player dies, ending the game. The player can then see the high score and click “Play Again” to play again. 

The player can also move off-screen, which generates a new map. 

The objective is to get the highest score possible. 

### Suggested strategies:
* If there are too many enemies, move off-screen
* To get a kill, split into a smaller blob, baiting the enemies towards you, and try to trigger a recombine, killing the enemy. 
* Split into many blobs to move faster away from enemies.  
