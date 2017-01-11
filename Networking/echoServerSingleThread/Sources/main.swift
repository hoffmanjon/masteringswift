import Foundation
import Glibc


print("Hello")


let server = EchoServer(port: 3333)
do {
    try server.start()
} catch let error {
    print("Error: \(error)")
}