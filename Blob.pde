public class Blob {
    int posX;
    int posY;
    int size;
    
    public Blob(int posX, int posY, int size) {
        this.posX = posX;
        this.posY = posY;
        this.size = size;
        circle(posX, posY, size);
    }
}
