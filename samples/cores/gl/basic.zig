const std = @import("std");
const retro = @import("retro");
const gl = @import("gl");

pub usingnamespace retro.ExportedCore(@This());

pub const system_info: retro.SystemInfo = .{
    .library_name = "Triangle Demo (OpenGL)",
    .library_version = "0.1.0",
};

var hw_render = retro.env.hw.RenderCallback{
    .context_type = .opengl,
    .contextReset = contextReset,
    .contextDestroy = contextDestroy,
    .getCurrentFramebuffer = undefined, // to be set by frontend
    .getProcAddress = undefined, // to be set by frontend
    .bottom_left_origin = true,
};
var procs: gl.ProcTable = undefined;

fn contextReset() callconv(.C) void {
    _ = procs.init(hw_render.getProcAddress);
    gl.makeProcTableCurrent(&procs);
}

fn contextDestroy() callconv(.C) void {
    gl.makeProcTableCurrent(null);
}

top_point_x: f32 = 0,
top_point_y: f32 = 0.5,

bg_color: [4]f32 = cornflower_blue,

// TODO: simplify core options?

const cornflower_blue = [4]f32{ 0.392, 0.584, 0.929, 0 };
const magenta = [4]f32{ 1, 0, 1, 0 };
const yellow = [4]f32{ 1, 1, 0, 0 };

const width = 640;
const height = 480;

pub fn setEnvironment() void {
    retro.env.log.init();
    _ = retro.env.setSupportNoGame(true);

    _ = retro.env.setVariables(@ptrCast(&[_]retro.env.Variable{ .{
        .key = "basicgl_bg_color",
        .value = "Background color; Cornflower Blue|Magenta|Yellow",
    }, .{} }));
}

pub fn getSystemAvInfo(_: *@This()) retro.SystemAvInfo {
    return .{
        .geometry = .{
            .base_width = width,
            .base_height = height,
            .max_width = width,
            .max_height = height,
        },
        .timing = .{ .fps = 60, .sample_rate = 0 },
    };
}

pub fn reset(core: *@This()) void {
    core.top_point_x = 0;
    core.top_point_y = 0.5;
}

pub fn run(core: *@This()) void {
    retro.input.poll();

    const speed = 0.025;

    if (retro.input.joy.held(0, .up)) core.top_point_y += speed;
    if (retro.input.joy.held(0, .down)) core.top_point_y -= speed;
    if (retro.input.joy.held(0, .left)) core.top_point_x -= speed;
    if (retro.input.joy.held(0, .right)) core.top_point_x += speed;

    const x = @as(f32, @floatFromInt(retro.input.analog.x(0, .left))) / std.math.maxInt(i16);
    const y = @as(f32, @floatFromInt(retro.input.analog.y(0, .left))) / std.math.maxInt(i16);
    core.top_point_x += x * 0.25;
    core.top_point_y += -(y * 0.25);

    core.top_point_x = std.math.clamp(core.top_point_x, -1, 1);
    core.top_point_y = std.math.clamp(core.top_point_y, -1, 1);

    if (retro.env.getVariableUpdate()) {
        core.bg_color = switch (retro.env.getVariable("basicgl_bg_color").?[0]) {
            'M' => magenta,
            'Y' => yellow,
            else => cornflower_blue,
        };
    }

    gl.BindFramebuffer(gl.FRAMEBUFFER, @intCast(hw_render.getCurrentFramebuffer()));
    gl.Viewport(0, 0, width, height);
    gl.ClearBufferfv(gl.COLOR, 0, &core.bg_color);

    gl.Begin(gl.TRIANGLES);
    gl.Color3f(0, 1, 1);
    gl.Vertex2f(-0.5, -0.5);
    gl.Color3f(1, 0, 1);
    gl.Vertex2f(0.5, -0.5);
    gl.Color3f(1, 1, 0);
    gl.Vertex2f(core.top_point_x, core.top_point_y);
    gl.End();

    retro.audio.sample(0, 0);
    retro.video.refresh(retro.env.hw.frame_buffer_valid, width, height, 0);
}

pub fn loadGame(_: *@This(), _: ?*const retro.GameInfo) bool {
    if (!retro.env.setPixelFormat(.xrgb8888)) _ = retro.env.shutdown();
    if (!retro.env.hw.setRenderCallback(&hw_render)) {
        std.log.err("Failed to initialize OpenGL context.", .{});
        return false;
    }

    return true;
}
