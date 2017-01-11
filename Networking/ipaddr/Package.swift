import PackageDescription

let package = Package(
    name: "ipaddr",
    dependencies: [
	    .Package(url: "../Modules/ifaddrs", majorVersion: 0, minor: 1)
    ]
)
