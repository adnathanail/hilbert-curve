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
boolean first_run = true;

Snake snake = new Snake(10);
float freq = 27.50;

ArrayList<SnakeFood> food_locations = new ArrayList<SnakeFood>();
SnakeFood current_food;

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
    pulse.freq(freq);
    pulse.play();

    food_locations.add(new SnakeFood(15));
    food_locations.add(new SnakeFood(20));
    food_locations.add(new SnakeFood(30));
    food_locations.add(new SnakeFood(32));
    food_locations.add(new SnakeFood(37));  

    load_next_food();
}

void load_next_food() {
    if (food_locations.size() > 0) {
        current_food = food_locations.remove(0);
        current_food.draw();
        freq *= pow(1.05946, 6);
    }
}

void draw() {
    // Delay at the start to keep the audio changing, and screen drawing, in time
    if (first_run) {
        first_run = false;
    } else {
        delay(100);
    }

    snake.draw();

    if (snake.hindex == current_food.hindex) {
        load_next_food();
    }

    pulse.freq(freq);

    snake.hindex += 1;
}
