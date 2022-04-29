/**
 * Hilbert curve 
 * 
 * Based on this blog post
 * http://blog.marcinchwedczuk.pl/iterative-algorithm-for-drawing-hilbert-curve
 */

import processing.sound.*;
Pulse pulse;

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

int[] hindex2xy(int hindex, int N) {
  l2b = last2bits(hindex & 3)
  int[] tmp = POSITIONS[l2b];

  hindex = hindex >> 2;

  int x = tmp[0];
  int y = tmp[1];

  for (var n = 4; n <= N; n*= 2) {
    var n2 = n / 2;
    
    switch(l2b) {
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

  size(line_length, line_length);
}

void setup() {
  for (int i = 0; i < N*N; i++) {
    points[i] = hindex2xy(i, N);
  }

  strokeWeight(6);
  pulse = new Pulse(this);
  pulse.play();
}

void snake_location(hindex, coord) {
  return (points[hindex][coord] + PADDING) * SCALE_FACTOR;
}

void draw_snake() {
  for (int i = 0; i < min(snake_length, (N*N) - 1); i++) {
    line(
      snake_location(i, 0),
      snake_location(i, 1),
      snake_location(i+1, 0),
      snake_location(i+1, 1),
    );
  }
}

int snake_length = 10;

void draw() {
  draw_snake();
  pulse.freq(int(0.01 * (pow(snake_length,2 ))));

  snake_length += 1;

  delay(100);
}
