int w;
int h;
float R;  
float G;  
float B;

void setup() {
   size(1280, 720);
   w = width/2;
   h = height/2;
   R = random (255); 
   G = random (255); 
   B = random (255); 
   color myColor = color(R,G,B);
   fill(myColor);
   Blob myBlob = new Blob(w, h, 50);
}
