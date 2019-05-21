import osc from 'node-osc'
import { oscConfig } from './config'
let oscServer, oscClient

const setConfig = () => {
    oscServer = new osc.Server(oscConfig.server.port, oscConfig.server.host)
    oscClient = new osc.Client(oscConfig.client.host, oscConfig.client.port)
}

const disconnect = () => {
    oscServer.close()
}

const sendMessage = obj => {
    oscClient.send('/test', obj)
    console.log('sent WS message to OSC', obj)
}

const eventListener = event => {
    oscServer.on(event, (msg, rinfo) => {
        socket.emit(event, msg)
        console.log('sent OSC message to WS', msg, rinfo)
    })
}

export default {
    setConfig,
    sendMessage,
    disconnect
}