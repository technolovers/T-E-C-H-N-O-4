class Paleta {

  PImage paleta;

  Paleta (String nombre) {
    paleta = loadImage( nombre );
  }

  color darUnColor( float alfa ) {
    int posX = int( random( paleta.width ));
    int posY = int( random( paleta.height ));
    color este = paleta.get( posX, posY ); 
    return color( red(este), green(este), blue(este), alfa );
  }
}
