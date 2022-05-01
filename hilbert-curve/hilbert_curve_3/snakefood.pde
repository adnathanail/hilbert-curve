class SnakeFood extends GameObject {
    float frequency;
    boolean hidden;

    SnakeFood (String note, int octave, int in_hindex) {
        super(in_hindex);
        this.frequency = noteNameToFrequency(note, octave);
        this.hidden = false;
    }

    void draw() {
        if (!hidden) {
            point(
                get_x_location(),
                get_y_location()
            );
        }
    }
}
