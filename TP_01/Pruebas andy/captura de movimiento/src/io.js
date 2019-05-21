import io from 'socket.io-client'

let socket

const connect = () => {
    socket = io()

    socket.on('connect', () => {
        console.log('Socket conectado')
    })
}

const sendMessage = (message) => {
    socket.emit('estado', message)
}

module.exports = {
    connect,
    sendMessage
}
