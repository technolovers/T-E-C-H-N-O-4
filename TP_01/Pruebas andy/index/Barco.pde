class Barco {
    public Paleta paleta = new Paleta("../img/muestreo-1.jpg");
    public Utils utils = new Utils();

    public PGraphics barcoFill;
    public PImage trazo;
    public PImage trazoBlanco;

    // Mascaras
    ArrayList <PImage> mascaras = new ArrayList<PImage>();
    int cantMascaras = 5;
    PImage mascara;

    // Posicion
    float px, py;

    Barco () {
        // cargarMascaras();

        this.prepararTrazo();
        mascara = this.getRandomMask();

        int mascaraWidth = mascara.width;
        int mascaraHeight = mascara.height;

        // Posicion de donde se va a dibujar la figura
        px = random(0, width - mascaraWidth);
        py = random(0, height - mascaraHeight);

        barcoFill = createGraphics(mascaraWidth, mascaraHeight);
    }

    public void display () {
        image(barcoFill, px, py);
    }

    public void pincelar (float mx, float my) {
        int w = barcoFill.width;
        int h = barcoFill.height;

        barcoFill.beginDraw();
            barcoFill.mask(mascara);
            barcoFill.imageMode(CENTER);
            barcoFill.image(trazoBlanco, mx, my, w * 0.2, h * 0.15);
            barcoFill.tint(paleta.darUnColor(80));
        barcoFill.endDraw();

        println("porcentajeBarcoPintado: "+utils.calcularPorcentajePintado(barcoFill));
    }

    private PImage getRandomMask () {
        int numMascara = (int)random(0, cantMascaras);
        PImage mascaraRandom = loadImage("./../../img/mascaras2/Mascara_" + numMascara + ".png");
        println("Cargó: Mascara_" + numMascara + ".png");
        return mascaraRandom;
    }

    private void prepararTrazo () {
        trazo = loadImage( "../img/trazo-01.png" );

        trazo.filter( INVERT );
        trazoBlanco = createImage( trazo.width, trazo.height, RGB );
        trazoBlanco.filter( INVERT );
        trazoBlanco.mask( trazo );
    }
}
