ArrayList <Barco> barcos;

int cantBarcos;
int barcosADibujar;

void setup() {
    size(1000, 500);

    barcos = new ArrayList<Barco>();
    cantBarcos = 4;
    barcosADibujar = 1;

    for (int i = 0; i < cantBarcos; i++) {
        Barco a = new Barco();
        barcos.add( a );
    }
}

void draw() {
    background(0);

    for (int i = 0; i < barcosADibujar; i++) {
        barcos.get(i).pincelar(mouseX, mouseY);
        barcos.get(i).display();
    }
}
