import oscP5.*;
OscP5 oscP5;

Fondo fondo;
Settings settings;
// setear modo, modo "mouse" o modo "osc" (borrar en entrega final)
String setMode = "mouse";

CreaTriangulos triangulo;

// x, y, para modo osc o modo mouse
float x = 0, y = 0;

//barcos
ArrayList <Barco> barcos;
int cantBarcos = 4;
int barcoADibujar = 0;
// Variable para sumar solo de a 1 la variable barcos a dibujar
boolean trigger;

void setup() {
    size(1000, 500);

    oscP5 = new OscP5(this,6969);
    settings = new Settings();
    settings.setOrientation(800);
    fondo = new Fondo();
    triangulo = new CreaTriangulos(150, 400, random(width), random(height), color(255, 120));

    barcos = new ArrayList<Barco>();

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
        interactuar(mouseX, mouseY);
    } else if (setMode.equals("osc")) {
        interactuar(x, y);
    }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
    /* print the address pattern and the typetag of the received OscMessage */
    if (theOscMessage.checkAddrPattern("/test")==true){
        x = theOscMessage.get(0).floatValue();
        y = theOscMessage.get(1).floatValue();

        x = map(x, 0, 1, 0, width);
        y = map(y, 0, 1, 0, height);

    }
}

void interactuar (float mx, float my) {
    // Estado 1, pintar fondo
    if (fondo.calcularPorcentajePintado() <= 90) {
        fondo.pincelarConMouse(mx, my);
    // Estado 2, pintar barcos
    } else if (barcoADibujar < cantBarcos) {
        // Suma barcos hasta que se iguale a la variable que controla la cantidad de barcos en total
        barcos.get(barcoADibujar).pincelar(mx, my);

        if (barcos.get(barcoADibujar).porcentajePintado >= 98) {
            trigger = true;
            if (trigger) {
                barcoADibujar += 1;
                trigger = false;
            }
        }
    } else {
        triangulo.dibujar();
    }
}
