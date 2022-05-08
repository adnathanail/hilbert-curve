class SnakeFood extends GameObject {
    float frequency;
    boolean hidden;

    SnakeFood (float in_frequency, int in_hindex) {
        super(in_hindex);
        this.frequency = in_frequency;
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
