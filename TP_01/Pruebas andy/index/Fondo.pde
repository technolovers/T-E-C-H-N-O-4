class Fondo {
  ArrayList <PImage> listaTrazos = new ArrayList();
  Pinceles pincel = new Pinceles();
  Dir_Y_Vel vel = new Dir_Y_Vel();
  PGraphics lienzo;
  Paleta paleta;
  Utils utils = new Utils();

  // Variables para pinceladas aleatorias
  float px = 0, py = 0, velocidad = 0;
  Boolean sentido = true, sePinta = false;

  Fondo () {
    paleta = new Paleta( "../img/paleta-01.jpg" );
    lienzo = createGraphics(width, height);

    pincel.setAlphaTint(80);
    pincel.setTam(300);
  }

  public int calcularPorcentajePintado () {
    return utils.calcularPorcentajePintado(this.lienzo);
  }

  public void displayBgColor(color col) {  
    PGraphics bg;
    bg = createGraphics(width, height);

    bg.beginDraw();
    bg.background(col);
    bg.endDraw();

    image(bg, 0, 0);
  }

  public void mostrarLienzo () {
    image(lienzo, 0, 0);
  }

  public void pincelarConMouse (float mx, float my) {
    velocidad = vel.calcularVelocidad(mx, my);

    if (velocidad > 2 && velocidad < 55) {
      sePinta = true;
    } else {
      sePinta = false;
    }

    if (sePinta) {
      lienzo.beginDraw();
      pincel.setColorPincelRGB(paleta.darUnColor(255));
      pincel.pintar(lienzo, mx, my);
      lienzo.endDraw();
    }
  }

  void reiniciar () {
    lienzo.clear();
  }
}