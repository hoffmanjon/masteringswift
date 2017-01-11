import Foundation
import Glibc
import Socket

class EchoServer {

    let bufferSize = 1024
    let port: Int
    var listenSocket: Socket? = nil
    var connected = [Int32: Socket]()
    var acceptNewConnection = true

    init(port: Int) {
        self.port = port
    }

    deinit {
        for socket in connected.values {
            socket.close()
        }
        listenSocket?.close()
    }

    func start() throws {
        //Using the following create class method:
        //public class func create(family: ProtocolFamily = .inet, type: SocketType = .stream, proto: SocketProtocol = .tcp) throws -> Socket 
        let socket = try Socket.create() 

        listenSocket = socket
        try socket.listen(on: port)
        print("Listening port: \(socket.listeningPort)")
        repeat {
            let connectedSocket = try socket.acceptClientConnection()
            print("Connection from: \(connectedSocket.remoteHostname)")
            newConnection(socket: connectedSocket)
        } while acceptNewConnection      
    }

    func newConnection(socket: Socket) {
        connected[socket.socketfd] = socket

        var cont = true
        var dataRead = Data(capacity: bufferSize)
        repeat {
            do {
                let bytes = try socket.read(into: &dataRead)
                if bytes > 0 {
                    if let readStr = String(data: dataRead, encoding: .utf8) {
                        print("Received: \(readStr)")
                        try socket.write(from: readStr)
                        if readStr.hasPrefix("quit") {
                            cont = false
                            socket.close()
                        }
                        dataRead.count = 0
                    }
                }
            } catch let error {
                print("error: \(error)")
            }
        } while cont
        connected.removeValue(forKey: socket.socketfd)
        socket.close()
    }
}

