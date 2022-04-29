class SnakeFood extends GameObject {
    SnakeFood (int in_hindex) {
        super(in_hindex);
    }

    void draw() {
        point(
            get_x_location(),
            get_y_location()
        );
    }
}
