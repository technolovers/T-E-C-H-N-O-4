class CreaTriangulos
{
  PGraphics canvas;
  PImage mask;
  PImage trianguloFill;

  int cantMascaras = 24;

  int w, h;
  float px, py;
  color col;

  CreaTriangulos(color colorcitos_)
  {
    mask = this.getRandomMask();
    mask.resize(0, (int)random(350, height));

    w = mask.width;
    h = mask.height;

    px = random(0, width - w);
    py = random(0, height - h);

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