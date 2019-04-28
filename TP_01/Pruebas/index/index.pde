
Settings settings;
Fondo fondo;
ArrayList <Barco> barcos;

int cantBarcos;
int barcosADibujar;

void setup() {
    size(1000, 500);

    settings = new Settings(600);
    settings.setOrientation();
    
    fondo = new Fondo();

    // barcos = new Barco[cantBarcos];
    barcos = new ArrayList<Barco>();
    cantBarcos = 4;

    for (int i = 0; i < cantBarcos; i++) {
        if (i == 0) {
            Barco a = new Barco();
            barcos.add( a );
        }

        Barco b = new Barco(barcos.get(i));
        barcos.add( b );
    }
}

void draw() {
    background(0);
    fondo.display();

    barcosADibujar = round(map(mouseX, 0, width, 0, cantBarcos ));

    for (int i = 0; i < barcosADibujar; i++) {
        int h = 400 - (i * 20);

        barcos.get(i).display(0, height - h , 200 + (i * 90), h);
    }
}
