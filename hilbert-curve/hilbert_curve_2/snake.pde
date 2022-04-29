class Snake extends GameObject { 
    int length;

    Snake (int in_hindex) {
        super(in_hindex);
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
