_shader_file_extensions = [
    '.vert',
    '.frag',
    '.tesc',
    '.tese',
    '.geom',
    '.comp',
    '.glsl',
    '.spvasm',
    '.h',
]

_shader_stages = [
    'vertex',
    'fragment',
    'tesscontrol',
    'tesseval',
    'geometry',
    'compute',
]

def _gather_incdirs(files):
    # Use a dict to avoid duplicates (sets are not allowed in Starlark)
    incdirs_dict = {}
    for f in files:
        path = f.path
        if "/" in path:
            parent_dir = path.rsplit("/", 1)[0]
            incdirs_dict[parent_dir] = True
    incdirs_list = []
    for d in sorted(incdirs_dict.keys()):
        incdirs_list.append("-I" + d)
    return incdirs_list

def _shader_binary(ctx):
    spvOut = ctx.actions.declare_file(ctx.attr.name + ".spv")

    all_inputs = list(ctx.files.srcs)
    incArgs = _gather_incdirs(all_inputs)

    glslcArgs = []

    if ctx.attr.stage:
        glslcArgs.append("-shader-stage=" + ctx.attr.stage)

    # Add include paths and user options
    glslcArgs += incArgs
    glslcArgs += ctx.attr.opts

    # Add sources (excluding headers)
    compile_inputs = []
    for f in all_inputs:
        if not f.path.endswith(".h"):
            glslcArgs.append(f.path)
            compile_inputs.append(f)

    glslcArgs.append('-o')
    glslcArgs.append(spvOut.path)

    ctx.actions.run(
        inputs = all_inputs,
        outputs = [spvOut],
        executable = ctx.executable.glslc,
        arguments = glslcArgs,
    )

    return DefaultInfo(
        files = depset([spvOut]),
        runfiles = ctx.runfiles(files = [spvOut]),
    )

shader_binary = rule(
    implementation = _shader_binary,
    attrs = {
        "srcs": attr.label_list(
            mandatory = True,
            allow_files = _shader_file_extensions,
        ),
        "stage": attr.string(
            default = '',
            values = [''] + _shader_stages,
        ),
        "opts": attr.string_list(default = []),
        "glslc": attr.label(
            default = Label("@vulkan_sdk//:glslc"),
            allow_single_file = True,
            executable = True,
            cfg = "host",
        ),
    },
)
