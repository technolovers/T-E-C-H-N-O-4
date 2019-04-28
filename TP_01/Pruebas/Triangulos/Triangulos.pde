int cantT= 10;
ArrayList <PImage> esquirla= new ArrayList <PImage>(cantT);
CreaTriangulos [] t= new CreaTriangulos[cantT];

void setup ()

{
  size (400, 400);
  background (200);
  smooth();


  for (int i =0; i< cantT; i++)
  {
    t[i]= new CreaTriangulos(100, 300, color(100, 0, 100, 100));

    esquirla.add(t[i].getTriangulo());
  }
  for (int i =0; i< cantT; i++)
  {
    image(esquirla.get(i), random(width), random(height/2));
  }
}

void draw ()
{
}
