public class Blob {
    int posX;
    int posY;
    int size;
    color myColor;
   
    
    public Blob(int posX, int posY, int size) {
        this.posX = posX;
        this.posY = posY;
        this.size = size;
        myColor = color(R,G,B);
        
    }
    
    void followMouse() {
      float targetX = mouseX;
      float targetY = mouseY;
      float easing = 0.02;  // Adjust the easing value to control the speed of movement
    
      float dx = targetX - posX;
      float dy = targetY - posY;
      
      posX += dx * easing;
      posY += dy * easing;
    }
    
    void display() {
      stroke(0);
      fill(myColor);
      circle(posX, posY, size);
    }
}
