import oscP5.*;
OscP5 oscP5;

Fondo fondo;
Settings settings;
// setear modo, modo "mouse" o modo "osc" (borrar en entrega final)
String setMode = "mouse";

// Movimiento de capas
int nroCapa = 0;

// Rasguños
ArrayList <CreaTriangulos> triangulos;
int cantTriangulos = (int)random(7, 13);
int trianguloADibujar = 0;

// Detectar si se esta moviendo
Dir_Y_Vel vel = new Dir_Y_Vel();
boolean seMueve = false;

// x, y, para modo osc o modo mouse
float x = 0, y = 0;

//barcos
ArrayList <Barco> barcos;
int cantBarcos = (int)random(3, 5);
int barcoADibujar = 0;
// Variable para sumar solo de a 1 la variable barcos a dibujar
boolean trigger;

void setup() {
    size(1000, 500);

    oscP5 = new OscP5(this,6969);
    settings = new Settings();
    settings.setOrientation(800);
    fondo = new Fondo();

    triangulos = new ArrayList<CreaTriangulos>();

    for (int i = 0; i < cantTriangulos; i++) {
        CreaTriangulos t = new CreaTriangulos(color(0, 0, 15));
        triangulos.add(t);
        println("Triangulos cargados: "+ i);
    }

    barcos = new ArrayList<Barco>();

    for (int i = 0; i < cantBarcos; i++) {
        Barco a = new Barco();
        barcos.add( a );
    }
}

void draw() {

    fondo.displayBgColor(0);

    if (nroCapa == 0) {
        fondo.mostrarLienzo();

        for (Barco barco : barcos) {
            barco.display();
        }

        for (CreaTriangulos triangulo : triangulos) {
            triangulo.display();
        }
    } else if (nroCapa == 1) {
        fondo.mostrarLienzo();

        for (CreaTriangulos triangulo : triangulos) {
            triangulo.display();
        }

        for (Barco barco : barcos) {
            barco.display();
        }
    } else if (nroCapa == 2) {
        for (CreaTriangulos triangulo : triangulos) {
            triangulo.display();
        }

        fondo.mostrarLienzo();

        for (Barco barco : barcos) {
            barco.display();
        }
    } else if (nroCapa == 3) {
        for (CreaTriangulos triangulo : triangulos) {
            triangulo.display();
        }

        for (Barco barco : barcos) {
            barco.display();
        }

        fondo.mostrarLienzo();
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

        if (barcos.get(barcoADibujar).porcentajePintado >= 96) {
            trigger = true;
            if (trigger) {
                barcoADibujar += 1;
                trigger = false;
            }
        }
    } else if (trianguloADibujar < cantTriangulos) {
        float velocidad = vel.calcularVelocidad(mx, my);

        if (velocidad > 100) {
            seMueve = true;
        } else {
            seMueve = false;
        }

        trigger = true;

        if (trigger && seMueve) {
            triangulos.get(trianguloADibujar).dibujar();
            trianguloADibujar += 1;
            trigger = false;
        }
    } else {
        // Cambia la variable que mueve las capas de 0 al 3
        nroCapa = (int)map(mx, 0, width, 0, 4);
    }
}


void keyPressed () {
    if (key == 'r') {
        println("Reinicio");
        fondo.reiniciar();

        for (Barco barco : barcos) {
            barco.reiniciar();
        }

        for (CreaTriangulos triangulo : triangulos) {
            triangulo.reiniciar();
        }

        trianguloADibujar = 0;

        barcoADibujar = 0;
    }
}