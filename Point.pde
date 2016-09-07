class Point {
  public float x = 0, y = 0;
  
  Point() {
  }

  Point(float x_rhs, float y_rhs) {
    x = x_rhs;
    y = y_rhs;
  }

  String toString() {
    return "("+x+", " + y + ")";
  }
}