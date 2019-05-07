class Pinceles 
{
  PImage pincel_1;
  PImage pincel_2;
  color colorPincel= RGB;
  float alphaTint=0;

  int tamPincel=40;
  ArrayList <PImage> pinceles= new ArrayList<PImage>();
  int cantPinceles=6;

  int pincelNum=0;

  float posX=0, posY=0;
  Pinceles ()
  {
    cargaPincelesPrueba();
  }

  PGraphics dibuja()
  {
    PGraphics pg;
    pg = createGraphics(tamPincel, int(tamPincel*1.5));

    pg.beginDraw();
    pg.tint(getColorPincel(), getAlphaTint());
    pg.image(pinceles.get(pincelNum), getPosicion()[0], getPosicion()[1], tamPincel, tamPincel*1.5);
    pg.endDraw();

    return pg;
  }
  void cargaPincelesPrueba()
  {
    for (int i =0; i<cantPinceles; i++)
    {
      setPincel("./data/img/pinceles_IMG/pincelBlanco_"+i+".png");
    }
  }

  void setPosicion(float posX_, float posY_)
  {
    posX= posX_;
    posY=posY_;
  }
  void setPincel(String rutaImagen_)
  {
    PImage nuevoPincel= loadImage(rutaImagen_);
    pinceles.add(nuevoPincel);
  }

  void setTamPincel(String tamPincel_)
  {

    switch (tamPincel_) {
    case "aumenta":
      tamPincel++;      
      break;
    case "disminulle":
      tamPincel--;
      break;
    default:
      break;
    }
  }

  void setTam(int tamPincel_)
  {
    this.tamPincel = tamPincel_;
  }

  void setColorPincelRGB(color col)
  {
    colorPincel= color(col);
  }

  void setColorPincelRGBA(float rojo_, float verde_, float azul_, float alpha_)
  {
    colorPincel= color(rojo_, verde_, azul_, alpha_);
  }
  void setAlphaTint(float alphaTint_)
  {
    alphaTint=alphaTint_;
  }

  int getCantPinceles()
  {
    return pinceles.size();
  }

  color getColorPincel()
  {    
    return colorPincel;
  }

  float getAlphaTint()
  {
    return alphaTint;
  }
  float [] getPosicion()
  {
    float []arreglo = new float[2];
    arreglo[0]= posX;
    arreglo[1]=posY;
    return   arreglo;
  }


  void keyPressed()
  {
    //tamaño del pincel
    if (key=='q')
    {
      setTamPincel("disminulle");
    }
    if (key=='w')
    {
      setTamPincel("aumenta");
    }  
    // cambia Pincel
    if (key=='r')
    {
      if (pincelNum>0 && pincelNum<=getCantPinceles())
      {
        {
          pincelNum--;
        }
      }
    }
    if (key=='t')
    {
      if (pincelNum>=0 && pincelNum<=getCantPinceles())
      {
        pincelNum++;
      }
    }
    println("tamArreglo"+pinceles.size()+"___"+pincelNum);
  }

  void mouseDragged()

  {
    dibuja();
  }
}//cierra clase Pinceles
