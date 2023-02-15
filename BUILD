load("//:nix_build.bzl", "nix_build")

nix_build(
    name = "zmq-lib",
    nix_build_args = [
        "-E",
        "\"import <nixpkgs> { config = {}; overlays = []; }\"",
        "-A",
        "zeromq",
    ],
    creates_files = [
        "lib/libzmq.so",
        "lib/libzmq.so.5",
        "lib/libzmq.so.5.2.4",
    ],
)

nix_build(
    name = "zmq-headers",
    nix_build_args = [
        "-E",
        "\"import <nixpkgs> { config = {}; overlays = []; }\"",
        "-A",
        "zeromq",
    ],
    creates_files = [
        "include/zmq.h",
		"include/zmq_utils.h",
    ],
)

cc_library(
    name = "zmq",
    srcs = [
        ":zmq-lib",
    ],
    hdrs = [
        ":zmq-headers",
    ],
    include_prefix = "include",
)

cc_binary(
    name = "example",
    srcs = ["zmq_example.c"],
    deps = [":zmq"],
)
