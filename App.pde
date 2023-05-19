int w;
int h;
float R;
float G;
float B;
Blob myBlob;

void setup() {
  size(1280, 720);
  w = width/2;
  h = height/2;
  R = random (255);
  G = random (255);
  B = random (255);

  myBlob = new Blob(w, h, 50);
}


void draw() {
  background(255);
  myBlob.display();
  myBlob.followMouse();
  generatePellets();
}


void generatePellets() {
 Pellet pell = new Pellet();
 pell.drawPellet();
  
  }
