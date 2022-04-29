class Snake extends GameObject { 
    int hindex;
    int length;

    Snake (int hindex) {
        super(hindex);
        this.length = 0;
    }

    void draw() {
    for (int i = 0; i < min(hindex, (N*N) - 1); i++) {
        line(
            cached_h2x(i, 0),
            cached_h2x(i, 1),
            cached_h2x(i+1, 0),
            cached_h2x(i+1, 1)
        );
    }
    }
} 
