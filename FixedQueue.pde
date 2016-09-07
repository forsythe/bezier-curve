class FixedQueue {
  public Point[] arr;
  int index = 0; //points to oldest element to be rewritten

  FixedQueue(int size) {
    arr = new Point[size];
    for (int k = 0; k < arr.length; k++)
      arr[k] = new Point(0, 800);
  }

  void write(Point n) {

    arr[index++] = n;

    if (index >= arr.length) 
      index = 0;
  }

  void incrementXval(float p) {
    for (int k = 0; k < arr.length; k++)
      arr[k].x += p;
  }

  Point get(int n) {
    return arr[(index+n)%arr.length];
  }

  Point[] getOrderedArr() {
    Point[] ans = new Point[arr.length];
    int ansPos = 0;

    for (int k = index-1; k >= 0; k--) {
      ans[ansPos++] = arr[k];
    }
    for (int k = arr.length-1; k >= index; k--) {
      ans[ansPos++] = arr[k];
    }
    return ans;
  }

  String toString() {
    String ans = "";
    for (Point n : arr) 
      ans += n + " ";
    return ans;
  }
}