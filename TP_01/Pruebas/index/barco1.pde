class Barco1 {
    float posX;
    float posY;
    float tam;

    float x1, y1;
    float x2, y2;
    float x3, y3;
    float x4, y4;

    color relleno;

    Barco1 (float posX, float posY, float tam) {
        this.relleno = color(random(0, 255), random(0, 255), random(0, 255), 100);

        this.posX = posX;
        this.posY = posY;
        this.tam = tam;

        x1 = posX - tam;
        y1 = posY - (tam / 1.5);

        x2 = posX + tam;
        y2 = posY - tam;

        x3 = posX + (tam / 2);
        y3 = posY + tam;

        x4 = posX - tam;
        y4 = posY + tam;

        noStroke();
    }

    void dibujar () {
        pushStyle();
        fill(relleno);
        quad(x1, y1, x2, y2, x3, y3, x4, y4);
        popStyle();
    }
}