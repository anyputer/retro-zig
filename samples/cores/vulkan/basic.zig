// this is a Zig port of libretro-samples vk_rendering

const std = @import("std");
const retro = @import("retro");
pub const vk = @import("vulkan");

pub usingnamespace retro.ExportedCore(@This());

pub const system_info: retro.SystemInfo = .{
    .library_name = "TestCore Vulkan (Zig)",
    .library_version = "v1",
};

const width = 320;
const height = 240;

var hw_render = retro.env.hw.RenderCallback{
    .context_type = .vulkan,
    .version_major = vk.API_VERSION_1_0,
    .version_minor = 0,
    .contextReset = contextReset,
    .contextDestroy = contextDestroy,
    .getProcAddress = undefined, // to be set by frontend
    .getCurrentFramebuffer = undefined, // ignored by vulkan
    .bottom_left_origin = undefined, // ignored by vulkan
};
var vulkan: ?*const retro.env.hw.vulkan.RenderInterface = null;

const Context = @import("Context.zig");
var context: Context = undefined;

fn contextDestroy() callconv(.C) void {
    if (vulkan == null) return;
    std.log.info("Context destroy!", .{});
    context.deinit(vulkan.?.device);
    vulkan = null;
    // TODO: std.mem.zeroInit(@TypeOf(context), &context);
}

fn getApplicationInfo() callconv(.C) *const vk.ApplicationInfo {
    return &.{
        .p_application_name = "libretro-test-vulkan",
        .application_version = 0,
        .p_engine_name = "libretro-test-vulkan",
        .engine_version = 0,
        .api_version = vk.API_VERSION_1_0,
    };
}

pub fn setEnvironment() void {
    retro.env.log.init();
    _ = retro.env.setSupportNoGame(true);
}

pub fn init() @This() {
    return .{};
}

pub fn deinit(_: *@This()) void {}

pub fn run(_: *@This()) void {
    retro.input.poll();

    const handle = vulkan.?.handle;
    const device = vulkan.?.device;

    // lazy solution for a lazy problem. very lazy.
    if (vulkan.?.getSyncIndexMask(handle) != context.swapchain_mask) {
        context.deinit(device);
        const sync_index_mask = vulkan.?.getSyncIndexMask(handle);
        context = Context.init(device, vulkan.?.gpu, sync_index_mask, vulkan.?.queue_index) catch |err| {
            std.log.err("Failed to initialize context: {s}", .{@errorName(err)});
            _ = retro.env.shutdown();
            return;
        };
    }

    vulkan.?.waitSyncIndex(handle);

    context.index = vulkan.?.getSyncIndex(handle);
    context.render(device) catch |err| {
        std.log.err("Failed to render: {s}", .{@errorName(err)});
        _ = retro.env.shutdown();
        return;
    };
    vulkan.?.setImage(handle, @ptrCast(&context.images[context.index]), 0, null, vk.QUEUE_FAMILY_IGNORED);
    vulkan.?.setCommandBuffers(handle, 1, @ptrCast(&context.cmd[context.index]));

    retro.audio.sample(0, 0);
    retro.video.refresh(@ptrCast(retro.env.hw.frame_buffer_valid), width, height, 0);
}

fn contextReset() callconv(.C) void {
    if (!retro.env.hw.getRenderInterface(@ptrCast(&vulkan)) or vulkan == null) {
        std.log.err("Failed to get HW rendering interface.", .{});
        return;
    }

    const interface_version = vulkan.?.interface_version;
    if (interface_version != retro.env.hw.vulkan.RenderInterface.version) {
        std.log.err("HW render interface mismatch, expected {}, got {}!", .{
            retro.env.hw.vulkan.RenderInterface.version,
            interface_version,
        });
        vulkan = null;
        return;
    }

    const device = vulkan.?.device;
    // SAFETY: if the frontend doesn't support the specified API version it will exit early.
    Context.vki = Context.InstanceDispatch.loadNoFail(vulkan.?.instance, vulkan.?.getInstanceProcAddr);
    Context.vkd = Context.DeviceDispatch.loadNoFail(device, vulkan.?.getDeviceProcAddr);

    const sync_index_mask = vulkan.?.getSyncIndexMask(vulkan.?.handle);
    context = Context.init(device, vulkan.?.gpu, sync_index_mask, vulkan.?.queue_index) catch |err| {
        std.log.err("Failed to initialize context: {s}", .{@errorName(err)});
        return;
    };
}

pub fn loadGame(_: *@This(), _: ?*const retro.GameInfo) bool {
    if (!retro.env.hw.setRenderCallback(&hw_render)) {
        std.log.err("Failed to initialize HW context.", .{});
        return false;
    }

    const iface = retro.env.hw.vulkan.RenderContextNegotiationInterfaceV1{
        .getApplicationInfo = getApplicationInfo,
    };
    // TODO: should this return value be discarded?
    _ = retro.env.hw.setRenderContextNegotiationInterface(@ptrCast(&iface));

    return true;
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
