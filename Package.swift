import PackageDescription

let package = Package(
    name: "Pjango-SteamPlugin",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-CURL.git", majorVersion: 3),
        .Package(url: "https://github.com/enums/Pjango.git", majorVersion: 1, minor: 1),
    ]
)
