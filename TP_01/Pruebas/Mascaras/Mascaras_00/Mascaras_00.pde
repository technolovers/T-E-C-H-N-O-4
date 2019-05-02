PImage mascara;
PImage maskCopy;
color c;
int mappy, mappyAlpha, mappyTam;

void setup()
{
  size (600, 600);

  mascara= loadImage("../../pinceles_IMG/mascaritaPrueba_01.jpg");
  background(200);
  //  maskCopy= createImage(813, 1588, GRAY);
  loadPixels();

  //  for (int j=0; j< mascara.pixels.length; j++)
  //  {  
  //    if (j<maskCopy.pixels.length)
  //    { 
  //      maskCopy.pixels[j] =mascara.pixels[j];
  //    }
  //  }
  //  image(mascara, 0, 0);
  noStroke();
}

void draw ()
{
  c=mascara.get(mouseX, mouseY);
  mappy=int(map(abs(c), 0, pow(256, 3), 0, 5));
  mappyAlpha=int(map(abs(c), 0, pow(256, 3), 0, 100));
  mappyTam=int(map(abs(c), 0, pow(256, 3), 50, 1));

  println(mappy);
  fill(c);
  rect(width-100, height-100, 50, 80);
}

void mouseDragged()
{
  if (mappy!=0) {
    fill(255, 0, 0, mappyAlpha);
    ellipse(mouseX, mouseY, mappyTam, mappyTam);
    ellipse(pmouseX, pmouseY, mappyTam/2, mappyTam/2);
  }
}
