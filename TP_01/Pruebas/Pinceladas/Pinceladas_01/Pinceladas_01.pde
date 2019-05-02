Pinceles [] p= new Pinceles [2];


void setup ()
{
  for (int i=0; i< p.length; i++)
  {
    p[i]= new Pinceles ();
  }

  size(600, 600);  
  noCursor();
  background(200);
}


void draw ()

{
  for (int i=0; i< p.length; i++)
  {
    p[i].setColorPincelRGBA(200, 100, random(.0, .200), 255);
    p[i].setAlphaTint(20);
  }
}

void keyPressed()
{  
  for (int i=0; i< p.length; i++)
  {
    p[i].keyPressed();
  }
}

void mouseDragged()

{  
  if (mouseY<height/2 && mouseY> height/4)
  {
  for (int i=0; i< p.length; i++)
  {
    p[i].mouseDragged();
    p[i].setPosicion(mouseX+i*100, mouseY);
  }
    }
}