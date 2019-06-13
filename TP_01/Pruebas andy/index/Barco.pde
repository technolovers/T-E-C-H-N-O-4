class Barco {
    public Paleta paleta = new Paleta("../img/muestreo-1.jpg");
    public Utils utils = new Utils();

    public PGraphics barcoFill;
    public PImage trazo;
    public PImage trazoBlanco;

    // Mascaras
    ArrayList <PImage> mascaras = new ArrayList<PImage>();
    int cantMascaras = 16;
    PImage mascara;

    // Posicion
    float px, py;

    //porcentaje de pintado
    int pintados, porcentajePintado = 0;
    boolean cargoPixelesMascara = false;
    IntList pixelesMascara = new IntList();

    Barco () {
        mascara = this.getRandomMask();

        int mascaraWidth = mascara.width;
        int mascaraHeight = mascara.height;

        // Posicion de donde se va a dibujar la figura
        px = random(0, width - mascaraWidth);
        py = random(0, height - mascaraHeight);

        barcoFill = createGraphics(mascaraWidth, mascaraHeight);

        this.prepararTrazo();
    }

    public void display () {
        image(barcoFill, px, py);
    }

    public void pincelar (float mx, float my) {
        float mapX = mx - px;
        float mapY = my - py;

        barcoFill.beginDraw();
            barcoFill.mask(mascara);
            barcoFill.imageMode(CENTER);
            barcoFill.image(trazoBlanco, mapX, mapY);
            barcoFill.tint(paleta.darUnColor(130));
        barcoFill.endDraw();

        this.calcularPorcentajePintado(barcoFill);
    }

    public int calcularPorcentajePintado (PGraphics pg) {
        pintados = 0;

        pg.beginDraw();
        pg.loadPixels();
        // Guardar posiciones de pixeles de la mascara
        for (int x = 0; x < pg.width; ++x) {
            for (int y = 0; y < pg.height; ++y) {
                int pixelIndex = x + y * pg.width;
                float a = alpha(pg.pixels[pixelIndex]);

                if (a != 0 && cargoPixelesMascara == false) {
                    pixelesMascara.append(pixelIndex);
                }
            }
        }
        // Carga los pixeles que pertenecen a la mascara solo la primera vez
        cargoPixelesMascara = true;

        int totalPixelesMascara = pixelesMascara.size();
        // Chequea solo los pixeles dentro de la mascara
        for (int j = 0; j < totalPixelesMascara; ++j) { 
            int index = pixelesMascara.get(j);
            float r = red(pg.pixels[index]);
            float g = green(pg.pixels[index]);
            float b = blue(pg.pixels[index]);

            // pinta los pixeles de la mascara (debug)
            // pg.pixels[index] = color(0, 255, 0);

            if (r != 0 && g != 0 && b != 0) {
                pintados += 1;
            }

            porcentajePintado = (pintados * 100) / totalPixelesMascara;
        }

        println("Porcentaje pintado mascara: " + porcentajePintado);
        pg.updatePixels();
        pg.endDraw();

        return porcentajePintado;
    }

    private PImage getRandomMask () {
        int numMascara = (int)random(1, cantMascaras);
        PImage mascaraRandom = loadImage("./../img/Mascaras/" + numMascara + ".png");
        println("Cargó: Mascara_" + numMascara + ".png");
        return mascaraRandom;
    }

    private void prepararTrazo () {
        int w = barcoFill.width;
        int h = barcoFill.height;
        int pincelW = int(w * 0.3);
        int pincelH = int(h * 0.2);

        trazo = loadImage( "../img/trazo-02.png" );
        trazo.resize(pincelW, pincelH);

        trazo.filter( INVERT );
        trazoBlanco = createImage( pincelW, pincelH, RGB );
        trazoBlanco.filter( INVERT );
        trazoBlanco.mask( trazo );
    }
}
