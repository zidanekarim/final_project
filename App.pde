int w;
int h;
float R;
float G;
float B;
ArrayList<Blob> myBlobs;
ArrayList<Pellet> pellets;

boolean spacebarPressed;
//boolean enterPressed;

int lastPelletTime;
int lastRecombineTime;
void setup() {
  size(1280, 720);
  w = width / 2;
  h = height / 2;
  R = random(255);
  G = random(255);
  B = random(255);
  myBlobs = new ArrayList<Blob>();
  myBlobs.add(new Blob(w, h, 50, color(R, G, B)));
  lastPelletTime = millis();
  lastRecombineTime = millis();  
  pellets = new ArrayList<Pellet>();
}

void draw() {
  background(255);

  handleKeyPress();

  for (int i = myBlobs.size() - 1; i >= 0; i--) {
    Blob blob = myBlobs.get(i);
    blob.update();
    blob.display();
    blob.followMouse();
    blob.checkCollision();
    blob.eatPellet();
  }
  
  if (millis() - lastRecombineTime >= 3000) {
    recombineBlobs();
    lastRecombineTime = millis();  // Update the lastRecombineTime variable
  }

  generatePellets();
}

void handleKeyPress() {
  if (spacebarPressed) {
    spacebarPressed = false;
    splitBlobs();
  } 
}

void keyPressed() {
  if (key == ' ') {
    spacebarPressed = true;
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
    mainBlob.size = totalSize; // Set the size of the main blob to the sum of all blob sizes

    // Remove all blobs except the main blob
    for (int i = myBlobs.size() - 1; i > 0; i--) {
      myBlobs.remove(i);
    }
    }
  }
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
