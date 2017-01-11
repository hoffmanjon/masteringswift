import Foundation
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

let number: UInt32 = 0x12345678
let converted = number.bigEndian
if number == converted {
    print("Big1")
} else {
    print("Little1 \(converted)")
}
