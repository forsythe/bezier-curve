int pointThickness = 8;
int lineThickness = 2;

int stepTime = 10;
int pixelIncrementPerStep = 1;

int dataPointsCache = 100; //how many data points to retain

void setup() {
  smooth();
  size(1500, 800);
  background(0);
  surface.setResizable(true);
  stroke(0, 255, 0);
  curTime = millis();
}

int curTime, elapsed;
FixedQueue q = new FixedQueue(dataPointsCache);

void draw() { 
  if (millis() - curTime >= stepTime) 
    update();
}

void update() {
  background(0);

  int tempData = getRandomData();
  if (tempData != -1) {
    q.write(new Point(0, height - tempData)); //to be replaced with actual data
  }

  elapsed = millis() - curTime;
  q.incrementXval((elapsed/(float)stepTime*pixelIncrementPerStep)); //steps * pixels per step = pixels
  curTime = millis();

  //println(elapsed/(float)stepTime*pixelIncrementPerStep);

  strokeWeight(lineThickness);
  drawGrid();
  drawConnectDots(q);

  strokeWeight(pointThickness);
  drawPoints(q);

  stroke(255, 0, 0);
  for (float k = 0; k < 1; k+=0.01)
    drawDCJ(q.getOrderedArr(), k);
  stroke(0, 255, 0);
}

int getRandomData() {
  return random(100)>90? int(random(200, 700)) : -1;
}

void drawGrid() {
  int index = 0;
  for (int k = 0; k <= width; k += pixelIncrementPerStep * 1000/stepTime) { // pixels/step * step/second = pixels/second
    line(k, height, k, 0);
    text(index++, k+5, height-5);
  }
}

void drawPoints(FixedQueue fq) {
  for (Point p : fq.arr) {
    point(p.x, p.y);
  }
}

void drawConnectDots(FixedQueue fq) {
  for (int k = 0; k < fq.index-1; k++) 
    line(fq.arr[k].x, fq.arr[k].y, fq.arr[k+1].x, fq.arr[k+1].y);

  for (int k = fq.index; k < fq.arr.length-1; k++) 
    line(fq.arr[k].x, fq.arr[k].y, fq.arr[k+1].x, fq.arr[k+1].y);

  if (fq.arr[fq.arr.length-1].x >= fq.arr[0].x) //prevent last point connecting to first point, forming a weird loop
    line(fq.arr[fq.arr.length-1].x, fq.arr[fq.arr.length-1].y, fq.arr[0].x, fq.arr[0].y);
}

void drawDCJ(Point[] points, float t) {
  if (points.length==1) {
    point(points[0].x, points[0].y);
  } else {
    Point[] newpoints = new Point[points.length-1];
    for (int k = 0; k < newpoints.length; k++) {
      float x = (1-t) * points[k].x + t * points[k+1].x;
      float y = (1-t) * points[k].y + t * points[k+1].y;
      newpoints[k] = new Point(x, y);
    }
    drawDCJ(newpoints, t);
  }
}