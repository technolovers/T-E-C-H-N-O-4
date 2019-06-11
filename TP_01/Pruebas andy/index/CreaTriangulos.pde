class CreaTriangulos
{
  PGraphics triangulo;

  int w, h;
  float px, py;
  color col;
  CreaTriangulos(int tamAncho_, int tamAlto_,float _px, float _py, color colorcitos_)
  {
    w = tamAncho_;
    h = tamAlto_;
    px = _px;
    py = _py;
    col = colorcitos_;

    instrucciones();
  }

  void instrucciones()
  {
    float tx = w/10;
    float ty = h/10;
    triangulo = createGraphics(w, h);

    triangulo.beginDraw ();
    triangulo.fill(col);
    triangulo.noStroke();
    //    triangulo.triangle(random(10, 20), random(0, 10), random(25, 90), random(0, 50), random(0, 10), random(200, 290));
    triangulo.triangle(random(tx/2, tx), random(0, ty/2), random(tx+tx/2, tx*4), random(0, ty*2), random(0, tx/2), random(ty*15, ty*19));

    triangulo.endDraw();
  }

  void dibujar () {
    image(triangulo, px, py);
  }

  PImage getTriangulo()
  {
    return triangulo;
  }
}