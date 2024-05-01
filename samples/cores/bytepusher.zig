// A fully featured BytePusher VM
// for more info see: https://esolangs.org/wiki/BytePusher

// TODO: heap allocate fb fallback, RGB565 support, reset (use persistent data from game info), fix retroarch menu garbled video output

const std = @import("std");
const retro = @import("retro");

pub usingnamespace retro.ExportedCore(@This());

const color_map = blk: {
    var c: [256]retro.Xrgb8888 = undefined;
    for (0..6) |r| for (0..6) |g| for (0..6) |b| {
        c[r * 36 + g * 6 + b] = .{ .r = r * 0x33, .g = g * 0x33, .b = b * 0x33 };
    };
    @memset(c[216..], retro.Xrgb8888.black);
    break :blk c;
};

ram: [std.math.maxInt(u24) + 8]u8 = undefined,

pub const system_info: retro.SystemInfo = .{
    .library_name = "BytePusher",
    .library_version = "0.1.0",
    .valid_extensions = "bp|BytePusher",
};

pub fn setEnvironment() void {}

pub fn loadGame(bytepusher: *@This(), game: ?*const retro.GameInfo) bool {
    @memset(&bytepusher.ram, 0);
    const len = @min(game.?.size, std.math.maxInt(u24));
    @memcpy(bytepusher.ram[0..len], game.?.data.?[0..len]);

    return true;
}

pub fn getSystemAvInfo(_: *@This()) retro.SystemAvInfo {
    if (!retro.env.setPixelFormat(.xrgb8888)) retro.env.exit();
    return .{
        .geometry = .{
            .base_width = 256,
            .base_height = 256,
            .max_width = 256,
            .max_height = 256,
        },
        .timing = .{ .fps = 60, .sample_rate = 15360 },
    };
}

pub fn run(bytepusher: *@This()) void {
    retro.input.poll();

    @memcpy(bytepusher.ram[0..2], std.mem.asBytes(&retro.input.joy.buttons(0)));
    var pc = std.mem.readInt(u24, bytepusher.ram[2 .. 2 + 3], .big);

    for (0..65536) |_| {
        const a = std.mem.readInt(u24, @ptrCast(bytepusher.ram[pc..]), .big);
        const b = std.mem.readInt(u24, @ptrCast(bytepusher.ram[pc + 3 ..]), .big);
        const c = std.mem.readInt(u24, @ptrCast(bytepusher.ram[pc + 6 ..]), .big);

        bytepusher.ram[b] = bytepusher.ram[a];
        pc = c;
    }

    const pixels_addr = @as(u24, @intCast(bytepusher.ram[5])) << 16;
    const pixels = bytepusher.ram[pixels_addr .. pixels_addr + 256 * 256];

    var fb = retro.env.Framebuffer{
        .data = undefined,
        .width = 256,
        .height = 256,
        .pitch = 256 * @sizeOf(retro.Xrgb8888),
        .format = undefined,
        .access_flags = .{ .write = true, .read = false },
        .memory_flags = undefined,
    };
    if (retro.env.callback(.get_current_software_framebuffer, &fb)) {
        const out_pixels: *[256 * 256]retro.Xrgb8888 = @alignCast(@ptrCast(fb.data));

        for (pixels, out_pixels) |color_index, *out_pixel| {
            out_pixel.* = color_map[color_index];
        }
        retro.video.refresh(fb.data, fb.width, fb.height, fb.pitch);
    }

    const samples_addr = @as(u24, std.mem.readInt(u16, bytepusher.ram[6 .. 6 + 2], .big)) << 8;
    const samples: []i8 = @ptrCast(bytepusher.ram[samples_addr .. samples_addr +% 256]);
    var out_samples: [256][2]i16 = undefined;

    for (samples, &out_samples) |sample, *stereo| {
        const s = @as(i16, sample) << 8;
        stereo[0], stereo[1] = .{ s, s };
    }
    _ = retro.audio.sampleBatch(&out_samples);
}

pub fn serializeSize(_: *@This()) usize {
    return std.math.maxInt(u24);
}

pub fn serialize(bytepusher: *@This(), data: []u8) bool {
    if (data.len < std.math.maxInt(u24)) return false;
    @memcpy(data, bytepusher.ram[0..std.math.maxInt(u24)]);
    return true;
}

pub fn unserialize(bytepusher: *@This(), data: []const u8) bool {
    @memcpy(bytepusher.ram[0..std.math.maxInt(u24)], data);
    return true;
}

pub fn getMemoryData(bytepusher: *@This(), id: retro.Memory) ?[*]u8 {
    return switch (id) {
        .system_ram => &bytepusher.ram,
        .video_ram => blk: {
            const pixels_addr = @as(u24, @intCast(bytepusher.ram[5])) << 16;
            break :blk bytepusher.ram[pixels_addr..].ptr;
        },
        else => null,
    };
}

pub fn getMemorySize(_: *@This(), id: retro.Memory) usize {
    return switch (id) {
        .system_ram => std.math.maxInt(u24),
        .video_ram => 256 * 256,
        else => 0,
    };
}
