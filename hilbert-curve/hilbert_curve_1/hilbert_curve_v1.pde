/**
 * Hilbert curve 
 * 
 * Based on this blog post
 * http://blog.marcinchwedczuk.pl/iterative-algorithm-for-drawing-hilbert-curve
 */

int N = 32;
int SCALE_FACTOR = 10;
int PADDING = 2;

int[][] POSITIONS = {
  {0, 0},
  {0, 1},
  {1, 1},
  {1, 0}
};

int[][] points = new int[N*N][];

int last2bits(int x) {
  return (x & 3);
}

int[] hindex2xy(int hindex, int N) {
  int[] tmp = POSITIONS[last2bits(hindex)];

  hindex = hindex >> 2;

  int x = tmp[0];
  int y = tmp[1];

  for (var n = 4; n <= N; n*= 2) {
    var n2 = n / 2;
    
    switch(last2bits(hindex)) {
      case 0: /* case A: left-bottom */
            int tmp2 = x; x = y; y = tmp2;
            break;

        case 1: /* case B: left-upper */
            y = y + n2;
            break;

        case 2: /* case C: right-upper */
            x = x + n2;
            y = y + n2;
            break;

        case 3: /* case D: right-bottom */
            int tmp3 = y;
            y = (n2-1) - x;
            x = (n2-1) - tmp3;
            x = x + n2;
            break;
    }
    
    hindex = hindex >> 2;
  }

  int[] out = {x, y};
  return out;
}

void settings() {
  int line_length = (N + 2 * PADDING) * SCALE_FACTOR;
  println(line_length);
  size(line_length, line_length);
}

void setup() {
  for (int i = 0; i < N*N; i++) {
    //println(hindex2xy(i, N));
    points[i] = hindex2xy(i, N);
  }

  strokeWeight(6);
  noLoop();  // Run once and stop
}

void draw() {
  //background(0);
  
  for (int i = 0; i < (N*N) - 1; i++) {
    line(
      (points[i][0] + PADDING) * SCALE_FACTOR,
      (points[i][1] + PADDING) * SCALE_FACTOR,
      (points[i + 1][0] + PADDING) * SCALE_FACTOR,
      (points[i + 1][1] + PADDING) * SCALE_FACTOR
    );
  }
}
