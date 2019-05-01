Pinceles p;
;

void setup ()
{  
  p= new Pinceles ();

  size(600, 600);  
  noCursor();
  background(200);
}


void draw ()

{

  p.setColorPincelRGBA(200, 100, random(.0, .200), 255);
  p.setAlphaTint(255);
}

void keyPressed()
{
  p.keyPressed();
}

void mouseDragged()

{
  p.mouseDragged();
}
