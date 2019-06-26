class CreaTriangulos
{
  PGraphics canvas;
  PImage mask;
  PImage trianguloFill;

  int cantMascaras = 6;

  int w, h;
  float px, py;
  color col;

  CreaTriangulos(color colorcitos_)
  {
    mask = this.getRandomMask();
    mask.resize((int)random(20, 50), (int)random(350, height));

    w = mask.width;
    h = mask.height;

    // Rango de variacion de posicion con respecto a la mitad de la pantalla
    int range = 100;
    px = random(width/2 - range, width/2 + range);
    py = random(height/2 - range, height/2 + range);

    col = colorcitos_;

    trianguloFill = createImage( w, h, ARGB );
    trianguloFill.filter( INVERT );
    trianguloFill.mask(mask);

    canvas = createGraphics(width, height);
  }

  public void dibujar() {

    canvas.beginDraw ();
    canvas.imageMode(CENTER);
    canvas.tint(col);
    canvas.image(trianguloFill, px, px);
    canvas.endDraw();
  }

  public void display () {
    image(canvas, 0, 0);
  }

  public void reiniciar () {
    canvas.beginDraw();
    canvas.clear();
    canvas.endDraw();
  }

  private PImage getRandomMask () {
    int numMascara = (int)random(1, cantMascaras);
    PImage mascaraRandom = loadImage("./../img/Triangulos/tn" + numMascara + ".png");
    return mascaraRandom;
  }
}