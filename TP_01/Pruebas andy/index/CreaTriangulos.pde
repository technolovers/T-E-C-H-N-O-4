class CreaTriangulos
{
  PGraphics triangulo;

  int w, h;
  float px, py;
  color col;

  CreaTriangulos(int tamAncho_, int tamAlto_, color colorcitos_)
  {
    w = tamAncho_;
    h = tamAlto_;
    px = random(0, width - tamAncho_);
    py = random(0, height - tamAlto_);
    col = colorcitos_;

    triangulo = createGraphics(w, h);
  }

  void dibujar() {
    // float angle = radians(random(0, 360));

    triangulo.beginDraw ();
    triangulo.fill(col);
    triangulo.noStroke();
    triangulo.triangle(random(0, w/2), random(0, h/4), random(w/2 + w/4, w), random(30, h - 30), random(0, w/2), random(h - 50, h));
    triangulo.endDraw();
  }

  void display () {
    image(triangulo, px, py);
  }

  PImage getTriangulo()
  {
    return triangulo;
  }
}