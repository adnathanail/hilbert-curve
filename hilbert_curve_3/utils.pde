int last2bits(int x) {
    return (x & 3);
}

int[] hindex2xy(int hindex, int N) {
    int[] tmp = POSITIONS[last2bits(hindex)];

    hindex = hindex >> 2;

    int x = tmp[0];
    int y = tmp[1];

    for (var n = 4; n <= N; n*= 2) {
    var n2 = n / 2;

    switch(last2bits(hindex)) {
        case 0: /* case A: left-bottom */
            int tmp2 = x; x = y; y = tmp2;
            break;

        case 1: /* case B: left-upper */
            y = y + n2;
            break;

        case 2: /* case C: right-upper */
            x = x + n2;
            y = y + n2;
            break;

        case 3: /* case D: right-bottom */
            int tmp3 = y;
            y = (n2-1) - x;
            x = (n2-1) - tmp3;
            x = x + n2;
            break;
    }

    hindex = hindex >> 2;
    }

    int[] out = {x, y};
    return out;
}

int cached_h2x(int hindex, int coord) {
    return (points[hindex][coord] + PADDING) * SCALE_FACTOR;
}

void load_next_food() {
    if (current_food != null) {
        freq = current_food.frequency;
    }
    if (food_locations.size() > 0) {
        current_food = food_locations.remove(0);
    } else {
        current_food.hidden = true;
    }
}