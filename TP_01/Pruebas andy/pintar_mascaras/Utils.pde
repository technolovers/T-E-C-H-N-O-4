public class Utils {

    // Variables para calcular porcentaje pintado
    int pintados, porcentajePintado;

    public Utils () {
        
    }

    public int calcularPorcentajePintado (PGraphics pg) {
        // Resetear cantidad de pixeles pintados antes de volver a ejecutar el ciclo.
        pintados = 0;

        pg.beginDraw();
        pg.loadPixels();
        int totalPixeles = pg.pixels.length;
        for (int i = 0; i < totalPixeles; ++i) {
            if (pg.pixels[i] != 0) {
                pintados += 1;
            }

            porcentajePintado = (pintados * 100) / totalPixeles;
        }
        pg.updatePixels();
        pg.endDraw();

        return porcentajePintado;
    }
}
