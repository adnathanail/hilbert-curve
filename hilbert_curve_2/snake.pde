class Snake extends GameObject { 
    int length;

    Snake (int in_hindex) {
        super(in_hindex);
        this.length = 1;
    }

    void draw() {
        int end_point = min(hindex, (N*N) - 1);
        for (int i = end_point - this.length; i < end_point; i++) {
            line(
                cached_h2x(i, 0),
                cached_h2x(i, 1),
                cached_h2x(i+1, 0),
                cached_h2x(i+1, 1)
            );
        }
    }
} 
