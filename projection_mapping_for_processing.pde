import processing.video.*;
import java.awt.Point;

PImage img;
// Movie movie;
Surface[] surfaces;

int selectedSurfaceIndex;
Point selectedVertex;

boolean adjustMode;


void setup() {
  size(1024, 768, P3D);
  
  img = loadImage("test.png");
  /* You can use movie files as well as image files. */
  // movie = new Movie(this, "test.mp4");
  // movie.loop();
  
  surfaces = new Surface[3];
  for (int i = 0; i < surfaces.length; i++) {
    surfaces[i] = new Surface(img,
                              (width*i)/(surfaces.length+1), (height*i)/(surfaces.length+1),
                              width/(surfaces.length+1), height/(surfaces.length+1));
  }
  
  selectedSurfaceIndex = 0;
}

void draw() {
  background(0);

  surfaces[0].draw();
  surfaces[1].draw();
  surfaces[2].draw();

  if (adjustMode) adjustMode();
}

void movieEvent(Movie m) { m.read(); }

void mousePressed() {
  if (!adjustMode) return;
  double minDist = Double.MAX_VALUE;
  Surface surface = surfaces[selectedSurfaceIndex];
  for (Point p : surface.getVertices()) {
    double d = p.distance(new Point(mouseX, mouseY));
    if (d < minDist) {
      minDist = d;
      selectedVertex = p;
    }
  }
}
void mouseDragged() { if (adjustMode) selectedVertex.setLocation(mouseX, mouseY); }
void mouseReleased() { if (adjustMode) selectedVertex = null; }

void keyPressed() {
  if (key == 'a') {
    adjustMode = !adjustMode;
  }

  // select adjusted surface
  if (key == 'n') {
    selectedSurfaceIndex = (selectedSurfaceIndex+1) % surfaces.length;
  } else if (key == 'p') {
    selectedSurfaceIndex = (surfaces.length + selectedSurfaceIndex-1) % surfaces.length;
  }
}

void adjustMode() {
  for (Surface surface : surfaces) {
    ellipseMode(CENTER);

    stroke(255, 255, 255);
    if (surface == surfaces[selectedSurfaceIndex]) {
      stroke(255, 255, 0);
      strokeWeight(3);
    } else {
      stroke(255);
      strokeWeight(1);
    }
    noFill();    
    beginShape();
    Point[] vertices = surface.getVertices();
    for (Point v : vertices) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }

  // show grid
  int gridSize = 10;
  stroke(127, 127);
  strokeWeight(1);
  for (int x = 0; x < width; x+=gridSize) {
    line(x, 0, x, height);
  }
  for (int y = 0; y < height; y+=gridSize) {
    line(0, y, width, y);
  }
}