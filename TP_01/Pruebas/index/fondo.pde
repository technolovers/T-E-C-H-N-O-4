class Fondo {
    private float noiseScale = 0.0;
    private float noiseInc = 0.005;
    private int[] noiseVals;

    Fondo () {
       noiseVals = new int[width];

       for(int x=0; x < noiseVals.length; x++) {
            int noiseVal = int(noise(noiseScale)*80);
            noiseVals[x] = noiseVal;
            noiseScale += noiseInc;
        }
    }

    void display () {
        for (int x=0; x < noiseVals.length; x++) {
            int strokeVal = int(noiseVals[x]);
            stroke(strokeVal);
            line(x, 0, x, height);
        }
    }
}
