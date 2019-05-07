class Pinceles 
{
  color colorPincel= RGB;
  float alphaTint=0;

  float tamPincel=60;
  ArrayList <PImage> pinceles= new ArrayList<PImage>();
  int cantPinceles=6;

  int pincelNum=0;

  float posX=0, posY=0, angulo;
  Pinceles ()
  {
    cargaPincelesPrueba();
    imageMode(CENTER);
  }

  void dibuja()
  {
    //  propiedadesPincel();

    pushMatrix();
    //   rotate(angulo);
    tint(getColorPincel(), getAlphaTint());

    image (pinceles.get(pincelNum), getPosicion()[0], getPosicion()[1], tamPincel*cos(angulo), tamPincel*sin(angulo));
    popMatrix();
  }
  void cargaPincelesPrueba()
  {
    for (int i =0; i<cantPinceles; i++)
    {
      setPincel("../../pinceles_IMG/pincelBlanco_"+i+".png");
    }
  }


  void cualAngulo()
  {
    angulo= atan2(getPosicion()[1]-(pmouseY+2), getPosicion()[0]-(pmouseX+2));
    println(degrees(angulo));
    // return angulo;
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
      tamPincel+=2;      
      break;
    case "disminulle":
      tamPincel-=2;
      break;
    default:
      break;
    }
  }

  void setColorPincelRGB(float rojo_, float verde_, float azul_)
  {
    colorPincel= color(rojo_, verde_, azul_);
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
      if (pincelNum>=0 && pincelNum<getCantPinceles()-1)
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
