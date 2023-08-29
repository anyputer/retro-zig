const std = @import("std");
const retro = @import("retro");
const img = @import("zigimg");

pub usingnamespace retro.ExportedCore(@This());

pub const system_info: retro.SystemInfo = .{
    .library_name = @typeName(@This()),
    .library_version = "0.1.0",
    .valid_extensions = "png|pbm|ppm|pcx|qoi|bmp|tga",
};

framebuffer: [*]const u8,
width: u32,
height: u32,
pitch: usize,

pub fn setEnvironment() void {
    retro.env.log.init();
}

pub fn init() @This() {
    return undefined;
}

pub fn deinit(_: *@This()) void {}

pub fn run(core: *@This()) void {
    retro.input.poll();
    retro.audio.sample(0, 0);
    retro.video.refresh(core.framebuffer, core.width, core.height, core.pitch);
}

pub fn loadGame(core: *@This(), game: ?*const retro.GameInfo) bool {
    var image = img.Image.fromMemory(retro.allocator, game.?.dataSlice().?) catch {
        std.log.err("Failed to load image.", .{});
        return false;
    };
    std.log.info("Image pixel format: {s}", .{@tagName(image.pixelFormat())});

    switch (image.pixels) {
        .rgb24 => |pixels| {
            const framebuffer = retro.allocator.alloc(retro.Xrgb8888, image.width * image.height) catch {
                std.log.err("Failed to allocate framebuffer.", .{});
                return false;
            };
            defer image.deinit();
            for (pixels, 0..pixels.len) |p, i| framebuffer[i] = .{
                .r = p.r,
                .g = p.g,
                .b = p.b,
            };
            core.framebuffer = @ptrCast(framebuffer);
            core.pitch = image.width * @sizeOf(retro.Xrgb8888);
            if (!retro.env.setPixelFormat(.xrgb8888)) retro.env.exit();
        },
        .rgba32 => |pixels| {
            const framebuffer = retro.allocator.alloc(retro.Xrgb8888, image.width * image.height) catch {
                std.log.err("Failed to allocate framebuffer.", .{});
                return false;
            };
            defer image.deinit();
            for (pixels, 0..pixels.len) |p, i| framebuffer[i] = .{
                .r = p.r,
                .g = p.g,
                .b = p.b,
            };
            core.framebuffer = @ptrCast(framebuffer);
            core.pitch = image.rowByteSize();
            if (!retro.env.setPixelFormat(.xrgb8888)) retro.env.exit();
        },
        // just use the pre-allocated image data it's already in the right format!
        .bgra32 => |pixels| {
            core.framebuffer = @ptrCast(pixels.ptr);
            core.pitch = image.rowByteSize();
            if (!retro.env.setPixelFormat(.xrgb8888)) retro.env.exit();
        },
        .rgb565 => |pixels| {
            core.framebuffer = @ptrCast(pixels.ptr);
            core.pitch = image.rowByteSize();
            if (!retro.env.setPixelFormat(.rgb565)) retro.env.exit();
        },
        .rgb555 => |pixels| {
            core.framebuffer = @ptrCast(pixels.ptr);
            core.pitch = image.rowByteSize();
            if (!retro.env.setPixelFormat(.zrgb1555)) retro.env.exit();
        },
        else => {
            std.log.err("Unsupported image pixel format: {s}", .{@tagName(image.pixelFormat())});
            return false;
        },
    }
    core.width = @intCast(image.width);
    core.height = @intCast(image.height);

    return true;
}

pub fn unloadGame(core: *@This()) void {
    retro.allocator.free(@constCast(core.framebuffer)[0 .. core.width * core.height]);
}

pub fn getSystemAvInfo(core: *@This()) retro.SystemAvInfo {
    return .{
        .geometry = .{
            .base_width = @intCast(core.width),
            .base_height = @intCast(core.height),
            .max_width = @intCast(core.width),
            .max_height = @intCast(core.height),
        },
        .timing = .{ .fps = 60, .sample_rate = 0 },
    };
}
