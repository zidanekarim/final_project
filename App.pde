int w;
int h;
float R;
float G;
float B;
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

  myBlob = new Blob(w, h, 50);
  lastPelletTime = millis();
  pellets = new ArrayList<Pellet>();
}


void draw() {
  background(255);
  myBlob.display();
  myBlob.followMouse();
  generatePellets();
  eatPellet();
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
      println("Eating pellet!");
      pellets.remove(i);  // Remove the eaten pellet from the list
      myBlob = new Blob(myBlob.posX, myBlob.posY, int(blobRadius+5));
    }
  }
}
