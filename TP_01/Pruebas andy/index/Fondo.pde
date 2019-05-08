class Fondo {
  ArrayList <PImage> listaTrazos = new ArrayList();
  Pinceles pincel = new Pinceles();
  Dir_Y_Vel vel = new Dir_Y_Vel();
  PGraphics lienzo;
  Paleta paleta;

  // Variables para pinceladas aleatorias
  float px = 0, py = 0, velocidad = 0;
  Boolean sentido = true, sePinta = false;

  // Variables para calcular porcentaje pintado
  int pintados, porcentajePintado;

  Fondo () {
    paleta = new Paleta( "./data/img/paleta-01.jpg" );
    lienzo = createGraphics(width, height);

    pincel.setAlphaTint(80);
    pincel.setTam(150);
  }

  public float calcularPorcentajePintado () {
    // Resetear cantidad de pixeles pintados antes de volver a ejecutar el ciclo.
    pintados = 0;

    lienzo.beginDraw();
    lienzo.loadPixels();
    int totalPixeles = lienzo.pixels.length;
    for (int i = 0; i < totalPixeles; ++i) {
      if (lienzo.pixels[i] != 0) {
        pintados += 1;
      }

      porcentajePintado = (pintados * 100) / totalPixeles;
    }
    lienzo.updatePixels();
    lienzo.endDraw();

    println("Porcentaje pintado: " + porcentajePintado);
    return porcentajePintado;
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

  public void pincelarRandom (float mx, float my) {
    velocidad = vel.calcularVelocidad(mx, my);

    if (velocidad > 8 && velocidad < 55) {
      sePinta = true;
    } else {
      sePinta = false;
    }

    if (sePinta) {
      // if (px <= width - random(25, 80)) {
      //   px += 8;
      //   py += random(.5, 1.7);
      // } else {
      //   sePinta = false;
      // }
      lienzo.beginDraw();
      lienzo.imageMode(CENTER);
      pincel.setColorPincelRGB(paleta.darUnColor(255));
      pincel.pintar(lienzo, mx, my);
      lienzo.endDraw();
    }
  }

  public void pincelarConMouse (float mx, float my) {
    velocidad = vel.calcularVelocidad(mx, my);

    if (velocidad > 3 && velocidad < 55) {
      sePinta = true;
    } else {
      sePinta = false;
    }

    if (sePinta) {
      lienzo.beginDraw();
      lienzo.imageMode(CENTER);
      pincel.setColorPincelRGB(paleta.darUnColor(255));
      pincel.pintar(lienzo, mx, my);
      lienzo.endDraw();
    }
  }
}