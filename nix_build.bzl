def nix_build_impl(ctx):
    outputs = [
        ctx.actions.declare_file(path)
            for path in ctx.attr.creates_files
    ]

    paths = [
        output.path for output in outputs
    ]
    nix_build = "nix-build" if ctx.attr.nix_build_path == "" else ctx.attr.nix_build_path
    nix_build_command = "%s %s" % (nix_build, " ".join(ctx.attr.nix_build_args))
    copy_command = " && ".join(["cp -r result/{} {}".format(path, output_path) for path, output_path in zip(ctx.attr.creates_files, paths)])

    ctx.actions.run_shell(
        inputs = [],
        outputs = outputs,
        # command = "/home/k1nkreet/.nix-profile/bin/nix-build -E \"import <nixpkgs> { config = {}; overlays = []; }\" -A zeromq", # && cp -r result/lib/* . && ", # + copy_command,
        command = "%s && %s" % (nix_build_command, copy_command),
        execution_requirements = {
            "no-sandbox": "1",
            "no-cache": "1",
        }
    )
    return [DefaultInfo(files = depset(outputs))]

nix_build = rule(
    implementation = nix_build_impl,
    attrs = {
		"nix_build_path": attr.string(),
		"nix_build_args": attr.string_list(mandatory=True),
        "creates_files": attr.string_list(mandatory=True),
    }
)
