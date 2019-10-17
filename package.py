name = "nuke"

version = "11.3.5"

authors = [
    "Foundry"
]

description = \
    """
    Nuke is a node-based digital compositing and visual effects application first developed by Digital Domain,
    and used for television and film post-production.
    """

requires = [
    "cmake-3+",
    "license_manager"
]

variants = [
    ["platform-linux"]
]

tools = [
    "nuke"
]

build_system = "cmake"

with scope("config") as config:
    config.build_thread_count = "logical_cores"

uuid = "nuke-{version}".format(version=str(version))

def commands():
    env.PATH.prepend("{root}")

    # We setup the license server.
    if "FOUNDRY_LICENSE_SERVER" in env.keys():
        env.foundry_LICENSE.set(str(env.FOUNDRY_LICENSE_SERVER))

    # Helper environment variables.
    env.NUKE_BINARY_PATH.set("{root}")
    env.NUKE_INCLUDE_PATH.set("{root}/include")
    env.NUKE_LIBRARY_PATH.set("{root}")
