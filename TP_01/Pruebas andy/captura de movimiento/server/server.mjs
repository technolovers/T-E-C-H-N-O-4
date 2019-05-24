import express from 'express'
import path from 'path'
import socket from 'socket.io'
import vars from './vars'
import osc from './osc'


const app = express()
const port = process.env.PORT || 3000
const publicPath = path.join(vars.__dirname, '/../public')
const index = publicPath + '/index.html'


app.use(express.static(publicPath));
app.set('port', port)

// Inicializacion de servidor
const server = app.listen(app.get('port'), () => {
  console.log('Servidor escuchando http://localhost:%d', app.get('port'))
})
const io = socket.listen(server)

io.on('connection', socket => {
  console.log('Usuario conectado')
  // Cuando se establece una conexion, se setea puerto y host para enviar y recibir por osc
  osc.setConfig()

  socket.on('estado', obj => {
    osc.sendMessage(obj)
  })
  
  socket.on('disconnect', () => {
    console.log('Usuario desconectado')
    osc.disconnect()
  })
})

app.get('/', function (req, res) {
  res.sendFile(index)
});
