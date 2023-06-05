import processing.sound.*;
int w;
int h;
SoundFile music;
SoundFile sad;
float R;
float G;
float B;
String playerName = ""; 
boolean startScreen = true; 
ArrayList<Blob> myBlobs;
ArrayList<Pellet> pellets;
ArrayList<Enemy> enemies;
boolean gameOver = false;
HashMap<String, Integer> scores = new HashMap<String, Integer>();
String[] highScores;
boolean spacebarPressed;
boolean paused = false;
//boolean enterPressed;
int lastEnemyTime;
int lastPelletTime;
int lastRecombineTime;
int score;
int prevScore;

void setup() {
  music = new SoundFile(this, "music.mp3");
  sad = new SoundFile(this, "sad.mp3");
  if (sad.isPlaying()) {
        sad.stop();  
      }
  score = 0;
  size(1600, 900);
  w = width / 2;
  h = height / 2;
  String prevScoreString = loadStrings("highscores.txt")[0]; 
  String curScore = "";
  for (int i = 0; i <  prevScoreString.length(); i++) {
    if (prevScoreString.substring(i, i+1).equals(":")) {
        curScore = prevScoreString.substring(i+2);
        break;
    }
    
  }
  prevScore = int(curScore);
  
  
  
  R = random(255);
  G = random(255);
  B = random(255);
  myBlobs = new ArrayList<Blob>();
  enemies = new ArrayList<Enemy>();
  myBlobs.add(new Blob(w, h, 50, color(R, G, B)));
  lastPelletTime = millis();
  lastRecombineTime = millis();  
  lastEnemyTime = millis();
  pellets = new ArrayList<Pellet>();
}
void saveHighScores() {
  if (score > prevScore) {
    String accumulator = "";
    for (String i : scores.keySet()) {
    accumulator = i + ": " + score ;
    }
    String[] newScore = {accumulator};
    saveStrings("highscores.txt", newScore);
  }
}

void drawStartScreen() {
  background(255);
  textAlign(CENTER);
  textSize(40);
  fill(0);
  text("Enter Your Name", width/2, height/2 - 50);
  
  textSize(30);
  text("Name: " + playerName, width/2, height/2+10);
  
  rectMode(CENTER);
  noFill();
  stroke(0);
  rect(width/2, height/2, 300, 40);
  
  textSize(20);
  fill(0, 150);
  text("Press Enter to start the game", width/2, height/2 + 100);
}


void draw() {
  if (startScreen) {
    drawStartScreen();
  } 
  else {
  background(255);
  fill(220);
  rect(10, 20, 10, 50);
  rect(30, 20, 10, 50);
  
  
  if (!gameOver) {
    if (!paused) {
      if (!music.isPlaying()) {
        music.loop();  
      }
  handleKeyPress();
  
  for (int i = myBlobs.size() - 1; i >= 0; i--) {
    Blob blob = myBlobs.get(i);
    blob.display();
    blob.followMouse();
    blob.checkCollision();
    blob.eatPellet();
    blob.eatEnemy();
  }
  
  if (millis() - lastRecombineTime >= 3000) {
    recombineBlobs();
    lastRecombineTime = millis();  
  }
  
  
  if (millis() - lastEnemyTime >= 5000) {
    Enemy newEnemy = new Enemy( int(random(width)), int(random(height)), int(random((myBlobs.get(0)).size +25)),  color(int(random(255)), int(random(255)), int(random(255))));
    enemies.add(newEnemy);
    lastEnemyTime = millis();  
  }
  generateNewMap();
  generatePellets();
  drawEnemies();
  
  
  textAlign(RIGHT);
  textSize(20);
  fill(0);
  if (myBlobs.size() > 0) {
  text("Coordinates: (" + myBlobs.get(0).posX + ", " + myBlobs.get(0).posY + ")", width - 20, 30);
  }
  text("Score: " + score, width - 20, 60);
  
    }
    else {
      textSize(50);
      text("PAUSED", w, h);
    }
    
    
  }
  else {
    if (!sad.isPlaying()) {
        sad.loop(); 
      }
    music.stop();
    textSize(40);
    textAlign(CENTER);
    fill(255, 0, 0);
    text("Game Over", width/2, height/2);
    text("Score: " + score, width/2, height/2 + 40);
    scores.replace(playerName, score);
    saveHighScores();
    text("HighScore: " + (loadStrings("highscores.txt")[0]), width/2, height/2 + 75);
    
    fill(0);
    rect(w, h+135, 300, 100);
    
    fill(255, 0, 0);
    
    
    text("Play Again? " , width/2, height/2 + 150);
    
    
    
    
    
    
  }
  }
  
  
}


void mousePressed() {
  if (gameOver) {
    if ( (mouseX >= w-150) && (mouseX <= w+150) && (mouseY > h+85) && (mouseY <= h+185)) {
      
       setup();
       gameOver = false;
      }
    
  }
  else {
    if ( (mouseX >= 0) && (mouseX <= 40) && (mouseY > 0) && (mouseY <= 50)) {
      if (paused) paused = false;
      else paused = true;
    }
  }
  
}


void handleKeyPress() {
  if (spacebarPressed) {
    spacebarPressed = false;
    splitBlobs();
  } 
}




void keyPressed() {
  if (startScreen) {
    if (key == ENTER || key == RETURN) {
      startScreen = false;
      scores.put(playerName, score);
      
    } else if (key == BACKSPACE && playerName.length() > 0) {
      playerName = playerName.substring(0, playerName.length() - 1);
    } else if (key != CODED && playerName.length() < 15) {
      playerName += key;
    }
  }
  else {
   if (key == ' ') {
    spacebarPressed = true;
  }  
  }
}

void splitBlobs() {
  ArrayList<Blob> newBlobs = new ArrayList<Blob>();

  for (Blob blob : myBlobs) {
    if (blob.size >= 20) {
      int newSize = blob.size / 2;
      newBlobs.add(new Blob(blob.posX + blob.size, blob.posY, newSize, blob.myColor));
      blob.size = newSize; // Reduce the size of the current blob
    }
  }

  myBlobs.addAll(newBlobs);
}


void recombineBlobs() {
  boolean toRecombine = true;
  Blob mainBlob = myBlobs.get(0);
  if (myBlobs.size() > 1) {
    int totalSize = 0;
    for (Blob blob : myBlobs) {
      if (dist(mainBlob.posX, mainBlob.posY,blob.posX,blob.posY) <= (2 * mainBlob.size) + 5) totalSize += blob.size;
      else {
        toRecombine = false;
        break;
      }
    }

    if (toRecombine) {
    mainBlob.size = totalSize; 

    for (int i = myBlobs.size() - 1; i > 0; i--) {
      myBlobs.remove(i);
    }
    }
  }
}

void generateNewMap() {
  if (!gameOver) {
  Blob mainBlob = myBlobs.get(0);
  int posX = mainBlob.posX;
  int posY = mainBlob.posY;
  int size = mainBlob.size;
  
  int boundaryThreshold = size / 2; 
  
  if (posX - boundaryThreshold < 0) {
    resetMap();
    for (Blob blob : myBlobs) {
      blob.posX = width - size;
    }
    
    
    
  } 
  else if (posX + size > width) {
    resetMap();
    for (Blob blob : myBlobs) {
      blob.posX = size;
    }

  }

  if (posY - boundaryThreshold < 0) {
    resetMap();
    for (Blob blob : myBlobs) {
      blob.posY = height - size;
    }
  } 
  else if (posY + size > height) {
    resetMap();
    for (Blob blob : myBlobs) {
      blob.posY = size;
    }
  }
  }
}

void resetMap() {
  pellets.clear();
  enemies.clear();
  lastPelletTime = millis();
  background(255);
}



void generatePellets() {
  if (millis() - lastPelletTime >= 1000) {
    Pellet newPellet = new Pellet();
    pellets.add(newPellet);
    lastPelletTime = millis();
  }

  for (Pellet pellet : pellets) {
    pellet.drawPellet();
  }
}


void drawEnemies() {
  if (!gameOver) {
    for (Enemy enemy : enemies) {
    enemy.checkBoundary();
    enemy.display();
    enemy.moveEnemy(myBlobs.get(0));
    enemy.eatPellet();
  }
    
  }
  
  
}
