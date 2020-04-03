group "default" {
	targets = ["printer-amd64", "printer-arm"]
}

target "printer" {
	dockerfile = "Dockerfile"
    args {
        CLIENT_VERSION = "6.2.3.163_stable"
    }
}

target "printer-amd64" {
	inherits = ["printer"]
	tags = ["cryowatt/3dprinteros:6.2.3.163_stable"]
	platforms = ["linux/amd64"]
}

target "printer-arm" {
	inherits = ["printer"]
	tags = ["cryowatt/3dprinteros:6.2.3.163_stable-arm64"]
	platforms = ["linux/arm64"]
}