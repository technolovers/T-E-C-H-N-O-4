class CreaTriangulos
{
  //  PGraphics triangulo;
  PImage triangulo;
  CreaTriangulos(int tamAncho_, int tamAlto_, color colorcitos_)
  {
    instrucciones(tamAncho_, tamAlto_, colorcitos_);
  }

  void instrucciones(int tamAncho_, int tamAlto_, color c)
  {
    PGraphics tri_;
    float tx=tamAncho_/20;
    float ty= tamAlto_/20;
    tri_= createGraphics(tamAncho_, tamAlto_);

    tri_.beginDraw ();
    tri_.fill(c);
    tri_.noStroke();
    //    tri_.triangle(random(10, 20), random(0, 10), random(25, 90), random(0, 50), random(0, 10), random(200, 290));
    tri_.triangle(random(tx/2, tx), random(0, ty/2), random(tx+tx/2, tx*4), random(0, ty*2), random(0, tx/2), random(ty*15, ty*19));

    tri_.endDraw();
    triangulo=tri_;
  }

  PImage getTriangulo()
  {
    return triangulo;
  }
}// cierra clase CreaTringulos
