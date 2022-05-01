class GameObject { 
    int hindex;

    GameObject (int in_hindex) {
        this.hindex = in_hindex;
    }

    int get_location(int coord) {
        return (points[this.hindex][coord] + PADDING) * SCALE_FACTOR;
    }
    int get_x_location() {
        return get_location(0);
    }
    int get_y_location() {
        return get_location(1);
    }
} 
