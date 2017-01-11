import Foundation
#if os(Linux)
    import Glibc
    import Ifaddrs
#else 
    import Darwin
#endif

struct InterfaceInformation {
    var name: String
    var address: String
}

func getIpAddrs() -> [InterfaceInformation]? {
    var interfaces = [InterfaceInformation]()

    var ifaddr: UnsafeMutablePointer<ifaddrs>?

    guard getifaddrs(&ifaddr) == 0 else { return nil }
    guard let firstAddr = ifaddr else { return nil }

    for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
        let interface = ifptr.pointee

        let addrFamily = interface.ifa_addr.pointee.sa_family
        var host = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        var addr = interface.ifa_addr.pointee
         if addrFamily == UInt16(AF_INET) {  
             getnameinfo(&addr, socklen_t(MemoryLayout<sockaddr_in>.size), &host, socklen_t(NI_MAXHOST), nil, socklen_t(0), NI_NUMERICHOST)
        } 

        let nameStr = String(cString: interface.ifa_name)
        let tAddrStr = String(cString: host)

        var addrStr = tAddrStr
        if let idx = tAddrStr.characters.index(of: "%") {
            addrStr = tAddrStr.substring(to: idx)
        }
        let interfaceInfo = InterfaceInformation(name: nameStr, address: addrStr)
        interfaces.append(interfaceInfo) 
    }
    free(ifaddr)
    return interfaces
}

if let interfaces = getIpAddrs() {
    for interface in interfaces {
        print("\(interface.name) - \(interface.address)")
    }
}
