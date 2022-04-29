class GameObject { 
    int hindex;

    GameObject (int hindex) {  
        this.hindex = hindex; 
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
