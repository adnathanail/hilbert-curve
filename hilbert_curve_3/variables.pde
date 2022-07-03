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

int[][] points = new int[N*N][];
boolean first_run = true;

Snake snake = new Snake(1);  // TODO make this 0
float freq = 0;

ArrayList<SnakeFood> food_locations = new ArrayList<SnakeFood>();
SnakeFood current_food;
ArrayList<String> NOTES = new ArrayList();
