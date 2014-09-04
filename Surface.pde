import java.awt.Point;

public class Surface {

  private Point[] v;
  private PImage img;


  public Surface(PImage img, Point v0, Point v1, Point v2, Point v3) {
    this.img = img;
    this.v = new Point[]{v0, v1, v2, v3};
  }
  
  public Surface(PImage img, int x, int y, int width, int height) {
    this(img,
         new Point(x, y), new Point(x+width, y),
         new Point(x+width, y+height), new Point(x, y+height));
  }

  public void draw() {
    noStroke();
    beginShape(QUAD_STRIP);
    texture(img);
    int n = 128;
    for (int i = 0; i <= n; i++) {
      float ratio = i / (float)n;

      float x = v[0].x + ratio * (v[1].x - v[0].x);
      float y = v[0].y + ratio * (v[1].y - v[0].y);
      vertex(x, y, ratio*img.width, 0);

      x = v[3].x + ratio * (v[2].x - v[3].x);
      y = v[3].y + ratio * (v[2].y - v[3].y);
      vertex(x, y, ratio*img.width, img.height);
    }
    endShape(CLOSE);
  }

  public Point[] getVertices() { return v; }
}
