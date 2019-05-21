class Pinceles 
{
  PImage pincel_1;
  PImage pincel_2;
  color colorPincel= RGB;
  float alphaTint=0;
  float miDireccionPolar;

  int tamPincel = int((width + height) * .8);
  ArrayList <PImage> pinceles= new ArrayList<PImage>();
  int cantPinceles=6;

  int pincelNum=0;

  float posX=0, posY=0, prevPosX, prevPosY, ang;

  Pinceles ()
  {
    cargaPincelesPrueba();
  }

  public void pintar(PGraphics pg, float mx, float my)
  {
    prevPosX = posX;
    prevPosY = posY;
    posX = mx;
    posY = my;

    int w = tamPincel;
    int h = int(tamPincel*1.5);
    // float brushAngle = atan2(my - prevPosY, mx - prevPosX) + + radians(90);

    pg.tint(getColorPincel(), getAlphaTint());
    pg.translate(posX, posY);
    // pg.rotate(brushAngle);
    pg.image(pinceles.get(pincelNum), 0, 0, w, h);
  }

  void cargaPincelesPrueba()
  {
    for (int i =0; i<cantPinceles; i++)
    {
      setPincel("../img/pinceles_IMG/pincelBlanco_"+i+".png");
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

   int getTam()
  {
    return this.tamPincel;
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
}//cierra clase Pinceles
