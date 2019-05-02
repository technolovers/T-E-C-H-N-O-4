class Pinceles 
{
  PImage pincel_1;
  PImage pincel_2;
  color colorPincel= RGB;
  float alphaTint=0;

  float tamPincel=40;
  ArrayList <PImage> pinceles= new ArrayList<PImage>();
  int pincelNum=0;

  Pinceles ()
  {
    cargaPincelesPrueba();
    imageMode(CENTER);
  }

  void dibuja()
  {
    //  propiedadesPincel();
    tint(getColorPincel(), getAlphaTint());

    image (pinceles.get(pincelNum), mouseX, mouseY, tamPincel, tamPincel*1.5);
  }
  void cargaPincelesPrueba()
  {
    for (int i =0; i<5; i++)
    {
      setPincel("../../pinceles_IMG/pincelBlanco_"+i+".png");
    }
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
      if (pincelNum>0 && pincelNum<=4 )
      {
        {
          pincelNum--;
        }
      }
    }
    if (key=='t')
    {
      if (pincelNum>=0 && pincelNum<4 )
      {
        pincelNum++;
      }
    }
    println(pincelNum);
  }

  void mouseDragged()

  {
    dibuja();
  }
}//cierra clase Pinceles
