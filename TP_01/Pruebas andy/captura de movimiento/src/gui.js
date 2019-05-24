import dat from 'dat.gui'

export const guiState = {
    rangoDeteccionBrazosBajos: 60,
    porcentajeDeteccionDeAleteo: 50
}

export const displayGui = () => {
    let gui = new dat.GUI()

    gui.add(guiState, 'rangoDeteccionBrazosBajos', 0, 150)
    gui.add(guiState, 'porcentajeDeteccionDeAleteo', 0, 100)
}