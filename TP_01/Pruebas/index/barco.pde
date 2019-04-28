class Barco {
    public PImage barcoFill;

    float r1 = random(1.2, 1.3);
    float r2 = random(1, 1.1);
    float r3 = random(4, 5.5);

    Barco () {
        barcoFill = loadImage("./data/img/muestreo-1.jpg");
    }

    Barco (Barco barcoObj) {
        /* 
        * Todas las instancias si existe mas de una, aprovechan la carga de
        * la imagen de la primer instancia para evitar cargar repetidas veces
        * el mismo archivo 
        */
        barcoFill = barcoObj.barcoFill;
    }

    public void display (float posX, float posY, int w, int h) {
        // Variables para selección de un punto random de la imagen de relleno entre 0 y su tamaño.
        int randomWidthCut = int(random(0, barcoFill.width - w));
        int randomHeightCut = int(random(0, barcoFill.height - h));

        // Obtengo un recorte del tamaño pasado por parametro desde un punto random de la imagen grande.
        barcoFill = barcoFill.get(randomWidthCut, randomHeightCut, w, h);

        // Aplico mascara de recorte sobre la imagen
        barcoFill.mask(this.drawMask(w, h));
        
        // Dibujo la imagen
        image(barcoFill, posX, posY);

        tint(255, 200);
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
