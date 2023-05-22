int w;
int h;
float R;
float G;
float B;
ArrayList<Blob> myBlobs;
Blob myBlob;
ArrayList<Pellet> pellets;

int lastPelletTime;

void setup() {
  size(1280, 720);
  w = width/2;
  h = height/2;
  R = random (255);
  G = random (255);
  B = random (255);
  myBlobs = new ArrayList<Blob>();
  myBlob = new Blob(w, h, 50);
  myBlobs.add(myBlob);
  lastPelletTime = millis();
  pellets = new ArrayList<Pellet>();
}


void draw() {
  background(255);
  
  for (int i = 0; i < myBlobs.size(); i++) {
    Blob blob = myBlobs.get(i);
    blob.display();
    blob.followMouse();
  } 
  
  generatePellets();
  eatPellet();
  combineBlobs();
  
}


void generatePellets() {
  if (millis() - lastPelletTime >= 1000) {
    Pellet newPellet = new Pellet();  // Create a new pellet
    pellets.add(newPellet);  // Add the new pellet to the list
    lastPelletTime = millis();  // Update the last pellet creation time
  }

  for (Pellet pellet : pellets) {
    pellet.drawPellet();  // Draw each pellet on the screen
  }
 
}

void eatPellet() {
  for (int i = pellets.size() - 1; i >= 0; i--) {
    int pelletX = pellets.get(i).posX;
    int pelletY = pellets.get(i).posY;

    float distance = dist(myBlob.posX, myBlob.posY, pelletX, pelletY);
    int blobRadius = myBlob.size;
    int pelletRadius = 10;

     if (distance <= blobRadius-pelletRadius) {
      //println("Eating pellet!");
      pellets.remove(i);  // Remove the eaten pellet from the list
      myBlob = new Blob(myBlob.posX, myBlob.posY, int(blobRadius+5));
    }
  }
}

void combineBlobs() {
  for (int i = myBlobs.size() - 1; i >= 0; i--) {
    Blob blob1 = myBlobs.get(i);
    for (int j = i - 1; j >= 0; j--) {
      Blob blob2 = myBlobs.get(j);
      float distance = dist(blob1.posX, blob1.posY, blob2.posX, blob2.posY);
      int combinedRadius = blob1.size / 2 + blob2.size / 2;

      if (distance <= combinedRadius) {
        int newSize = blob1.size + blob2.size;
        int newX = (blob1.posX + blob2.posX) / 2;
        int newY = (blob1.posY + blob2.posY) / 2;

        myBlobs.remove(i);  // Remove blob1
        myBlobs.remove(j);  // Remove blob2

        Blob combinedBlob = new Blob(newX, newY, newSize);
        myBlobs.add(combinedBlob);
        break;  // Exit the inner loop as we have combined the blobs
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    int blobRadius = myBlob.size;
    myBlob.size /= 2;
    myBlobs.add(new Blob(myBlob.posX + blobRadius, myBlob.posY, blobRadius / 2));
  }
}
