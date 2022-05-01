float noteNameToFrequency(String note, int octave) {
    float keyNumber = NOTES.indexOf(note);

    if (keyNumber < 3) {
        keyNumber = keyNumber + 12 + ((octave - 1) * 12) + 1; 
    } else {
        keyNumber = keyNumber + ((octave - 1) * 12) + 1; 
    }

    // Return frequency of note
    return 440 * pow(2, (keyNumber - 49) / 12);
};

float midiNoteToFrequency(int midi_note) {
    return 440 * pow(2.0, (midi_note - 69) / 12.0);
}