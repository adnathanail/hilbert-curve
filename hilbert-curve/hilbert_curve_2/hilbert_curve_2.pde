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

int[][] points = new int[N*N][];

Snake snake = new Snake(10);
float freq = 27.50;

ArrayList<SnakeFood> food_locations = new ArrayList<SnakeFood>();
SnakeFood current_food_location;

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

  food_locations.add(new SnakeFood(15));
  food_locations.add(new SnakeFood(20));
  food_locations.add(new SnakeFood(30));
  food_locations.add(new SnakeFood(32));
  food_locations.add(new SnakeFood(37));  

  current_food_location = new SnakeFood(0);
}

int snake_location(int hindex, int coord) {
 return (points[hindex][coord] + PADDING) * SCALE_FACTOR;
}

void draw_snake() {
  for (int i = 0; i < min(snake.hindex, (N*N) - 1); i++) {
    line(
      snake_location(i, 0),
      snake_location(i, 1),
      snake_location(i+1, 0),
      snake_location(i+1, 1)
    );
  }
}

void draw() {
  // Delay at the start to keep the audio changing, and screen drawing, in time
  delay(100);

  draw_snake();

  if (food_locations.size() > 0) {
    println(1);
    println(
      snake.hindex == 10 || (
          snake.snake_x_location() == snake_location(current_food_location.hindex, 0) &&
          snake.snake_y_location() == snake_location(current_food_location.hindex, 1)
        )
    );
    println(snake.hindex);
    println(current_food_location.hindex);
    if (
        snake.hindex == 10 || (
          snake.snake_x_location() == snake_location(current_food_location.hindex, 0) &&
          snake.snake_y_location() == snake_location(current_food_location.hindex, 1)
        )) {  // First run
      println(2);
      current_food_location = food_locations.remove(0);
      point(
        snake_location(current_food_location.hindex, 0),
        snake_location(current_food_location.hindex, 1)
      );
      freq *= pow(1.05946, 6);
    }
  }

  pulse.freq(freq);

  snake.hindex += 1;
}
