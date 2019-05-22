/*
Pintar relleno de barco con pinceladas con los colores obtenidos a trave de la clase paleta que paso emiliano.
*/
/*
Buscar libreria de glitch ,cortes en diagonal 6 por cuadro
*/

class Barco {
    public PGraphics barcoFill;
    public PImage trazo;
    public PImage trazoBlanco;
    public Paleta paleta;

    // Mascaras
    ArrayList <PImage> mascaras = new ArrayList<PImage>();
    int cantMascaras = 5;
    PImage mascara;

    // Posicion
    float px, py;

    Barco () {
        paleta = new Paleta("../img/muestreo-1.jpg");
        trazo = loadImage( "../img/trazo-03.png" );

        trazo.filter( INVERT );
        trazoBlanco = createImage( trazo.width, trazo.height, RGB );
        trazoBlanco.filter( INVERT );
        trazoBlanco.mask( trazo );

        cargarMascaras();

        mascara = this.getRandomMask();

        int mascaraWidth = mascara.width;
        int mascaraHeight = mascara.height;

        // Posicion de donde se va a dibujar la figura
        px = random(0, width - mascaraWidth);
        py = random(0, height - mascaraHeight);

        barcoFill = createGraphics(mascaraWidth, mascaraHeight);
    }

    public void display () {
        // Dibujo la imagen
        image(this.barcoFill, px, py);
    }

    public void pincelar (float mx, float my) {
        int w = this.barcoFill.width;
        int h = this.barcoFill.height;

        this.barcoFill.beginDraw();
            this.barcoFill.mask(mascara);
            this.barcoFill.image(trazoBlanco, mx, my, w * 0.2, h * 0.15);
            this.barcoFill.tint(paleta.darUnColor(80));
        this.barcoFill.endDraw();
    }

    private void cargarMascaras() {
        for (int i = 0; i < cantMascaras; i++)
        {
            setMascara("./../../img/mascaras2/Mascara_" + (i + 1) + ".png");
            println("Cargó: Mascara_" + (i + 1) + ".png");
        }
    }

    private void setMascara(String rutaImagen) {
        PImage nuevaMascara = loadImage(rutaImagen);
        mascaras.add(nuevaMascara);
    }

    private PImage getRandomMask () {
        int mascaraRandom = (int)random(0, cantMascaras);

        return mascaras.get(mascaraRandom);
    }
}
