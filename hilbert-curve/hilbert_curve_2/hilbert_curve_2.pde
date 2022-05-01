import processing.sound.*;
Pulse pulse;

int N = 32;
int SCALE_FACTOR = 10;
int PADDING = 2;
int NOTE_STARTER_OFFSET = 4;
int SPEED_SCALE = 2; // 2 means play at half speed

int[][] POSITIONS = {
  {0, 0},
  {0, 1},
  {1, 1},
  {1, 0}
};
String[] NOTES_STR = {"A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"};

Note[] SONG = {
    new Note("D", 3, 2), new Note("E", 3, 2), new Note("F", 3, 2), new Note("G", 3, 2),
    new Note("A", 3, 2), new Note("F", 3, 2), new Note("A", 3, 4),

    new Note("G#", 3, 2), new Note("E", 3, 2), new Note("G#", 3, 4),
    new Note("G", 3, 2), new Note("D#", 3, 2), new Note("G", 3, 4),

    new Note("D", 3, 2), new Note("E", 3, 2), new Note("F", 3, 2), new Note("G", 3, 2),
    new Note("A", 3, 2), new Note("F", 3, 2), new Note("A", 3, 2), new Note("D", 4, 2),

    new Note("C", 4, 2), new Note("A", 3, 2), new Note("F", 3, 2), new Note("A", 3, 2),
    new Note("C", 4, 8),
};

int[][] points = new int[N*N][];
boolean first_run = true;

Snake snake = new Snake(1);  // TODO make this 0
float freq = 0;

ArrayList<SnakeFood> food_locations = new ArrayList<SnakeFood>();
SnakeFood current_food;
ArrayList<String> NOTES = new ArrayList();

void settings() {
    int line_length = (N + 2 * PADDING) * SCALE_FACTOR;

    size(line_length, line_length);
}

void setup() {
    for (int i = 0; i < N*N; i++) {
        points[i] = hindex2xy(i, N);
    }

    // Add all the notes to the list
    for (var i = 0; i < 12; i++) {
        NOTES.add(NOTES_STR[i]);
    }

    strokeWeight(6);
    pulse = new Pulse(this);
    pulse.freq(freq);
    pulse.play();

    int current_hindex = NOTE_STARTER_OFFSET;

    for (int i = 0; i < SONG.length; i++) {
        food_locations.add(new SnakeFood(SONG[i].note, SONG[i].octave, current_hindex * SPEED_SCALE));
        current_hindex += SONG[i].duration;
    }
    // TODO make the song stop

    load_next_food();
}

void load_next_food() {
    if (current_food != null) {
        freq = current_food.frequency;
    }
    if (food_locations.size() > 0) {
        current_food = food_locations.remove(0);
    } else {
        current_food.hidden = true;
    }
}

void draw() {
    // Delay at the start to keep the audio changing, and screen drawing, in time
    if (first_run) {
        first_run = false;
    } else {
        delay(100);
    }

    if (snake.hindex == current_food.hindex) {
        load_next_food();
        snake.length += 1;
    }

    background(150);
    snake.draw();
    current_food.draw();
    pulse.freq(freq);

    snake.hindex += 1;
}
