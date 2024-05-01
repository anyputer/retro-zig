const std = @import("std");
const retro = @import("retro");
const c = @cImport(@cInclude("cairo.h"));

pub usingnamespace retro.ExportedCore(@This());

pub const system_info: retro.SystemInfo = .{
    .library_name = "Cairo Test",
    .library_version = "0.1.0",
};

const width = 640;
const height = 480;
const stride = width * @sizeOf(retro.Rgb565);

framebuffer: []retro.Rgb565 = undefined,
surface: *c.cairo_surface_t = undefined,
cr: *c.cairo_t = undefined,

pub fn setEnvironment() void {
    _ = retro.env.setSupportNoGame(true);
}

pub fn getSystemAvInfo(_: *@This()) retro.SystemAvInfo {
    if (!retro.env.setPixelFormat(.rgb565)) retro.env.exit();
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

pub fn run(core: *@This()) void {
    retro.input.poll();
    retro.audio.sample(0, 0);
    retro.video.refresh(
        c.cairo_image_surface_get_data(core.surface),
        @intCast(c.cairo_image_surface_get_width(core.surface)),
        @intCast(c.cairo_image_surface_get_height(core.surface)),
        @intCast(c.cairo_image_surface_get_stride(core.surface)),
    );
}

pub fn loadGame(core: *@This(), _: ?*const retro.GameInfo) bool {
    core.framebuffer = retro.allocator.alloc(retro.Rgb565, width * stride) catch return false;
    @memset(core.framebuffer, retro.Rgb565.white);

    core.surface = c.cairo_image_surface_create_for_data(
        @ptrCast(core.framebuffer.ptr),
        c.CAIRO_FORMAT_RGB16_565,
        width,
        height,
        stride,
    ) orelse return false;
    c.cairo_surface_set_device_scale(core.surface, 2.0, 2.0);

    const cr = c.cairo_create(core.surface) orelse return false;
    core.cr = cr;

    c.cairo_set_antialias(cr, c.CAIRO_ANTIALIAS_NONE);
    c.cairo_move_to(cr, 32, 64);

    c.cairo_set_font_size(cr, 28);
    c.cairo_show_text(cr, "libretro meets cairo");

    c.cairo_set_source_rgb(cr, 0, 1, 0);
    c.cairo_rectangle(cr, 10, 128, 32, 64);
    c.cairo_fill(cr);

    c.cairo_set_source_rgb(cr, 1, 0, 1);
    c.cairo_arc(cr, 160, 160, 64, 0, 32);
    c.cairo_fill(cr);

    return true;
}

pub fn unloadGame(core: *@This()) void {
    retro.allocator.free(core.framebuffer);
    c.cairo_surface_finish(core.surface);
    c.cairo_destroy(core.cr);
}
