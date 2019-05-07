class Fondo {
  ArrayList <PImage> listaTrazos;
  Pinceles pincel = new Pinceles();
  PGraphics lienzo;
  Paleta paleta;

  Fondo () {
    listaTrazos = new ArrayList();
    paleta = new Paleta( "./data/img/paleta-01.jpg" );
    lienzo = createGraphics(width, height);
    println("width: "+width);

    pincel.setAlphaTint(80);
  }

  public void displayBgColor(color col) {  
    PGraphics bg;
    bg = createGraphics(width, height);

    bg.beginDraw();
    bg.background(col);
    bg.endDraw();

    image(bg, 0, 0);
  }

  public void pintarConMouse(float mx, float my) {
    if (mousePressed) {
      lienzo.beginDraw();
      pincel.setColorPincelRGB(paleta.darUnColor(255));
      pincel.setTam(150);
      lienzo.imageMode(CENTER);
      lienzo.image(pincel.dibuja(), mx, my);
      lienzo.endDraw();
    }

    image(lienzo, 0, 0);
  }
}