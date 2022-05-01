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

float getFrequency(String note, int octave) {
    float keyNumber = NOTES.indexOf(note);

    if (keyNumber < 3) {
        keyNumber = keyNumber + 12 + ((octave - 1) * 12) + 1; 
    } else {
        keyNumber = keyNumber + ((octave - 1) * 12) + 1; 
    }

    // Return frequency of note
    return 440 * pow(2, (keyNumber - 49) / 12);
};