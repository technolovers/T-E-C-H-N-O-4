import oscP5.*;
OscP5 oscP5;

Fondo fondo;
Settings settings;
ArrayList <Barco> barcos;

float x = 0, y = 0;

int cantBarcos;
int barcosADibujar = 1;

// setear modo, modo "mouse" o modo "osc" (borrar en entrega final)
String setMode = "mouse";

void setup() {
    size(1000, 500);

    oscP5 = new OscP5(this,6969);
    settings = new Settings();
    settings.setOrientation(800);
    fondo = new Fondo();

    barcos = new ArrayList<Barco>();
    cantBarcos = 4;

    for (int i = 0; i < cantBarcos; i++) {
        Barco a = new Barco();
        barcos.add( a );
    }
}

void draw() {

    fondo.displayBgColor(0);

    fondo.mostrarLienzo();

    for (Barco barco : barcos) {
        barco.display();
    }
    if (setMode.equals("mouse")) {
        if (fondo.calcularPorcentajePintado() <= 90) {
            fondo.pincelarConMouse(mouseX, mouseY);
        } else {
            for (int i = 0; i < barcosADibujar; i++) {
                barcos.get(i).pincelar(mouseX, mouseY);
            }
        }
    }
    if (setMode.equals("osc")) {
        if (fondo.calcularPorcentajePintado() <= 90) {
            fondo.pincelarConMouse(x, y);
        } else {
            for (int i = 0; i < barcosADibujar; i++) {
                barcos.get(i).pincelar(x, y);
            }
        }
    }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
    if (theOscMessage.checkAddrPattern("/test")==true){
        x = theOscMessage.get(0).floatValue();
        y = theOscMessage.get(1).floatValue();

        x = map(x, width * .30, width * .70, 0, width);
        y = map(y, height * .40, height * .60, 0, height);

        // println("x: "+ x + ", y: " + y);
    }
}
