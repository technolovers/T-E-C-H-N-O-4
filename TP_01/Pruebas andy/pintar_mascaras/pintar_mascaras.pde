ArrayList <Barco> barcos;

int cantBarcos;
int barcosADibujar;

void setup() {
    size(1000, 500);

    barcos = new ArrayList<Barco>();
    cantBarcos = 4;

    for (int i = 0; i < cantBarcos; i++) {
        // La primer instancia carga sin parametros.
        if (i == 0) {
            Barco a = new Barco();
            barcos.add( a );
        } else {
            Barco b = new Barco(barcos.get(0));
            barcos.add( b );
        }
    }
}

void draw() {
    background(0);
    /*
    * mapeo a partir de la posicion en el eje x,
    * entre el ancho total y la cantidad de figuras a dibujar
    */
    barcosADibujar = round(map(mouseX, 0, width, 0, cantBarcos));

    for (int i = 0; i < barcosADibujar; i++) {
        int h = 400 - (i * 20);
        barcos.get(i).display();
    }
}
