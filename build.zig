const std = @import("std");

// TODO: support homebrew targets
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const SampleCore = struct {
        name: []const u8,
        path: []const u8,
        desc: []const u8,
        single_threaded: bool = true,
    };

    // TODO: https://github.com/ziglang/zig/issues/2231
    // TODO: add more samples. webgpu dawn example, small libretro frontend...
    // TODO: add my demo frontend here
    const sample_cores = [_]SampleCore{
        .{
            .name = "basic",
            .path = "samples/cores/basic.zig",
            .desc = "A libretro v1 core skeleton",
        },
        .{
            .name = "basic-cairo",
            .path = "samples/cores/basic-cairo.zig",
            .desc = "Showcasing software rendering with the Cairo 2D graphics library",
        },
        // TODO: disabled until dependency works with latest zig
        //.{
        //    .name = "viewer",
        //    .path = "samples/cores/viewer.zig",
        //    .desc = "A simple image viewer using zigimg",
        //},
        .{
            .name = "bytepusher",
            .path = "samples/cores/bytepusher.zig",
            .desc = "A BytePusher VM",
        },
        .{
            .name = "basic-gl",
            .path = "samples/cores/gl/basic.zig",
            .desc = "A simple OpenGL triangle demo",
        },
        .{
            .name = "basic-vulkan",
            .path = "samples/cores/vulkan/basic.zig",
            .desc = "A spinny Vulkan triangle ported from libretro-samples",
        },
    };

    inline for (sample_cores) |core| {
        const lib = b.addSharedLibrary(.{
            .name = core.name ++ "_libretro",
            .root_source_file = .{ .path = core.path },
            .target = target,
            .optimize = optimize,
            .single_threaded = core.single_threaded,
        });

        // TODO: disabled until dependency works with latest zig
        //const img = b.dependency("zigimg", .{
        //    .target = target,
        //    .optimize = optimize,
        //});
        //lib.root_module.addImport("zigimg", img.module("zigimg"));

        const gl_bindings = @import("zigglgen").generateBindingsModule(b, .{
            .api = .gl,
            .version = .@"4.1",
            .profile = .compatibility,
        });
        lib.root_module.addImport("gl", gl_bindings);

        lib.root_module.addImport("vulkan", b.dependency(
            "vulkan_zig",
            // TODO: don't hardcode this path
            .{ .registry = @as([]const u8, "/usr/share/vulkan/registry/vk.xml") },
        ).module("vulkan-zig"));

        const ShaderCompileStep = @import("vulkan_zig").ShaderCompileStep;
        const shaders = ShaderCompileStep.create(b, &.{ "glslc", "--target-env=vulkan1.3", "-Os" }, "-o");
        shaders.add("vert", "samples/cores/vulkan/shaders/triangle.vert", .{});
        shaders.add("frag", "samples/cores/vulkan/shaders/triangle.frag", .{});
        lib.root_module.addImport("shaders", shaders.getModule());

        // TODO: don't prefix artifact name with lib on linux, and turn dashes into underscores
        const retro_mod = b.addModule("retro", .{ .root_source_file = .{ .path = "retro.zig" } });
        lib.root_module.addImport("retro", retro_mod);
        lib.rdynamic = true;
        if (!lib.rootModuleTarget().isWasm()) lib.linkLibC();
        if (std.mem.eql(u8, core.name, "basic-cairo")) {
            lib.linkSystemLibrary("cairo");
            lib.addIncludePath(.{ .path = "/usr/include/cairo" });
        }
        b.installArtifact(lib);
        // TODO: what extension to use?
        //const lib_install = b.addInstallFileWithDir(lib.getEmittedBin(), .lib, core.name ++ "_libretro.so");
        //lib_install.step.dependOn(&lib.step);
        //b.getInstallStep().dependOn(&lib_install.step);

        std.log.info("Building sample core: {s}", .{core.name});

        //const run_step = b.step("run-" ++ core.name, core.desc ++ " (Run in RetroArch)";
        //run_step.dependOn(&lib.step);
    }
}
