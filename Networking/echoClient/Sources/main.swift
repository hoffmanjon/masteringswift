import Foundation
import Glibc

var echoClient = EchoClient(port: 3333, server: "127.0.0.1")
echoClient.start()
