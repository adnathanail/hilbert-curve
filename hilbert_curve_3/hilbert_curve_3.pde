import processing.sound.*;
import javax.sound.midi.*;
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

    String path = dataPath("28672.mid");
    File midiFile = new File(path);
    try {
        Sequence seq = MidiSystem.getSequence(midiFile);
        Track[] tracks = seq.getTracks();

        // how many tracks are there
        println("number of tracks: " + tracks.length);

        // parse first track
        println("events of 1st track:");
        Track myTrack = tracks[1];

        int current_hindex = NOTE_STARTER_OFFSET;
        // TODO make the song stop

        // for (int j = 0; j < myTrack.size(); j++) {
        for (int j = 0; j < 100; j++) {
            // get midi-message for every event
            if (myTrack.get(j).getMessage() instanceof ShortMessage) {
                ShortMessage m =  (ShortMessage) myTrack.get(j).getMessage();

                // log note-on or note-off events
                int cmd = m.getCommand();
                if (cmd == ShortMessage.NOTE_OFF || cmd == ShortMessage.NOTE_ON) {
                    print( (cmd==ShortMessage.NOTE_ON ? "NOTE_ON" : "NOTE_OFF") + "; ");
                    print("channel: " + m.getChannel() + "; ");
                    print("note: " + m.getData1() + "; ");
                    // print("freq: " + midiNoteToFrequency(m.getData1()) + "; ");
                    println("velocity: " + m.getData2());

                    food_locations.add(new SnakeFood(midiNoteToFrequency(m.getData1()), current_hindex * SPEED_SCALE));
                    current_hindex += 2;
                }
            }
        }
        println();
    } catch(Exception e) {
        e.printStackTrace();
        exit();
    }

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
