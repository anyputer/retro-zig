// MIT License
//
// Copyright © 2023 anyputer and The RetroArch team
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// TODO: take a lot of things out of the env namespace. like it should be retro.FrameTimeCallback not retro.env.FrameTimeCallback

const std = @import("std");

pub const allocator = if (@import("builtin").target.isWasm()) w: {
    break :w std.heap.wasm_allocator;
} else if (@import("builtin").link_libc)
c: {
    break :c std.heap.c_allocator;
} else {
    @compileError("you must either link libc or target wasm to use retro.allocator");
};

pub const api_version = 1;
const retro_callconv = .C;

pub const Device = enum(c_int) {
    none,
    joypad, //= 1,
    mouse,
    keyboard,
    lightgun,
    analog,
    pointer,
    _,

    // TODO: pub fn subclass
};

pub const Mouse = enum(c_int) {
    x,
    y,
    left,
    right,
    wheelup,
    wheeldown,
    middle,
    horiz_wheelup,
    horiz_wheeldown,
    button_4,
    button_5,
    _,
};

pub const Region = enum(c_int) {
    ntsc,
    pal,
    _,
};

// TODO: RETRO_MEMORY_MASK?
pub const Memory = enum(c_int) {
    save_ram,
    rtc,
    system_ram,
    video_ram,
    _,
};

pub const Rotation = enum(c_int) {
    @"0",
    @"90",
    @"180",
    @"270",
};

pub const PixelFormat = enum(c_int) {
    zrgb1555,
    xrgb8888,
    rgb565,
    _,
};

pub const Message = extern struct {
    /// Message to be displayed.
    msg: [*:0]const u8,
    /// Duration in frames of message.
    frames: c_uint,
};

pub const MessageTarget = enum(c_int) {
    all,
    osd,
    log,
    _,
};

pub const MessageType = enum(c_int) {
    notification,
    notification_alt,
    status,
    progress,
    _,
};

pub const MessageExt = extern struct {
    msg: [*:0]const u8,
    duration: c_uint,
    priority: c_uint,
    level: env.log.Level,
    target: MessageTarget,
    type: MessageType,
    progress: i8,
};

pub const SystemInfo = extern struct {
    library_name: [*:0]const u8,
    library_version: [*:0]const u8,
    valid_extensions: ?[*:0]const u8 = null,
    need_fullpath: bool = false,
    block_extract: bool = false,
};

pub const GameInfoExt = extern struct {
    full_path: ?[*:0]const u8,
    archive_path: ?[*:0]const u8,
    archive_file: ?[*:0]const u8,
    dir: [*:0]const u8,
    name: [*:0]const u8,
    ext: [*:0]const u8,
    meta: [*:0]const u8,
    data: ?[*]const u8,
    size: usize,
    file_in_archive: bool,
    persistent_data: bool,
};

pub const GameGeometry = extern struct {
    base_width: c_uint,
    base_height: c_uint,
    max_width: c_uint,
    max_height: c_uint,
    aspect_ratio: f32 = 0,
};

pub const SystemTiming = extern struct {
    fps: f64,
    sample_rate: f64,
};

pub const SystemAvInfo = extern struct {
    geometry: GameGeometry,
    timing: SystemTiming,
};

pub const GameInfo = extern struct {
    path: ?[*:0]const u8,
    data: ?[*]const u8,
    size: usize,
    meta: ?[*:0]const u8 = "", // TODO: can this be optional?

    pub fn dataSlice(info: @This()) ?[]const u8 {
        return if (info.data) |ptr| ptr[0..info.size] else null;
    }
};

pub const Zrgb1555 = packed struct(u16) {
    b: u5 = 0,
    g: u5 = 0,
    r: u5 = 0,
    _: u1 = 0,
};

pub const Xrgb8888 = packed struct(u32) {
    b: u8 = 0,
    g: u8 = 0,
    r: u8 = 0,
    x: u8 = 0,

    // TODO: are these consts defined correctly?
    // zig fmt: off
    pub const red:     @This() = @bitCast(@as(u32, 0xFF0000_00));
    pub const green:   @This() = @bitCast(@as(u32, 0x00FF00_00));
    pub const blue:    @This() = @bitCast(@as(u32, 0x0000FF_00));
    pub const cyan:    @This() = @bitCast(@as(u32, 0x00FFFF_00));
    pub const magenta: @This() = @bitCast(@as(u32, 0xFF00FF_00));
    pub const yellow:  @This() = @bitCast(@as(u32, 0xFFFF00_00));
    pub const black:   @This() = .{};
    pub const white:   @This() = @bitCast(@as(u32, 0xFFFFFF_00));
    // zig fmt: on
};

pub const Rgb565 = packed struct(u16) {
    b: u5 = 0,
    g: u6 = 0,
    r: u5 = 0,

    // TODO: are these consts defined correctly?
    // zig fmt: off
    pub const red:     @This() = @bitCast(@as(u16, 0b11111_000000_00000));
    pub const green:   @This() = @bitCast(@as(u16, 0b00000_111111_00000));
    pub const blue:    @This() = @bitCast(@as(u16, 0b00000_000000_11111));
    pub const cyan:    @This() = @bitCast(@as(u16, 0b00000_111111_11111));
    pub const magenta: @This() = @bitCast(@as(u16, 0b11111_000000_11111));
    pub const yellow:  @This() = @bitCast(@as(u16, 0b11111_111111_00000));
    pub const black:   @This() = .{};
    pub const white:   @This() = @bitCast(@as(u16, 0b11111_111111_11111));
    // zig fmt: on
};

// TODO: consider moving hw, log, etc namespaces out
pub const env = struct {
    pub const CallbackFn = fn (cmd: Command, data: ?*anyopaque) callconv(retro_callconv) bool;
    pub const SetCallbackFn = fn (*const CallbackFn) callconv(retro_callconv) void;

    pub const Command = enum(c_int) {
        set_rotation = 1,
        get_overscan,
        get_can_dupe,
        set_message = 6,
        shutdown,
        set_performance_level,
        get_system_directory,
        set_pixel_format,
        set_input_descriptors,
        set_keyboard_callback,
        set_disk_control_interface,
        set_hw_render,
        get_variable,
        set_variables,
        get_variable_update,
        set_support_no_game,
        get_libretro_path,
        set_frame_time_callback = 21,
        set_audio_callback,
        get_rumble_interface,
        get_input_device_capabilities,
        get_sensor_interface = 25 | experimental,
        get_camera_interface = 26 | experimental,
        get_log_interface = 27,
        get_perf_interface,
        get_location_interface,
        get_core_assets_directory,
        get_save_directory,
        set_system_av_info,
        set_proc_address_callback,
        set_subsystem_info,
        set_controller_info,
        set_memory_maps = 36 | experimental,
        set_geometry = 37,
        get_username,
        get_language,
        get_current_software_framebuffer = 40 | experimental,
        get_hw_render_interface = 41 | experimental,
        set_support_achievements = 42 | experimental,
        set_hw_render_context_negotiation_interface = 43 | experimental,
        set_serialization_quirks = 44,
        set_hw_shared_context = 44 | experimental,
        get_vfs_interface = 45 | experimental,
        get_led_interface = 46 | experimental,
        get_audio_video_enable = 47 | experimental,
        get_midi_interface = 48 | experimental,
        get_fastforwarding = 49 | experimental,
        get_target_refresh_rate = 50 | experimental,
        get_input_bitmasks = 51 | experimental,
        get_core_options_version = 52,
        set_core_options,
        set_core_options_intl,
        set_core_options_display,
        get_preferred_hw_render,
        get_disk_control_interface_version,
        set_disk_control_ext_interface,
        get_message_interface_version,
        set_message_ext,
        get_input_max_users,
        set_audio_buffer_status_callback,
        set_minimum_audio_latency,
        set_fastforwarding_override,
        set_content_info_override,
        get_game_info_ext,
        set_core_options_v2,
        set_core_options_v2_intl,
        set_core_options_update_display_callback,
        set_variable,
        get_throttle_state = 71 | experimental,
        get_savestate_context = 72 | experimental,
        get_hw_render_context_negotiation_interface_support = 73 | experimental,
        get_jit_capable = 74,
        get_microphone_interface = 75 | experimental,
        set_netpacket_interface = 76,
        _,

        // TODO: add more commands

        // TODO: make these private or what?
        pub const experimental = 0x10000;
        pub const private = 0x10000;

        //pub inline fn experimental(id: c_uint) @This() {
        //    return @This()(id | 0x10000);
        //}

        //pub inline fn private(id: c_uint) @This() {
        //    return @This()(id | 0x20000);
        //}
    };

    fn dummyCallback(_: Command, _: ?*anyopaque) callconv(retro_callconv) bool {
        @panic("environment callback hasn't been initialized");
    }

    pub var callback: *const CallbackFn = if (std.debug.runtime_safety) dummyCallback else undefined;

    pub fn getOverscan() bool {
        var use_overscan: bool = false;
        _ = callback(.get_overscan, &use_overscan);
        return use_overscan;
    }

    pub fn getCanDupe() bool {
        var can_dupe: bool = false;
        _ = callback(.get_can_dupe, &can_dupe);
        return can_dupe;
    }

    pub fn setMessage(message: *const Message) bool {
        return callback(.set_message, @constCast(message));
    }

    pub fn shutdown() bool {
        return callback(.shutdown, null);
    }

    /// Exits the libretro core.
    pub fn exit() noreturn {
        if (shutdown()) unreachable else std.os.abort();
    }

    pub fn getSystemDir() ?[*:0]const u8 {
        var dir: ?[*:0]const u8 = null;
        _ = callback(.get_system_directory, @ptrCast(&dir));
        return dir;
    }

    // TODO: *const PixelFormat?
    pub fn setPixelFormat(format: PixelFormat) bool {
        return callback(.set_pixel_format, @constCast(&format));
    }
    pub const Key = enum(c_int) {
        unknown = 0,
        first = 0,
        backspace = 8,
        tab = 9,
        clear = 12,
        @"return" = 13,
        pause = 19,
        escape = 27,
        space = 32,
        exclaim = 33,
        quotedbl = 34,
        hash = 35,
        dollar = 36,
        ampersand = 38,
        quote = 39,
        leftparen = 40,
        rightparen = 41,
        asterisk = 42,
        plus = 43,
        comma = 44,
        minus = 45,
        period = 46,
        slash = 47,
        @"0" = 48,
        @"1" = 49,
        @"2" = 50,
        @"3" = 51,
        @"4" = 52,
        @"5" = 53,
        @"6" = 54,
        @"7" = 55,
        @"8" = 56,
        @"9" = 57,
        colon = 58,
        semicolon = 59,
        less = 60,
        equals = 61,
        greater = 62,
        question = 63,
        at = 64,
        leftbracket = 91,
        backslash = 92,
        rightbracket = 93,
        caret = 94,
        underscore = 95,
        backquote = 96,
        a = 97,
        b = 98,
        c = 99,
        d = 100,
        e = 101,
        f = 102,
        g = 103,
        h = 104,
        i = 105,
        j = 106,
        k = 107,
        l = 108,
        m = 109,
        n = 110,
        o = 111,
        p = 112,
        q = 113,
        r = 114,
        s = 115,
        t = 116,
        u = 117,
        v = 118,
        w = 119,
        x = 120,
        y = 121,
        z = 122,
        leftbrace = 123,
        bar = 124,
        rightbrace = 125,
        tilde = 126,
        delete = 127,
        kp0 = 256,
        kp1 = 257,
        kp2 = 258,
        kp3 = 259,
        kp4 = 260,
        kp5 = 261,
        kp6 = 262,
        kp7 = 263,
        kp8 = 264,
        kp9 = 265,
        kp_period = 266,
        kp_divide = 267,
        kp_multiply = 268,
        kp_minus = 269,
        kp_plus = 270,
        kp_enter = 271,
        kp_equals = 272,
        up = 273,
        down = 274,
        right = 275,
        left = 276,
        insert = 277,
        home = 278,
        end = 279,
        pageup = 280,
        pagedown = 281,
        f1 = 282,
        f2 = 283,
        f3 = 284,
        f4 = 285,
        f5 = 286,
        f6 = 287,
        f7 = 288,
        f8 = 289,
        f9 = 290,
        f10 = 291,
        f11 = 292,
        f12 = 293,
        f13 = 294,
        f14 = 295,
        f15 = 296,
        numlock = 300,
        capslock = 301,
        scrollock = 302,
        rshift = 303,
        lshift = 304,
        rctrl = 305,
        lctrl = 306,
        ralt = 307,
        lalt = 308,
        rmeta = 309,
        lmeta = 310,
        lsuper = 311,
        rsuper = 312,
        mode = 313,
        compose = 314,
        help = 315,
        print = 316,
        sysreq = 317,
        @"break" = 318,
        menu = 319,
        power = 320,
        euro = 321,
        undo = 322,
        oem_102 = 323,
        _,
    };
    pub const ProcAddress = *const fn () callconv(retro_callconv) void;

    pub const hw = struct {
        //pub const frame_buffer_valid: *const anyopaque = @ptrFromInt(std.math.maxInt(usize) - 1);
        pub const frame_buffer_valid: *const anyopaque = @ptrFromInt(@as(usize, @bitCast(@as(isize, -1))));
        pub const ContextResetFn = fn () callconv(retro_callconv) void;
        pub const GetCurrentFramebufferFn = fn () callconv(retro_callconv) usize;
        pub const GetProcAddressFn = fn (sym: [*:0]const u8) callconv(retro_callconv) ProcAddress;
        pub const ContextType = enum(c_int) {
            none,
            opengl,
            opengles2,
            opengl_core,
            opengles3,
            opengles_version,
            vulkan,
            d3d11,
            d3d10,
            d3d12,
            d3d9,
            _,
        };

        pub const RenderCallback = extern struct {
            context_type: ContextType,
            contextReset: *const ContextResetFn,
            getCurrentFramebuffer: *const GetCurrentFramebufferFn,
            getProcAddress: *const GetProcAddressFn,
            depth: bool = true, // obsolete
            stencil: bool = false,
            bottom_left_origin: bool,
            version_major: c_uint = 0,
            version_minor: c_uint = 0,
            cache_context: bool = true,
            contextDestroy: *const ContextResetFn,
            debug_context: bool = @import("builtin").mode == .Debug,
        };

        pub fn setRenderCallback(cb: *RenderCallback) bool {
            return callback(.set_hw_render, cb);
        }

        pub const RenderInterfaceBase = extern struct {
            interface_type: Type,
            interface_version: c_uint,

            pub const Type = enum(c_int) {
                vulkan,
                d3d9,
                d3d10,
                d3d11,
                d3d12,
                gskit_ps2,
                _,
            };
        };

        pub const RenderContextNegotiationInterfaceBase = extern struct {
            interface_type: Type,
            interface_version: c_uint,

            pub const Type = enum(c_int) {
                vulkan,
                _,
            };
        };

        pub fn setRenderContextNegotiationInterface(interface: *const RenderContextNegotiationInterfaceBase) bool {
            return callback(.set_hw_render_context_negotiation_interface, @constCast(interface));
        }

        // it is recommended to build RetroArch with Vulkan validation enabled for debugging
        pub const vulkan = struct {
            const root = @import("root");

            // use Snektron's vulkan-zig or export everything yourself in this struct
            const vk = root.vk;

            pub const Image = extern struct {
                image_view: vk.ImageView,
                image_layout: vk.ImageLayout,
                create_info: vk.ImageViewCreateInfo,
            };

            // TODO: should this be nullable?
            pub const Handle = *opaque {};

            pub const SetImageFn = fn (handle: Handle, image: *const Image, num_semaphores: u32, semaphores: ?[*]const vk.Semaphore, src_queue_family: u32) callconv(retro_callconv) void;
            pub const GetSyncIndexFn = fn (handle: Handle) callconv(retro_callconv) u32;
            pub const GetSyncIndexMaskFn = fn (handle: Handle) callconv(retro_callconv) u32;
            pub const SetCommandBuffersFn = fn (handle: Handle, num_cmd: u32, cmd: [*]const vk.CommandBuffer) callconv(retro_callconv) void;
            pub const WaitSyncIndexFn = fn (handle: Handle) callconv(retro_callconv) void;
            pub const LockQueueFn = fn (handle: Handle) callconv(retro_callconv) void;
            pub const UnlockQueueFn = fn (handle: Handle) callconv(retro_callconv) void;
            pub const SetSignalSemaphoreFn = fn (handle: Handle) callconv(retro_callconv) void;

            pub const GetApplicationInfoFn = fn () callconv(retro_callconv) *const vk.ApplicationInfo;

            pub const Context = extern struct {
                gpu: vk.PhysicalDevice,
                device: vk.Device,
                queue: vk.Queue,
                queue_family_index: u32,
                presentation_queue: vk.Queue,
                presentation_queue_family_index: u32,
            };

            pub const CreateDeviceFn = fn (
                context: *Context,
                instance: vk.Instance,
                gpu: vk.PhysicalDevice,
                surface: vk.SurfaceKHR,
                getInstanceProcAddr: vk.PfnGetInstanceProcAddr,
                required_device_extensions: [*][*:0]const u8,
                num_required_device_extensions: c_uint,
                required_device_layers: [*][*:0]const u8,
                num_required_device_layers: c_uint,
                required_features: *const vk.PhysicalDeviceFeatures,
            ) callconv(retro_callconv) bool;
            pub const DestroyDeviceFn = fn () callconv(retro_callconv) void;

            pub const RenderContextNegotiationInterfaceV1 = extern struct {
                interface_type: RenderContextNegotiationInterfaceBase.Type = .vulkan,
                interface_version: c_uint = version,

                getApplicationInfo: ?*const GetApplicationInfoFn = null,
                createDevice: ?*const CreateDeviceFn = null,
                destroyDevice: ?*const DestroyDeviceFn = null,

                pub const version = 1;
            };

            pub const CreateInstanceWrapperFn = fn (handle: Handle, create_info: *const vk.InstanceCreateInfo) callconv(retro_callconv) vk.Instance;
            pub const CreateInstanceFn = fn (
                getInstanceProcAddr: vk.PfnGetInstanceProcAddr,
                app: *const vk.ApplicationInfo,
                createInstanceWrapper: *const CreateInstanceWrapperFn,
                handle: Handle,
            ) callconv(retro_callconv) vk.Instance;
            pub const CreateDeviceWrapperFn = fn (gpu: vk.PhysicalDevice, handle: Handle, create_info: *const vk.DeviceCreateInfo) callconv(retro_callconv) vk.Device;
            pub const CreateDevice2Fn = fn (
                context: *const Context,
                instance: vk.Instance,
                gpu: vk.PhysicalDevice,
                surface: vk.SurfaceKHR,
                getInstanceProcAddr: vk.PfnGetInstanceProcAddr,
                createDeviceWrapper: *const CreateDeviceWrapperFn,
                handle: Handle,
            ) callconv(retro_callconv) bool;
            pub const RenderContextNegotiationInterfaceV2 = extern struct {
                interface_type: RenderContextNegotiationInterfaceBase.Type = .vulkan,
                interface_version: c_uint = version,

                getApplicationInfo: ?*const GetApplicationInfoFn = null,
                createDevice: ?*const CreateDeviceFn = null,
                destroyDevice: ?*const DestroyDeviceFn = null,

                createInstance: ?*const CreateInstanceFn = null,
                createDevice2: ?*const CreateDevice2Fn = null,

                pub const version = 2;
            };

            // TODO: if zig adds ranged integer types, it could benefit VK_NULL_HANDLE
            // TODO: which fields should be nullable?
            pub const RenderInterface = extern struct {
                interface_type: RenderInterfaceBase.Type = .vulkan,
                interface_version: c_uint = version,

                handle: Handle,

                instance: vk.Instance,
                gpu: vk.PhysicalDevice,
                device: vk.Device,

                getDeviceProcAddr: vk.PfnGetDeviceProcAddr,
                getInstanceProcAddr: vk.PfnGetInstanceProcAddr,

                queue: vk.Queue,
                queue_index: c_uint,

                setImage: *const SetImageFn,
                getSyncIndex: *const GetSyncIndexFn,
                getSyncIndexMask: *const GetSyncIndexMaskFn,
                setCommandBuffers: *const SetCommandBuffersFn,
                waitSyncIndex: *const WaitSyncIndexFn,

                lockQueue: *const LockQueueFn,
                unlockQueue: *const UnlockQueueFn,

                setSignalSemaphore: *const SetSignalSemaphoreFn,

                pub const version = 5;
            };
        };

        pub fn getRenderInterface(interface: **const RenderInterfaceBase) bool {
            return callback(.get_hw_render_interface, @ptrCast(interface));
        }
    };

    pub const Variable = extern struct {
        key: ?[*:0]const u8 = null,
        value: ?[*:0]const u8 = null,
    };

    pub fn getVariable(key: [*:0]const u8) ?[*:0]const u8 {
        var variable: Variable = .{ .key = key, .value = null };
        _ = callback(.get_variable, &variable);
        return variable.value;
    }

    pub fn setVariables(vars: [*:.{}]const Variable) bool {
        return callback(.set_variables, @constCast(vars));
    }

    pub fn getVariableUpdate() bool {
        var var_update: bool = false;
        _ = callback(.get_variable_update, &var_update);
        return var_update;
    }

    pub fn setSupportNoGame(yes: bool) bool {
        return callback(.set_support_no_game, @constCast(&yes));
    }

    pub const FrameTimeCallback = extern struct {
        callback: *const Fn,
        reference: i64,

        pub const Fn = fn (usec: i64) callconv(retro_callconv) void;
    };

    pub const AudioCallback = extern struct {
        callback: *const Fn,
        setState: *const SetStateFn,

        pub const Fn = fn () callconv(retro_callconv) void;
        pub const SetStateFn = fn (enabled: bool) callconv(retro_callconv) void;
    };

    pub const log = struct {
        pub const Level = enum(c_int) {
            debug,
            info,
            warn,
            @"error",
            _,

            pub fn fromStdLogLevel(comptime level: std.log.Level) @This() {
                return comptime switch (level) {
                    .debug => .debug,
                    .info => .info,
                    .warn => .warn,
                    .err => .@"error",
                };
            }
        };

        pub const PrintfFn = fn (level: Level, fmt: [*:0]const u8, ...) callconv(retro_callconv) void;
        pub const LogCallback = extern struct {
            log: *const PrintfFn,
        };

        //extern fn vfprintf(stream: *std.c.FILE, format: [*:0]const u8, ap: std.builtin.VaList) c_int;
        //extern const stderr: *std.c.FILE;

        // TODO: why does this like to crash? try fixing it and see if it makes the binary size smaller
        //pub export fn stderrFallback(_: Level, fmt: [*:0]const u8, ...) callconv(retro_callconv) void {
        //    var va_list = @cVaStart();
        //    _ = vfprintf(stderr, fmt, va_list);
        //    @cVaEnd(&va_list);
        //}

        //pub var logCallback: *const PrintfFn = stderrFallback;
        pub var logCallback: ?*const PrintfFn = null;

        pub fn basicImpl(
            comptime level: std.log.Level,
            comptime scope: @TypeOf(.enum_literal),
            comptime fmt: []const u8,
            args: anytype,
        ) void {
            if (logCallback) |cb| {
                const buf = std.fmt.allocPrintZ(allocator, fmt, args) catch return;
                defer allocator.free(buf);

                cb(Level.fromStdLogLevel(level), "%s\n", buf.ptr);
            } else std.log.defaultLog(
                level,
                scope,
                fmt,
                args,
            );
        }

        pub fn init() void {
            _ = callback(.get_log_interface, @ptrCast(&logCallback));
        }

        //pub fn getLogger(cb: retro.EnvironmentFn) ?type {
        //    //const logger_available = cb(.GetLogInterface, &log_cb);
        //    //if (logger_available) std.log.level = .debug;
        //
        //    return if (cb(.GetLogInterface, &log_cb)) std.log.scoped(.retro) else null;
        //}

        //pub fn initLogger(cb: retro.EnvironmentFn) bool {
        //    return (cb(.GetLogInterface, &log_cb));
        //}
    };

    pub const Language = enum(c_int) {
        english,
        japanese,
        french,
        spanish,
        german,
        italian,
        dutch,
        portuguese_brazil,
        portuguese_portugal,
        russian,
        korean,
        chinese_traditional,
        chinese_simplified,
        esperanto,
        polish,
        vietnamese,
        arabic,
        greek,
        turkish,
        slovak,
        persian,
        hebrew,
        asturian,
        finnish,
        indonesian,
        swedish,
        ukrainian,
        czech,
        catalan_valencia,
        catalan,
        british_english,
        hungarian,
        _,

        pub const last = blk: {
            const values = std.enums.values(@This());
            break :blk @as(@This(), @enumFromInt(@intFromEnum(values[values.len - 1]) + 1));
        };
    };

    pub fn getLanguage() ?Language {
        var lang: Language = undefined;
        return if (callback(.get_language, &lang)) lang else null;
    }

    pub fn getUsername() ?[*:0]const u8 {
        var name: ?[*:0]const u8 = null;
        _ = callback(.get_username, @ptrCast(&name));
        return name;
    }
};

pub const video = struct {
    pub const RefreshFn = fn (data: ?*const anyopaque, width: c_uint, height: c_uint, pitch: usize) callconv(retro_callconv) void;
    pub const SetRefreshFn = fn (*const RefreshFn) callconv(retro_callconv) void;

    fn dummyRefresh(_: ?*const anyopaque, _: c_uint, _: c_uint, _: usize) callconv(retro_callconv) void {
        @panic("video refresh callback hasn't been initialized");
    }

    // TODO: safety
    pub var refreshCb: *const RefreshFn = if (std.debug.runtime_safety) dummyRefresh else undefined;

    pub fn refresh(data: *const anyopaque, width: c_uint, height: c_uint, pitch: usize) void {
        refreshCb(data, width, height, pitch);
    }

    pub fn dupe(width: c_uint, height: c_uint) void {
        // TODO: does width, height, pitch matter at all?
        refreshCb(null, width, height, 0);
    }
};

pub const audio = struct {
    pub const SampleFn = fn (left: i16, right: i16) callconv(retro_callconv) void;
    pub const SetSampleFn = fn (*const SampleFn) callconv(retro_callconv) void;
    pub const SampleBatchFn = fn (data: [*]const i16, frames: usize) callconv(retro_callconv) usize;
    pub const SetSampleBatchFn = fn (*const SampleBatchFn) callconv(retro_callconv) void;

    fn dummySample(_: i16, _: i16) callconv(retro_callconv) void {
        @panic("audio sample callback hasn't been initialized");
    }
    fn dummySampleBatch(_: [*]const i16, _: usize) callconv(retro_callconv) usize {
        @panic("audio sample batch callback hasn't been initialized");
    }

    pub var sample: *const SampleFn = if (std.debug.runtime_safety) dummySample else undefined;
    pub var sampleBatchCb: *const SampleBatchFn = if (std.debug.runtime_safety) dummySampleBatch else undefined;

    pub fn sampleBatch(samples: [][2]i16) usize {
        return sampleBatchCb(@as(samples.ptr, @ptrCast([*]const i16)), samples.len);
    }
};

pub const input = struct {
    pub const PollFn = fn () callconv(retro_callconv) void;
    pub const SetPollFn = fn (*const PollFn) callconv(retro_callconv) void;
    pub const StateFn = fn (port: c_uint, device: Device, index: c_uint, id: c_uint) callconv(retro_callconv) i16;
    pub const SetStateFn = fn (*const StateFn) callconv(retro_callconv) void;

    fn dummyPoll() callconv(retro_callconv) void {
        @panic("input poll callback hasn't been initialized");
    }
    fn dummyState(port: c_uint, device: Device, index: c_uint, id: c_uint) callconv(retro_callconv) i16 {
        _ = id;
        _ = index;
        _ = device;
        _ = port;
        @panic("input state callback hasn't been initialized");
    }

    pub var poll: *const PollFn = if (std.debug.runtime_safety) dummyPoll else undefined;
    pub var state: *const StateFn = if (std.debug.runtime_safety) dummyState else undefined;

    pub const joy = struct {
        // TODO: should all these enums be c_int instead of c_uint?
        pub const Button = enum(c_uint) { b, y, select, start, up, down, left, right, a, x, l, r, l2, r2, l3, r3 };

        // TODO: auto generate this from the Button enum
        pub const Mask = packed struct(i16) {
            b: bool,
            y: bool,
            select: bool,
            start: bool,
            up: bool,
            down: bool,
            left: bool,
            right: bool,
            a: bool,
            x: bool,
            l: bool,
            r: bool,
            l2: bool,
            r2: bool,
            l3: bool,
            r3: bool,
        };

        pub fn buttons(port: c_uint) Mask {
            return @as(Mask, @bitCast(input.state(port, .joypad, 0, 256)));
        }

        pub fn held(port: c_uint, button: joy.Button) bool {
            return input.state(port, .joypad, 0, @intFromEnum(button)) != 0;
        }
    };

    pub const analog = struct {
        pub const Index = enum(c_uint) { left, right, button, _ };
        pub const Stick = enum { left, right };
        pub const Axis = enum { x, y };

        pub fn state(port: c_uint, index: Index, id: c_uint) i16 {
            return input.state(port, .analog, @intFromEnum(index), id);
        }

        pub fn x(port: c_uint, stick: Stick) i16 {
            return input.analog.state(port, @enumFromInt(@intFromEnum(stick)), @intFromEnum(Axis.x));
        }

        pub fn y(port: c_uint, stick: Stick) i16 {
            return input.analog.state(port, @enumFromInt(@intFromEnum(stick)), @intFromEnum(Axis.y));
        }

        pub fn button(port: c_uint, b: joy.Button) i16 {
            return input.analog.state(port, .button, @intFromEnum(b));
        }
    };

    pub const pointer = struct {
        pub const Id = enum(c_uint) { x, y, pressed, count, _ };

        pub fn state(port: c_uint, id: Id) i16 {
            return input.state(port, .pointer, 0, @intFromEnum(id));
        }

        pub fn x(port: c_uint) i16 {
            return input.pointer.state(port, .x);
        }

        pub fn y(port: c_uint) i16 {
            return input.pointer.state(port, .y);
        }

        pub fn pressed(port: c_uint) bool {
            return input.pointer.state(port, .pressed) != 0;
        }

        // TODO: return u15?
        // return @truncate(@as(u16, @intCast(input.pointer.state(port, .count))));
        pub fn count(port: c_uint) i16 {
            return input.pointer.state(port, .count);
        }
    };

    pub const Descriptor = extern struct {
        port: c_uint,
        device: Device,
        index: c_uint,
        id: c_uint,
        description: [*:0]const u8,
    };
};

pub const ApiVersionFn = fn () callconv(retro_callconv) c_uint;
pub const InitFn = fn () callconv(retro_callconv) void;
pub const DeinitFn = fn () callconv(retro_callconv) void;
pub const GetSystemInfoFn = fn (info: *SystemInfo) callconv(retro_callconv) void;
pub const GetSystemAvInfoFn = fn (info: *SystemAvInfo) callconv(retro_callconv) void;
pub const SetControllerPortDeviceFn = fn (port: c_uint, device: Device) callconv(retro_callconv) void;
pub const ResetFn = fn () callconv(retro_callconv) void;
pub const RunFn = fn () callconv(retro_callconv) void;
pub const SerializeSizeFn = fn () callconv(retro_callconv) usize;
pub const SerializeFn = fn (data: [*]u8, size: usize) callconv(retro_callconv) bool;
pub const UnserializeFn = fn (data: [*]const u8, size: usize) callconv(retro_callconv) bool;
pub const CheatResetFn = fn () callconv(retro_callconv) void;
pub const CheatSetFn = fn (index: c_uint, enabled: bool, code: ?[*:0]const u8) callconv(retro_callconv) void;
pub const LoadGameFn = fn (game: ?*const GameInfo) callconv(retro_callconv) bool;
pub const LoadGameSpecialFn = fn (game_type: c_uint, info: [*]const GameInfo, num_info: usize) callconv(retro_callconv) bool;
pub const UnloadGameFn = fn () callconv(retro_callconv) void;
pub const GetRegionFn = fn () callconv(retro_callconv) Region;
pub const GetMemoryDataFn = fn (id: Memory) callconv(retro_callconv) ?[*]u8;
pub const GetMemorySizeFn = fn (id: Memory) callconv(retro_callconv) usize;

// TODO: should the library's callbacks that are set be accessed only via this?
// like, the env callback isn't in the retro module anymore, but ExportedCore exposes an env namespace which can specialize itself like
// for example using a global namespace (like .basicgl) to make getVariable(.bg_color) possible
// TODO: describe the interface in detail and easy to navigate in documentation
/// Exports a simplified yet powerful libretro interface.
///
/// This is to reduce boilerplate and eliminate potential safety bugs.
pub fn ExportedCore(comptime Core: type) type {
    return struct {
        pub const std_options = struct {
            pub const log_level = .debug;
            pub const logFn = env.log.basicImpl;
        };

        var core: Core = undefined;

        // TODO: check function types for better error messages, look how mach does it
        // TODO: consider not making these public? or maybe we want that?

        pub export fn retro_api_version() c_uint {
            return api_version;
        }

        pub export fn retro_set_environment(cb: *const env.CallbackFn) void {
            env.callback = cb;
            //env.log.init(); // TODO: maybe hide log init?
            if (@hasDecl(Core, "setEnvironment")) blk: {
                break :blk @call(.always_inline, Core.setEnvironment, .{});
            }
        }
        pub export fn retro_set_video_refresh(cb: *const video.RefreshFn) void {
            video.refreshCb = cb;
            if (@hasDecl(Core, "setVideoRefresh")) blk: {
                break :blk @call(.always_inline, Core.setVideoRefresh, .{});
            }
        }
        pub export fn retro_set_audio_sample(cb: *const audio.SampleFn) void {
            audio.sample = cb;
            if (@hasDecl(Core, "setAudioSample")) blk: {
                break :blk @call(.always_inline, Core.setAudioSample, .{});
            }
        }
        pub export fn retro_set_audio_sample_batch(cb: *const audio.SampleBatchFn) void {
            audio.sampleBatchCb = cb;
            if (@hasDecl(Core, "setAudioSampleBatch")) blk: {
                break :blk @call(.always_inline, Core.setAudioSampleBatch, .{});
            }
        }
        pub export fn retro_set_input_poll(cb: *const input.PollFn) void {
            input.poll = cb;
            if (@hasDecl(Core, "setInputPoll")) blk: {
                break :blk @call(.always_inline, Core.setInputPoll, .{});
            }
        }
        pub export fn retro_set_input_state(cb: *const input.StateFn) void {
            input.state = cb;
            if (@hasDecl(Core, "setInputState")) blk: {
                break :blk @call(.always_inline, Core.setInputState, .{});
            }
        }

        pub export fn retro_init() void {
            core = if (@hasDecl(Core, "init")) Core.init() else Core{};
        }

        pub export fn retro_deinit() void {
            if (@hasDecl(Core, "deinit")) blk: {
                break :blk @call(.always_inline, Core.deinit, .{&core});
            }
        }

        pub export fn retro_get_system_info(info: *SystemInfo) void {
            info.* = Core.system_info;
        }

        pub export fn retro_get_system_av_info(info: *SystemAvInfo) void {
            info.* = @call(.always_inline, Core.getSystemAvInfo, .{&core});
        }

        pub export fn retro_set_controller_port_device(port: c_uint, device: Device) void {
            if (@hasDecl(Core, "setControllerPortDevice")) blk: {
                break :blk @call(.always_inline, Core.setControllerPortDevice, .{ &core, port, device });
            }
        }

        pub export fn retro_reset() void {
            if (@hasDecl(Core, "reset")) blk: {
                break :blk @call(.always_inline, Core.reset, .{&core});
            }
        }

        pub export fn retro_run() void {
            if (@hasDecl(Core, "run")) blk: {
                break :blk @call(.always_inline, Core.run, .{&core});
            }
        }

        pub export fn retro_serialize_size() usize {
            return if (@hasDecl(Core, "serializeSize")) blk: {
                break :blk @call(.always_inline, Core.serializeSize, .{&core});
            } else 0;
        }

        pub export fn retro_serialize(data: [*]u8, size: usize) bool {
            return if (@hasDecl(Core, "serialize")) blk: {
                break :blk @call(.always_inline, Core.serialize, .{data[0..size]});
            } else false;
        }

        pub export fn retro_unserialize(data: [*]const u8, size: usize) bool {
            return if (@hasDecl(Core, "unserialize")) blk: {
                break :blk @call(.always_inline, Core.unserialize, .{data[0..size]});
            } else false;
        }

        pub export fn retro_cheat_reset() void {
            if (@hasDecl(Core, "cheatReset")) blk: {
                break :blk @call(.always_inline, Core.cheatReset, .{&core});
            }
        }

        pub export fn retro_cheat_set(index: c_uint, enabled: bool, code: ?[*:0]const u8) void {
            if (@hasDecl(Core, "cheatSet")) blk: {
                break :blk @call(.always_inline, Core.cheatSet, .{ index, enabled, code });
            }
        }

        pub export fn retro_load_game(game: ?*const GameInfo) bool {
            return if (@hasDecl(Core, "loadGame")) blk: {
                break :blk @call(.always_inline, Core.loadGame, .{ &core, game });
            } else true;
        }

        pub export fn retro_load_game_special(game_type: c_uint, info: [*]const GameInfo, num_info: usize) bool {
            return if (@hasDecl(Core, "loadGameSpecial")) blk: {
                break :blk @call(.always_inline, Core.loadGameSpecial, .{ game_type, info[0..num_info] });
            } else false;
        }

        pub export fn retro_unload_game() void {
            if (@hasDecl(Core, "unloadGame")) blk: {
                break :blk @call(.always_inline, Core.unloadGame, .{&core});
            }
        }

        pub export fn retro_get_region() Region {
            return if (@hasDecl(Core, "getRegion")) blk: {
                break :blk @call(.always_inline, Core.getRegion, .{&core});
            } else .ntsc;
        }

        pub export fn retro_get_memory_data(id: Memory) ?[*]u8 {
            return if (@hasDecl(Core, "getMemoryData")) blk: {
                break :blk @call(.always_inline, Core.getMemoryData, .{ &core, id });
            } else null;
        }

        pub export fn retro_get_memory_size(id: Memory) usize {
            return if (@hasDecl(Core, "getMemorySize")) blk: {
                break :blk @call(.always_inline, Core.getMemorySize, .{ &core, id });
            } else 0;
        }

        comptime {
            validateExports();
        }
    };
}

// TODO: consider whether it would be a better design to export the functions via a struct
/// Validates that the libretro API symbols are exported correctly.
pub fn validateExports() void {
    const root = @import("root");

    // zig fmt: off
    const fns = [_]struct { @TypeOf(.enum_literal), type }{
        .{ .api_version,                ApiVersionFn },
        .{ .set_environment,            env.SetCallbackFn },
        .{ .set_video_refresh,          video.SetRefreshFn },
        .{ .set_audio_sample,           audio.SetSampleFn },
        .{ .set_audio_sample_batch,     audio.SetSampleBatchFn },
        .{ .set_input_poll,             input.SetPollFn },
        .{ .set_input_state,            input.SetStateFn },
        .{ .init,                       InitFn },
        .{ .deinit,                     DeinitFn },
        .{ .get_system_info,            GetSystemInfoFn },
        .{ .get_system_av_info,         GetSystemAvInfoFn },
        .{ .set_controller_port_device, SetControllerPortDeviceFn },
        .{ .reset,                      ResetFn },
        .{ .run,                        RunFn },
        .{ .serialize_size,             SerializeSizeFn },
        .{ .serialize,                  SerializeFn },
        .{ .unserialize,                UnserializeFn },
        .{ .cheat_reset,                CheatResetFn },
        .{ .cheat_set,                  CheatSetFn },
        .{ .load_game,                  LoadGameFn },
        .{ .load_game_special,          LoadGameSpecialFn },
        .{ .unload_game,                UnloadGameFn },
        .{ .get_region,                 GetRegionFn },
        .{ .get_memory_data,            GetMemoryDataFn },
        .{ .get_memory_size,            GetMemorySizeFn },
    };

    inline for (fns) |expected| {
        const symbol_name = "retro_" ++ @tagName(expected[0]);
        if (@hasDecl(root, symbol_name)) {
            const f = @field(root, symbol_name);
            std.debug.assert(@TypeOf(f) == expected[1]);
            // TODO: check if pub export fn and not just a pub fn
        } else @compileError(
            "root file must export " ++ symbol_name ++ ", and publicly",
        );
    }

    std.debug.assert(root.retro_api_version() == api_version);

    // TODO:
    //const InvalidInfo: extern struct {
    //    library_name: ?*anyopaque = null,
    //    library_version: ?*anyopaque = null,
    //    valid_extensions: ?*anyopaque = @ptrFromInt(std.math.maxInt(usize) - 1),
    //    need_fullpath: u8 = 42,
    //    block_extract: u8 = 42,
    //} = .{};
    //var info = invalid_info;
    //root.retro_get_system_info(@ptrCast(&info));
    // iterate over fields and make sure they fit within their types
    // while (std.meta.fields(InvalidInfo))

    // TODO: validate valid_extensions format
}
