import java.awt.Point;

public class Surface {

  private Point[] v;


  public Surface(Point v0, Point v1, Point v2, Point v3) {
    this.v = new Point[]{v0, v1, v2, v3};
  }
  
  public Surface(int x, int y, int width, int height) {
    Point[] v = new Point[4];
    v[0] = new Point(x, y);
    v[1] = new Point(x+width, y);
    v[2] = new Point(x+width, y+height);
    v[3] = new Point(x, y+height);
    this.v = v;
  }

  public void draw(PImage img) {
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
