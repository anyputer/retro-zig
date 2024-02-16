// TODO: make a simplified vulkan example that uses dynamic rendering, synchronization2, and VMA

const std = @import("std");
const vk = @import("root").vk;

// TODO: make this dynamic
const width: u32 = 320;
const height: u32 = 240;

pub const InstanceDispatch = vk.InstanceWrapper(.{
    .getPhysicalDeviceProperties = true,
    .getPhysicalDeviceMemoryProperties = true,
});
pub const DeviceDispatch = vk.DeviceWrapper(.{
    .getBufferMemoryRequirements = true,
    .bindBufferMemory = true,
    .allocateMemory = true,
    .mapMemory = true,
    .unmapMemory = true,
    .createBuffer = true,
    .createCommandPool = true,
    .allocateCommandBuffers = true,
    .createRenderPass = true,
    .destroyRenderPass = true,
    .createDescriptorSetLayout = true,
    .createDescriptorPool = true,
    .allocateDescriptorSets = true,
    .updateDescriptorSets = true,
    .createShaderModule = true,
    .createPipelineCache = true,
    .createPipelineLayout = true,
    .destroyPipelineLayout = true,
    .createGraphicsPipelines = true,
    .destroyPipeline = true,
    .resetCommandBuffer = true,
    .beginCommandBuffer = true,
    .createImage = true,
    .destroyImage = true,
    .getImageMemoryRequirements = true,
    .bindImageMemory = true,
    .createImageView = true,
    .createFramebuffer = true,
    .cmdPipelineBarrier = true,
    .cmdBeginRenderPass = true,
    .cmdBindPipeline = true,
    .cmdBindDescriptorSets = true,
    .cmdSetViewport = true,
    .cmdSetScissor = true,
    .cmdEndRenderPass = true,
    .cmdDraw = true,
    .cmdBindVertexBuffers = true,
    .endCommandBuffer = true,
});

pub var vki: InstanceDispatch = undefined;
pub var vkd: DeviceDispatch = undefined;

const max_sync = 8;

// the state contains everything needed for rendering and deinitialization
index: u32 = 0,
swapchain_mask: u32,
vbo: Buffer,
ubo: [max_sync]Buffer,

mem_props: vk.PhysicalDeviceMemoryProperties,

desc_set: [max_sync]vk.DescriptorSet,

render_pass: vk.RenderPass,
pipeline_layout: vk.PipelineLayout,
pipeline: vk.Pipeline,

images: [max_sync]Image,
image_memory: [max_sync]vk.DeviceMemory,
framebuffers: [max_sync]vk.Framebuffer,
cmd_pool: [max_sync]vk.CommandPool,
cmd: [max_sync]vk.CommandBuffer,

// TODO: did i fuck this up?
fn findMemoryTypeFromRequirements(
    mem_props: *const vk.PhysicalDeviceMemoryProperties,
    device_requirements: vk.MemoryPropertyFlags,
    host_requirements: vk.MemoryPropertyFlags,
) u32 {
    for (0..vk.MAX_MEMORY_TYPES) |i|
        if (device_requirements.intersect(vk.MemoryPropertyFlags.fromInt(@as(u32, @intCast(i)) << @intCast(i))).toInt() > 1)
            if (mem_props.memory_types[i].property_flags.intersect(host_requirements).toInt() == host_requirements.toInt())
                return @intCast(i);
    return 0;
}

const Image = extern struct {
    image_view: vk.ImageView,
    image_layout: vk.ImageLayout,
    create_info: vk.ImageViewCreateInfo,
};

const Buffer = struct {
    buffer: vk.Buffer,
    memory: vk.DeviceMemory,

    fn create(
        device: vk.Device,
        initial: ?[*]const u8,
        size: usize,
        usage: vk.BufferUsageFlags,
        mem_props: *const vk.PhysicalDeviceMemoryProperties,
    ) !@This() {
        const buffer = try vkd.createBuffer(device, &.{
            .size = size,
            .usage = usage,
            .sharing_mode = .exclusive,
        }, null);
        const mem_reqs = vkd.getBufferMemoryRequirements(device, buffer);
        const memory = try vkd.allocateMemory(device, &.{
            .allocation_size = mem_reqs.size,
            // TODO: did i fuck this up?
            .memory_type_index = findMemoryTypeFromRequirements(
                mem_props,
                @bitCast(mem_reqs.memory_type_bits),
                .{ .host_visible_bit = true, .host_coherent_bit = true },
            ),
        }, null);
        try vkd.bindBufferMemory(device, buffer, memory, 0);

        if (initial) |src| {
            const ptr: [*]u8 = @ptrCast(try vkd.mapMemory(device, memory, 0, size, .{}));
            @memcpy(ptr[0..size], src);
            vkd.unmapMemory(device, memory);
        }

        return .{ .buffer = buffer, .memory = memory };
    }
};

// spinny!
fn updateUniformBuffer(device: vk.Device, ubo: *const Buffer) !void {
    // TODO: make this use SIMD with @Vector
    var frame: usize = 0;
    const c = @cos(@as(f32, @floatFromInt(frame)) * 0.01);
    const s = @sin(@as(f32, @floatFromInt(frame)) * 0.01);
    frame += 1;

    const len = 16;
    var tmp = [_]f32{0} ** len;
    tmp[0] = c;
    tmp[1] = s;
    tmp[4] = -s;
    tmp[5] = c;
    tmp[10] = 1;
    tmp[15] = 1;

    const memory = ubo.memory;
    const mvp: [*]f32 = @ptrCast(@alignCast(try vkd.mapMemory(device, memory, 0, @sizeOf(f32) * len, .{})));
    @memcpy(mvp[0..len], &tmp);
    vkd.unmapMemory(device, memory);
}

pub fn init(device: vk.Device, gpu: vk.PhysicalDevice, sync_index_mask: u32, queue_index: u32) !@This() {
    //const gpu_props = vki.getPhysicalDeviceProperties(gpu);
    const mem_props = vki.getPhysicalDeviceMemoryProperties(gpu);

    var num_swapchain_images: u32 = 0;
    for (0..32) |i| if ((sync_index_mask & @as(u32, 1) << @intCast(i)) > 0) {
        num_swapchain_images = @as(u32, @intCast(i)) + 1;
    };
    const vbo = try Buffer.create(
        device,
        @ptrCast(&vertex_data),
        vertex_data.len,
        .{ .vertex_buffer_bit = true },
        &mem_props,
    );
    var ubo: [max_sync]Buffer = undefined;
    for (0..num_swapchain_images) |i| ubo[i] = try Buffer.create(
        device,
        null,
        @sizeOf(f32) * 16,
        .{ .uniform_buffer_bit = true },
        &mem_props,
    );

    var cmd_pool: [max_sync]vk.CommandPool = undefined;
    var cmd: [max_sync]vk.CommandBuffer = undefined;
    try initCommand(device, queue_index, num_swapchain_images, &cmd_pool, &cmd);
    var desc_set: [max_sync]vk.DescriptorSet = undefined;
    const layouts = try initDescriptor(device, num_swapchain_images, @ptrCast(&desc_set), &ubo);
    const render_pass = try initRenderPass(device, .r8g8b8a8_unorm);
    const pipeline_layout = layouts.pipeline_layout;
    const pipeline_cache = try vkd.createPipelineCache(device, &.{}, null);
    const pipeline = try initPipeline(device, render_pass, pipeline_layout, pipeline_cache);
    var images: [max_sync]Image = undefined;
    var image_memory: [max_sync]vk.DeviceMemory = undefined;
    var framebuffers: [max_sync]vk.Framebuffer = undefined;
    try initSwapchain(
        device,
        num_swapchain_images,
        &mem_props,
        &images,
        &image_memory,
        &framebuffers,
        render_pass,
    );
    return .{
        .vbo = vbo,
        .ubo = ubo,
        .swapchain_mask = sync_index_mask,
        .mem_props = mem_props,
        .desc_set = desc_set,
        .render_pass = render_pass,
        .pipeline_layout = pipeline_layout,
        .pipeline = pipeline,
        .images = images,
        .image_memory = image_memory,
        .framebuffers = framebuffers,
        .cmd_pool = cmd_pool,
        .cmd = cmd,
    };
}

pub fn deinit(ctx: @This(), device: vk.Device) void {
    vkd.destroyRenderPass(device, ctx.render_pass, null);
    vkd.destroyPipeline(device, ctx.pipeline, null);
    vkd.destroyPipelineLayout(device, ctx.pipeline_layout, null);
    // TODO: we should definitely deinitialize everything
}

pub fn render(ctx: @This(), device: vk.Device) !void {
    try updateUniformBuffer(device, &ctx.ubo[ctx.index]);
    const cmd = ctx.cmd[ctx.index];
    const image = ctx.images[ctx.index].create_info.image;

    try vkd.resetCommandBuffer(cmd, .{});
    try vkd.beginCommandBuffer(cmd, &.{ .flags = .{ .one_time_submit_bit = true } });

    vkd.cmdPipelineBarrier(cmd, .{
        .top_of_pipe_bit = true,
    }, .{
        .color_attachment_output_bit = true,
    }, .{}, 0, undefined, 0, undefined, 1, @ptrCast(&vk.ImageMemoryBarrier{
        .src_access_mask = .{},
        .dst_access_mask = .{ .color_attachment_write_bit = true, .color_attachment_read_bit = true },
        .old_layout = .undefined,
        .new_layout = .color_attachment_optimal,
        .src_queue_family_index = vk.QUEUE_FAMILY_IGNORED,
        .dst_queue_family_index = vk.QUEUE_FAMILY_IGNORED,
        .image = image,
        .subresource_range = .{
            .aspect_mask = .{ .color_bit = true },
            .base_mip_level = 0,
            .level_count = 1,
            .base_array_layer = 0,
            .layer_count = 1,
        },
    }));
    const clear_value = vk.ClearValue{
        .color = .{ .float_32 = [4]f32{ 0.8, 0.6, 0.2, 1 } },
    };
    vkd.cmdBeginRenderPass(cmd, @ptrCast(&vk.RenderPassBeginInfo{
        .render_pass = ctx.render_pass,
        .framebuffer = ctx.framebuffers[ctx.index],
        .render_area = .{ .offset = .{ .x = 0, .y = 0 }, .extent = .{ .width = width, .height = height } },
        .clear_value_count = 1,
        .p_clear_values = @ptrCast(&clear_value),
    }), .@"inline");
    vkd.cmdBindPipeline(cmd, .graphics, ctx.pipeline);
    vkd.cmdBindDescriptorSets(cmd, .graphics, ctx.pipeline_layout, 0, 1, @ptrCast(&ctx.desc_set[ctx.index]), 0, undefined);
    vkd.cmdSetViewport(cmd, 0, 1, @ptrCast(&vk.Viewport{ .x = 0, .y = 0, .width = width, .height = height, .min_depth = 0, .max_depth = 1 }));
    vkd.cmdSetScissor(cmd, 0, 1, @ptrCast(&vk.Rect2D{ .offset = .{ .x = 0, .y = 0 }, .extent = .{ .width = width, .height = height } }));
    vkd.cmdBindVertexBuffers(cmd, 0, 1, @ptrCast(&ctx.vbo.buffer), &[_]u64{0});
    vkd.cmdDraw(cmd, num_vertices, 1, 0, 0);
    vkd.cmdEndRenderPass(cmd);
    vkd.cmdPipelineBarrier(
        cmd,
        .{ .all_graphics_bit = true },
        .{ .fragment_shader_bit = true },
        .{},
        0,
        &[_]vk.MemoryBarrier{},
        0,
        &[_]vk.BufferMemoryBarrier{},
        1,
        @ptrCast(&vk.ImageMemoryBarrier{
            .src_access_mask = .{ .color_attachment_write_bit = true },
            .dst_access_mask = .{ .shader_read_bit = true },
            .old_layout = .color_attachment_optimal,
            .new_layout = .shader_read_only_optimal,
            .src_queue_family_index = vk.QUEUE_FAMILY_IGNORED,
            .dst_queue_family_index = vk.QUEUE_FAMILY_IGNORED,
            .image = image,
            .subresource_range = .{
                .aspect_mask = .{ .color_bit = true },
                .base_mip_level = 0,
                .level_count = 1,
                .base_array_layer = 0,
                .layer_count = 1,
            },
        }),
    );
    try vkd.endCommandBuffer(cmd);
}

const num_vertices = 3;
// TODO: fix the formatting here
const vertex_data = [(4 * 2) * num_vertices]f32{
    // vec4 position  vec4 color
    -0.5, -0.5, 0, 1, 1, 0, 0, 1,
    -0.5, 0.5,  0, 1, 0, 1, 0, 1,
    0.5,  -0.5, 0, 1, 0, 0, 1, 1,
};

fn initCommand(device: vk.Device, queue_index: u32, num_swapchain_images: u32, cmd_pool: [*]vk.CommandPool, cmd: [*]vk.CommandBuffer) !void {
    const pool_info = vk.CommandPoolCreateInfo{
        .queue_family_index = queue_index,
        .flags = .{ .reset_command_buffer_bit = true },
    };

    for (0..num_swapchain_images) |i| {
        cmd_pool[i] = try vkd.createCommandPool(device, &pool_info, null);
        const info = vk.CommandBufferAllocateInfo{
            .command_pool = cmd_pool[i],
            .level = .primary,
            .command_buffer_count = 1,
        };
        try vkd.allocateCommandBuffers(device, &info, @ptrCast(&cmd[i]));
    }
}

fn initRenderPass(device: vk.Device, format: vk.Format) !vk.RenderPass {
    const attachment = vk.AttachmentDescription{
        .format = format,
        .samples = .{ .@"1_bit" = true },
        .load_op = .clear,
        .store_op = .store,
        .stencil_load_op = .dont_care,
        .stencil_store_op = .dont_care,
        .initial_layout = .color_attachment_optimal,
        .final_layout = .color_attachment_optimal,
    };
    const color_ref = vk.AttachmentReference{
        .attachment = 0,
        .layout = .color_attachment_optimal,
    };
    const subpass = vk.SubpassDescription{
        .pipeline_bind_point = .graphics,
        .color_attachment_count = 1,
        .p_color_attachments = @ptrCast(&color_ref),
    };
    const info = vk.RenderPassCreateInfo{
        .attachment_count = 1,
        .p_attachments = @ptrCast(&attachment),
        .subpass_count = 1,
        .p_subpasses = @ptrCast(&subpass),
    };
    return vkd.createRenderPass(device, @ptrCast(&info), null);
}

fn initSwapchain(
    device: vk.Device,
    num_swapchain_images: u32,
    mem_props: *const vk.PhysicalDeviceMemoryProperties,
    images: [*]Image,
    image_memory: [*]vk.DeviceMemory,
    framebuffers: [*]vk.Framebuffer,
    render_pass: vk.RenderPass,
) !void {
    for (0..num_swapchain_images) |i| {
        const image = try vkd.createImage(device, &.{
            .image_type = .@"2d",
            .flags = .{ .mutable_format_bit = true },
            .format = .r8g8b8a8_unorm, // TODO: try different formats for funsies
            .extent = .{ .width = width, .height = height, .depth = 1 },
            .samples = .{ .@"1_bit" = true },
            .tiling = .optimal,
            .usage = .{ .color_attachment_bit = true, .sampled_bit = true, .transfer_src_bit = true },
            .sharing_mode = .exclusive,
            .initial_layout = .undefined,
            .mip_levels = 1,
            .array_layers = 1,
        }, null); // TODO: write image to ctx.images[i].create_info.image !!!
        const mem_reqs = vkd.getImageMemoryRequirements(device, image);
        image_memory[i] = try vkd.allocateMemory(device, &.{
            .allocation_size = mem_reqs.size,
            .memory_type_index = findMemoryTypeFromRequirements(
                mem_props,
                @bitCast(mem_reqs.memory_type_bits),
                .{ .device_local_bit = true },
            ),
        }, null);
        try vkd.bindImageMemory(device, image, image_memory[i], 0);

        const create_info = vk.ImageViewCreateInfo{
            .view_type = .@"2d",
            .format = .r8g8b8a8_unorm,
            .subresource_range = .{
                .base_mip_level = 0,
                .level_count = 1,
                .base_array_layer = 0,
                .layer_count = 1,
                .aspect_mask = .{ .color_bit = true },
            },
            .image = image,
            .components = .{ .r = .r, .g = .g, .b = .b, .a = .a },
        };
        const image_view = try vkd.createImageView(device, &create_info, null);

        images[i] = .{
            .create_info = create_info,
            .image_layout = .shader_read_only_optimal,
            .image_view = image_view,
        };

        framebuffers[i] = try vkd.createFramebuffer(device, &.{
            .render_pass = render_pass,
            .attachment_count = 1,
            .p_attachments = &[_]vk.ImageView{image_view},
            .width = width,
            .height = height,
            .layers = 1,
        }, null);
    }
}

fn initDescriptor(
    device: vk.Device,
    num_swapchain_images: u32,
    desc_set: [*]vk.DescriptorSet,
    ubo: [*]const Buffer,
) !struct {
    set_layout: vk.DescriptorSetLayout,
    pipeline_layout: vk.PipelineLayout,
} {
    const binding = vk.DescriptorSetLayoutBinding{
        .binding = 0,
        .descriptor_type = .uniform_buffer,
        .descriptor_count = 1,
        .stage_flags = .{ .vertex_bit = true },
        .p_immutable_samplers = null,
    };
    const pool_sizes = [_]vk.DescriptorPoolSize{.{
        .type = .uniform_buffer,
        .descriptor_count = num_swapchain_images,
    }};
    const set_layout_info = vk.DescriptorSetLayoutCreateInfo{
        .binding_count = 1,
        .p_bindings = @ptrCast(&binding),
    };
    const set_layout = try vkd.createDescriptorSetLayout(device, @ptrCast(&set_layout_info), null);
    const layout_info = vk.PipelineLayoutCreateInfo{
        .set_layout_count = 1,
        .p_set_layouts = @ptrCast(&set_layout),
    };
    const pipeline_layout = try vkd.createPipelineLayout(device, @ptrCast(&layout_info), null);
    const desc_pool = try vkd.createDescriptorPool(device, &.{
        .max_sets = num_swapchain_images,
        .pool_size_count = 1,
        .p_pool_sizes = &pool_sizes,
        .flags = .{ .free_descriptor_set_bit = true },
    }, null);
    const alloc_info = vk.DescriptorSetAllocateInfo{
        .descriptor_pool = desc_pool,
        .descriptor_set_count = 1,
        .p_set_layouts = @ptrCast(&set_layout),
    };

    for (0..num_swapchain_images) |i| {
        try vkd.allocateDescriptorSets(device, &alloc_info, @ptrCast(&desc_set[i]));
        const buffer_info = vk.DescriptorBufferInfo{
            .buffer = ubo[i].buffer,
            .offset = 0,
            .range = @sizeOf(f32) * 16,
        };
        const write = vk.WriteDescriptorSet{
            .dst_set = desc_set[i],
            .dst_binding = 0,
            .dst_array_element = 0,
            .descriptor_count = 1,
            .descriptor_type = .uniform_buffer,
            .p_image_info = undefined, // should be fine as this isn't accessed
            .p_buffer_info = @ptrCast(&buffer_info),
            .p_texel_buffer_view = undefined, // same here
        };
        vkd.updateDescriptorSets(device, 1, @ptrCast(&write), 0, undefined);
    }

    return .{ .set_layout = set_layout, .pipeline_layout = pipeline_layout };
}

fn initPipeline(
    device: vk.Device,
    render_pass: vk.RenderPass,
    pipeline_layout: vk.PipelineLayout,
    pipeline_cache: vk.PipelineCache,
) !vk.Pipeline {
    const input_assembly = vk.PipelineInputAssemblyStateCreateInfo{
        .topology = .triangle_list,
        .primitive_restart_enable = vk.FALSE,
    };
    const attributes = [_]vk.VertexInputAttributeDescription{ .{
        .location = 0,
        .binding = 0,
        .format = .r32g32b32a32_sfloat,
        .offset = 0,
    }, .{
        .location = 1,
        .binding = 0,
        .format = .r32g32b32a32_sfloat,
        .offset = @sizeOf(f32) * 4,
    } };
    const binding = vk.VertexInputBindingDescription{
        .binding = 0,
        .stride = @sizeOf(f32) * 8,
        .input_rate = .vertex,
    };
    const vertex_input = vk.PipelineVertexInputStateCreateInfo{
        .vertex_binding_description_count = 1,
        .p_vertex_binding_descriptions = @ptrCast(&binding),
        .vertex_attribute_description_count = 2,
        .p_vertex_attribute_descriptions = &attributes,
    };
    const raster = vk.PipelineRasterizationStateCreateInfo{
        .polygon_mode = .fill,
        .cull_mode = .{ .back_bit = true },
        .front_face = .counter_clockwise,
        .depth_clamp_enable = vk.FALSE,
        .rasterizer_discard_enable = vk.FALSE,
        .depth_bias_enable = vk.FALSE,
        .depth_bias_constant_factor = 0,
        .depth_bias_clamp = 0,
        .depth_bias_slope_factor = 0,
        .line_width = 1,
    };
    const blend_attachment = vk.PipelineColorBlendAttachmentState{
        .blend_enable = vk.FALSE,
        .src_color_blend_factor = .zero,
        .dst_color_blend_factor = .zero,
        .color_blend_op = .add,
        .src_alpha_blend_factor = .zero,
        .dst_alpha_blend_factor = .zero,
        .alpha_blend_op = .add,
        .color_write_mask = @bitCast(@as(u32, 0b1111)),
    };
    const blend = vk.PipelineColorBlendStateCreateInfo{
        .logic_op_enable = vk.FALSE,
        .logic_op = .clear,
        .attachment_count = 1,
        .p_attachments = @ptrCast(&blend_attachment),
        .blend_constants = .{ 0, 0, 0, 0 },
    };
    const viewport = vk.PipelineViewportStateCreateInfo{
        .viewport_count = 1,
        .scissor_count = 1,
    };
    const depth_stencil = std.mem.zeroes(vk.PipelineDepthStencilStateCreateInfo);
    const multisample = vk.PipelineMultisampleStateCreateInfo{
        .rasterization_samples = .{ .@"1_bit" = true },
        .sample_shading_enable = vk.FALSE,
        .min_sample_shading = 0,
        .alpha_to_coverage_enable = vk.FALSE,
        .alpha_to_one_enable = vk.FALSE,
    };
    const dynamics = [_]vk.DynamicState{ .viewport, .scissor };
    const dynamic = vk.PipelineDynamicStateCreateInfo{
        .p_dynamic_states = &dynamics,
        .dynamic_state_count = dynamics.len,
    };

    const shaders = @import("shaders");

    const vert = try vkd.createShaderModule(device, &.{
        .code_size = shaders.vert.len,
        .p_code = @ptrCast(&shaders.vert),
    }, null);
    const frag = try vkd.createShaderModule(device, &.{
        .code_size = shaders.frag.len,
        .p_code = @ptrCast(&shaders.frag),
    }, null);

    const shader_stages = [_]vk.PipelineShaderStageCreateInfo{ .{
        .stage = .{ .vertex_bit = true },
        .module = vert,
        .p_name = "main",
    }, .{
        .stage = .{ .fragment_bit = true },
        .module = frag,
        .p_name = "main",
    } };

    const info = vk.GraphicsPipelineCreateInfo{
        .stage_count = 2,
        .p_stages = &shader_stages,
        .p_vertex_input_state = &vertex_input,
        .p_input_assembly_state = &input_assembly,
        .p_rasterization_state = &raster,
        .p_color_blend_state = &blend,
        .p_multisample_state = &multisample,
        .p_viewport_state = &viewport,
        .p_depth_stencil_state = &depth_stencil,
        .p_dynamic_state = &dynamic,
        .render_pass = render_pass,
        .layout = pipeline_layout,
        .subpass = 0,
        .base_pipeline_index = 0,
    };
    var pipeline: vk.Pipeline = undefined;
    _ = try vkd.createGraphicsPipelines(device, pipeline_cache, 1, @ptrCast(&info), null, @ptrCast(&pipeline));

    return pipeline;
}
