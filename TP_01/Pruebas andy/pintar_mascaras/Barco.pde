/*
Pintar relleno de barco con pinceladas con los colores obtenidos a trave de la clase paleta que paso emiliano.
*/
/*
Buscar libreria de glitch ,cortes en diagonal 6 por cuadro
*/

class Barco {
    public PImage barcoFill;
    public PImage trazo;
    public PImage trazoBlanco;
    public Paleta paleta;

    // Mascaras
    ArrayList <PImage> mascaras = new ArrayList<PImage>();
    int cantMascaras = 5;
    PImage mascara;

    // Posicion y tamaño
    float px, py;

    // rangos randoms para deformar los rectangulos.
    private float r1 = random(1.2, 1.3);
    private float r2 = random(1, 1.1);
    private float r3 = random(4, 5.5);

    Barco () {
        paleta = new Paleta("../img/muestreo-1.jpg");
        trazo = loadImage( "../img/trazo-03.png" );

        trazo.filter( INVERT );
        trazoBlanco = createImage( trazo.width, trazo.height, RGB );
        trazoBlanco.filter( INVERT );
        trazoBlanco.mask( trazo );

        this.barcoFill = this.drawFill();

        cargarMascaras();

        mascara = this.getRandomMask();
        px = random(0, width - (mascara.width / 2));
        py = random(0, height - (mascara.height / 2));
    }

    Barco (Barco barcoObj) {
        /* 
        * Todas las instancias si existe mas de una, aprovechan la carga del
        * relleno de la primer instancia
        */
        barcoFill = barcoObj.barcoFill;
        mascaras = barcoObj.mascaras;

        mascara = this.getRandomMask();
        px = random(0, width - (mascara.width / 2));
        py = random(0, height - (mascara.height / 2));
    }

    void cargarMascaras()
    {
        for (int i = 0; i < cantMascaras; i++)
        {
            setMascara("./../../img/mascaras2/Mascara_" + (i + 1) + ".png");
            println("Cargó: Mascara_" + (i + 1) + ".png");
        }
    }

    void setMascara(String rutaImagen)
    {
        PImage nuevaMascara = loadImage(rutaImagen);
        mascaras.add(nuevaMascara);
    }

    public void display () {
        int mascaraWidth = mascara.width;
        int mascaraHeight = mascara.height;

        // Variables para selección de un punto random de la imagen de relleno entre 0 y su tamaño.
        int randomXCut = int(random(0, this.barcoFill.width - mascaraWidth));
        int randomYCut = int(random(0, this.barcoFill.height - mascaraHeight));

        // Obtengo un recorte del tamaño pasado por parametro desde un punto random de la imagen grande.
        this.barcoFill = this.barcoFill.get(randomXCut, randomYCut, mascaraWidth, mascaraHeight);

        // Aplico mascara de recorte sobre la imagen
        this.barcoFill.mask(mascara);
        
        // Dibujo la imagen
        image(this.barcoFill, px, py);
    }

    private PImage drawFill () {
        PGraphics barcoFill;
        int w = width;
        int h = height;

        barcoFill = createGraphics(w, h);

        barcoFill.beginDraw();
            for (int i = 0; i < width+height; ++i) {
                barcoFill.image(trazoBlanco, random(w) - (w * 0.3 / 2), random(h), w * 0.2, h * 0.05);
                barcoFill.tint(paleta.darUnColor(random(20, 60)));
            }
        barcoFill.endDraw();

        return barcoFill;
    }

    private PImage getRandomMask () {
        int mascaraRandom = (int)random(0, cantMascaras);

        return mascaras.get(mascaraRandom);
    }

    private PImage drawMask (int w, int h) {
        /*
        * Este metodo crea una forma con PGraphics y retorna un PImage
        * para utilizar como mascara de recorte.
        */
        PGraphics cutShape;
        cutShape = createGraphics(w, h);

        float x1, y1;
        float x2, y2;
        float x3, y3;
        float x4, y4;

        x1 = 0;
        y1 = h - (h / r1);

        x2 = w;
        y2 = h - (h / r2);

        x3 = w - (w / r3);
        y3 = h;

        x4 = 0;
        y4 = h;

        cutShape.beginDraw();
        cutShape.noStroke();
        cutShape.quad(x1, y1, x2, y2, x3, y3, x4, y4);
        cutShape.endDraw();

        return cutShape;
    }
}
