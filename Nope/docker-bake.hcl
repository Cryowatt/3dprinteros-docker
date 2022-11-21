group "default" {
	targets = ["stable", /*"development", "beta"*/]
}

target "3dprinteros" {
	dockerfile = "Dockerfile"
}

target "beta" {
    inherit = "3dprinteros"
	platforms = ["linux/amd64", "linux/arm/v7"]
    target = "python3"
    args {
        CLIENT_VERSION = "7.2.6.215_beta"
    }
	tags = ["cryowatt/3dprinteros:7.2.6.215", "cryowatt/3dprinteros:beta"]
    output =["type=image,push=true"]
}

target "development" {
    inherit = "3dprinteros"
	platforms = ["linux/amd64", "linux/arm/v7"]
    target = "python2"
    args {
        CLIENT_VERSION = "6.2.4.166_dev"
    }
	tags = ["cryowatt/3dprinteros:6.2.4.166", "cryowatt/3dprinteros:development"]
    output =["type=image,push=true"]
}

target "stable" {
    inherit = "3dprinteros"
	platforms = ["linux/amd64", "linux/arm/v7"]
    target = "python2"
    args {
        CLIENT_VERSION = "6.2.3.163_stable"
    }
	tags = ["cryowatt/3dprinteros:6.2.3.163", "cryowatt/3dprinteros:stable"]
    output =["type=image,push=true"]
}
