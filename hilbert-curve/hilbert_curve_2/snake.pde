class Snake { 
  int hindex; 
  int length;
  Snake (int hindex) {  
    this.hindex = hindex; 
    this.length = 0;
  }

  int snake_location(int coord) {
    return (points[this.hindex][coord] + PADDING) * SCALE_FACTOR;
  }
  int snake_x_location() {
    return snake_location(0);
  }
  int snake_y_location() {
    return snake_location(1);
  }
} 
