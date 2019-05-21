import oscP5.*;
OscP5 oscP5;

Fondo fondo;
Settings settings;
ArrayList <Barco> barcos;

float x = 0, y = 0;

int cantBarcos;
int barcosADibujar;

void setup() {
    size(1000, 500);

    oscP5 = new OscP5(this,6969);
    settings = new Settings();
    settings.setOrientation(800);
    fondo = new Fondo();

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

    fondo.displayBgColor(0);

    fondo.mostrarLienzo();
    
    if (fondo.calcularPorcentajePintado() <= 98) {
        fondo.pincelarConMouse(x, y);
    } else {
        /*
        * mapeo a partir de la posicion en el eje x,
        * entre el ancho total y la cantidad de figuras a dibujar
        */
        barcosADibujar = round(map(mouseX, 0, width, 0, cantBarcos));

        for (int i = 0; i < barcosADibujar; i++) {
            int h = 400 - (i * 20);
            barcos.get(i).display(130);
        }
    }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
    if (theOscMessage.checkAddrPattern("/test")==true){
        x = theOscMessage.get(0).floatValue();
        y = theOscMessage.get(1).floatValue();

        x = map(x, width * .20, width * .80, 0, width);
        y = map(y, height * .10, height * .90, 0, height);
    }
}
