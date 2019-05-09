Pinceles [] p= new Pinceles [1];


void setup ()
{
  /*  for (int i=0; i< p.length; i++)
   {
   p[i]= new Pinceles ();
   }*/

  p[0]= new Pinceles("../../pinceles_IMG/pincelBlanco_6.png", 10, 200);

  size(600, 600);  
  //  noCursor();
  p[0].setPosicion(-100, -100);
  noStroke();
  background(200);
}


void draw ()

{
  fill(200, 10);
  rect(0, 0, width, height);
  for (int i=0; i< p.length; i++)
  {
    p[i].setColorPincelRGBA(200, 100, random(.0, .200), 255);
    p[i].setAlphaTint(80);
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
  for (int i=0; i< p.length; i++)
  {

    p[i].mouseDragged();
    p[i].setPosicion(mouseX+(i*5), mouseY);
    p[i].cualAngulo();
  }
}
