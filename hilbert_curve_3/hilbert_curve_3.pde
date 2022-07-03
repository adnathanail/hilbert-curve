import processing.sound.*;
import javax.sound.midi.*;
Pulse pulse;

void settings() {
    int line_length = (N + 2 * PADDING) * SCALE_FACTOR;

    size(line_length, line_length);
}

void addNotesToTrack(Track track, Track trk) throws InvalidMidiDataException {
    for (int ii = 0; ii < track.size(); ii++) {
        MidiEvent me = track.get(ii);
        MidiMessage mm = me.getMessage();
        if (mm instanceof ShortMessage) {
            ShortMessage sm = (ShortMessage) mm;
            int command = sm.getCommand();
            int com = -1;
            if (command == ShortMessage.NOTE_ON) {
                com = 1;
            } else if (command == ShortMessage.NOTE_OFF) {
                com = 2;
            }
            if (com > 0) {
                byte[] b = sm.getMessage();
                int l = (b == null ? 0 : b.length);
                MetaMessage metaMessage = new MetaMessage(com, b, l);
                MidiEvent me2 = new MidiEvent(metaMessage, me.getTick());
                trk.add(me2);
            }
        }
    }
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
    // pulse = new Pulse(this);
    // pulse.freq(freq);
    // pulse.play();

    String path = dataPath("28672.mid");
    File midiFile = new File(path);
    try {
        Sequence sequence = MidiSystem.getSequence(midiFile);

        Sequencer sequencer = MidiSystem.getSequencer(); // Get the default Sequencer
        sequencer.open(); // Open device

        MetaEventListener mel = new MetaEventListener() {
            @Override
            public void meta(MetaMessage meta) {
                final int type = meta.getType();
                System.out.println("MEL - type: " + type);
            }
        };
        sequencer.addMetaEventListener(mel);

        int[] types = new int[128];
        for (int ii = 0; ii < 128; ii++) {
            types[ii] = ii;
        }
        ControllerEventListener cel = new ControllerEventListener() {

            @Override
            public void controlChange(ShortMessage event) {
                int command = event.getCommand();
                if (command == ShortMessage.NOTE_ON) {
                    System.out.println("CEL - note on!");
                } else if (command == ShortMessage.NOTE_OFF) {
                    System.out.println("CEL - note off!");
                } else {
                    System.out.println("CEL - unknown: " + command);
                }
            }
        };
        int[] listeningTo = sequencer.addControllerEventListener(cel, types);
        StringBuilder sb = new StringBuilder();
        for (int ii = 0; ii < listeningTo.length; ii++) {
            sb.append(ii);
            sb.append(", ");
        }
        System.out.println("Listenning to: " + sb.toString());

        Track[] tracks = sequence.getTracks();
        Track trk = sequence.createTrack();
        for (Track track : tracks) {
            addNotesToTrack(track, trk);
        }

        sequencer.setSequence(sequence); // load it into sequencer
        sequencer.start();  // start the playback

    } catch(Exception e) {
        e.printStackTrace();
        exit();
    }

    food_locations.add(new SnakeFood(midiNoteToFrequency(60), 10));
    load_next_food();
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
    // pulse.freq(freq);

    snake.hindex += 1;
}
