class Blob {
  public int posX;
  public int posY;
  public int size;
  public color myColor;
  public boolean touching = false; 

  public Blob(int posX, int posY, int size, color myColor) {
    this.posX = posX;
    this.posY = posY;
    this.size = size;
    this.myColor = myColor;
  }

  void update() {
    checkBoundary();
  }

  void checkBoundary() {
    if (posX < 0) {
      posX = width;
    } else if (posX > width) {
      posX = 0;
    }

    if (posY < 0) {
      posY = height;
    } else if (posY > height) {
      posY = 0;
    }
    
    
  }

  void followMouse() {
    float targetX = mouseX;
    float targetY = mouseY;
    float easing = (1.0 / size);

    float dx = targetX - posX;
    float dy = targetY - posY;

    posX += dx * easing;
    posY += dy * easing;
  }

  void eatPellet() {
    for (int i = pellets.size() - 1; i >= 0; i--) {
      int pelletX = pellets.get(i).posX;
      int pelletY = pellets.get(i).posY;

      float distance = dist(posX, posY, pelletX, pelletY);
      int blobRadius = size / 2;
      int pelletRadius = 10;

      if (distance <= blobRadius - pelletRadius) {
        pellets.remove(i);
        size += 5; // Increase the size of the blob when eating a pellet
      }
    }
  }

  void display() {
    stroke(0);
    fill(myColor);
    circle(posX, posY, size);
  }
  void checkCollision() {
    for (Blob other : myBlobs) {
      if (other != this) {
        float minDist = size / 2 + other.size / 2;
        float actualDist = dist(posX, posY, other.posX, other.posY);
        if (actualDist < minDist) {
          PVector direction = PVector.sub(new PVector(other.posX, other.posY), new PVector(posX, posY));
          direction.normalize();
          PVector correction = direction.mult((minDist - actualDist) / 2);
          posX -= correction.x;
          posY -= correction.y;

          touching = true;  // Set the touching variable to true
        }
      }
    }
  }
}
