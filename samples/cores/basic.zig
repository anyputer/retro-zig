const std = @import("std");
const retro = @import("retro");

//pub const std_options = std.Options{
//    .log_level = .debug,
//    .logFn = retro.env.log.basicImpl,
//};

comptime {
    retro.exportCore(@This(), .{
        .library_name = @typeName(@This()),
        .library_version = "0.1.0",
    });
}

const width = 256;
const height = 192;
const pitch = width * @sizeOf(retro.Xrgb8888);

var framebuffer: [width * height]retro.Xrgb8888 = undefined;

pub fn setEnvironment() void {
    //retro.env.log.init();
    _ = retro.env.setSupportNoGame(true);
}

pub fn getSystemAvInfo(_: *@This()) retro.SystemAvInfo {
    if (!retro.env.setPixelFormat(.xrgb8888)) retro.env.exit();
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

pub fn init() @This() {
    for (0..height) |j| for (0..width) |i| {
        const r = @as(f32, @floatFromInt(i)) / (width - 1);
        const g = @as(f32, @floatFromInt(j)) / (height - 1);
        framebuffer[j * width + i] = .{
            .r = std.math.lossyCast(u8, 256 * @sqrt(r)),
            .g = std.math.lossyCast(u8, 256 * g),
            .b = std.math.lossyCast(u8, 256 * @sqrt(g)),
        };
    };
    return .{};
}

pub fn run(_: *@This()) void {
    retro.input.poll();
    retro.audio.sample(0, 0);
    retro.video.refresh(&framebuffer, width, height, pitch);
}

// TODO: maybe? it helps for documentation and safety
//pub fn run(_: *@This(), ctx: retro.RunContext) void {
//    ctx.input.poll();
//    ctx.video.refresh(&framebuffer, width, height, pitch);
//}
