/*
* Falta: cada dos verticales genera si o si uno horizontal 
* (o viceversa) ó genera uno vertical, después uno horizontal, 
* después otro vertical, y así sucesivamente. (función “!” para el if).
*/

class Settings {
    int vWidth;
    int hHeight;
    int tam;
    boolean orientation;
    float aspectRatio = 0.8;

    public Settings () {
        tam = 500;
    }

    public Settings (int tam) {
        this.tam = tam;
    }

    public void setOrientation() {
        surface.setResizable(true);
        orientation = boolean(round(random(0, 1)));

        if (orientation) {
            vWidth = tam;
            hHeight = int(tam * aspectRatio);
        } else {
            vWidth = int(tam * aspectRatio);
            hHeight = tam;
        }

        // println("orientation: "+orientation);

        // println("vWidth: "+vWidth);
        // println("hHeight: "+hHeight);

        surface.setSize(vWidth, hHeight);
        // surface.setResizable(false);
    }
}
