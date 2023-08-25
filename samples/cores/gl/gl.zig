// NOTICE
//
// This work uses definitions from the OpenGL XML API Registry
// <https://github.com/KhronosGroup/OpenGL-Registry>.
// Copyright 2013-2020 The Khronos Group Inc.
// Licensed under Apache-2.0.
//
// END OF NOTICE

const std = @import("std");
const root = @import("root");

/// Static information about this source file and when/how it was generated.
pub const about = struct {
    pub const api_name = "OpenGL 3.1";
    pub const api_version_major = 3;
    pub const api_version_minor = 1;

    pub const generated_at = "2023-08-06T16:37:07Z";

    pub const generator_name = "zigglgen v0.4.1";
    pub const generator_url = "https://castholm.github.io/zigglgen/";
};

/// Makes the specified dispatch table current on the calling thread. This function must be called
/// with a valid dispatch table before calling `extensionSupported()` or any OpenGL command
/// functions on that same thread.
pub fn makeDispatchTableCurrent(dispatch_table: ?*const DispatchTable) void {
    DispatchTable.current = dispatch_table;
}

/// Returns the dispatch table that is current on the calling thread, or `null` if no dispatch table
/// is current.
pub fn getCurrentDispatchTable() ?*const DispatchTable {
    return DispatchTable.current;
}

//#region Types
pub const Byte = i8;
pub const Ubyte = u8;
pub const Short = c_short;
pub const Ushort = c_ushort;
pub const Int = c_int;
pub const Uint = c_uint;
pub const Intptr = isize;
pub const Half = c_ushort;
pub const Float = f32;
pub const Double = f64;
pub const Boolean = u8;
pub const Char = u8;
pub const Bitfield = c_uint;
pub const Enum = c_uint;
pub const Sizei = c_int;
pub const Sizeiptr = isize;
pub const Clampf = f32;
pub const Clampd = f64;
//#endregion Types

//#region Constants
pub const ZERO = 0x0;
pub const ONE = 0x1;
pub const FALSE = 0x0;
pub const TRUE = 0x1;
pub const NONE = 0x0;
pub const NO_ERROR = 0x0;
pub const INVALID_INDEX = 0xFFFFFFFF;
pub const CURRENT_BIT = 0x1;
pub const POINT_BIT = 0x2;
pub const LINE_BIT = 0x4;
pub const POLYGON_BIT = 0x8;
pub const POLYGON_STIPPLE_BIT = 0x10;
pub const PIXEL_MODE_BIT = 0x20;
pub const LIGHTING_BIT = 0x40;
pub const FOG_BIT = 0x80;
pub const DEPTH_BUFFER_BIT = 0x100;
pub const ACCUM_BUFFER_BIT = 0x200;
pub const STENCIL_BUFFER_BIT = 0x400;
pub const VIEWPORT_BIT = 0x800;
pub const TRANSFORM_BIT = 0x1000;
pub const ENABLE_BIT = 0x2000;
pub const COLOR_BUFFER_BIT = 0x4000;
pub const HINT_BIT = 0x8000;
pub const EVAL_BIT = 0x10000;
pub const LIST_BIT = 0x20000;
pub const TEXTURE_BIT = 0x40000;
pub const SCISSOR_BIT = 0x80000;
pub const MULTISAMPLE_BIT = 0x20000000;
pub const ALL_ATTRIB_BITS = 0xFFFFFFFF;
pub const CLIENT_PIXEL_STORE_BIT = 0x1;
pub const CLIENT_VERTEX_ARRAY_BIT = 0x2;
pub const CLIENT_ALL_ATTRIB_BITS = 0xFFFFFFFF;
pub const CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = 0x1;
pub const MAP_READ_BIT = 0x1;
pub const MAP_WRITE_BIT = 0x2;
pub const MAP_INVALIDATE_RANGE_BIT = 0x4;
pub const MAP_INVALIDATE_BUFFER_BIT = 0x8;
pub const MAP_FLUSH_EXPLICIT_BIT = 0x10;
pub const MAP_UNSYNCHRONIZED_BIT = 0x20;
pub const POINTS = 0x0;
pub const LINES = 0x1;
pub const LINE_LOOP = 0x2;
pub const LINE_STRIP = 0x3;
pub const TRIANGLES = 0x4;
pub const TRIANGLE_STRIP = 0x5;
pub const TRIANGLE_FAN = 0x6;
pub const QUADS = 0x7;
pub const QUAD_STRIP = 0x8;
pub const POLYGON = 0x9;
pub const ACCUM = 0x100;
pub const LOAD = 0x101;
pub const RETURN = 0x102;
pub const MULT = 0x103;
pub const ADD = 0x104;
pub const NEVER = 0x200;
pub const LESS = 0x201;
pub const EQUAL = 0x202;
pub const LEQUAL = 0x203;
pub const GREATER = 0x204;
pub const NOTEQUAL = 0x205;
pub const GEQUAL = 0x206;
pub const ALWAYS = 0x207;
pub const SRC_COLOR = 0x300;
pub const ONE_MINUS_SRC_COLOR = 0x301;
pub const SRC_ALPHA = 0x302;
pub const ONE_MINUS_SRC_ALPHA = 0x303;
pub const DST_ALPHA = 0x304;
pub const ONE_MINUS_DST_ALPHA = 0x305;
pub const DST_COLOR = 0x306;
pub const ONE_MINUS_DST_COLOR = 0x307;
pub const SRC_ALPHA_SATURATE = 0x308;
pub const FRONT_LEFT = 0x400;
pub const FRONT_RIGHT = 0x401;
pub const BACK_LEFT = 0x402;
pub const BACK_RIGHT = 0x403;
pub const FRONT = 0x404;
pub const BACK = 0x405;
pub const LEFT = 0x406;
pub const RIGHT = 0x407;
pub const FRONT_AND_BACK = 0x408;
pub const AUX0 = 0x409;
pub const AUX1 = 0x40A;
pub const AUX2 = 0x40B;
pub const AUX3 = 0x40C;
pub const INVALID_ENUM = 0x500;
pub const INVALID_VALUE = 0x501;
pub const INVALID_OPERATION = 0x502;
pub const STACK_OVERFLOW = 0x503;
pub const STACK_UNDERFLOW = 0x504;
pub const OUT_OF_MEMORY = 0x505;
pub const INVALID_FRAMEBUFFER_OPERATION = 0x506;
pub const @"2D" = 0x600;
pub const @"3D" = 0x601;
pub const @"3D_COLOR" = 0x602;
pub const @"3D_COLOR_TEXTURE" = 0x603;
pub const @"4D_COLOR_TEXTURE" = 0x604;
pub const PASS_THROUGH_TOKEN = 0x700;
pub const POINT_TOKEN = 0x701;
pub const LINE_TOKEN = 0x702;
pub const POLYGON_TOKEN = 0x703;
pub const BITMAP_TOKEN = 0x704;
pub const DRAW_PIXEL_TOKEN = 0x705;
pub const COPY_PIXEL_TOKEN = 0x706;
pub const LINE_RESET_TOKEN = 0x707;
pub const EXP = 0x800;
pub const EXP2 = 0x801;
pub const CW = 0x900;
pub const CCW = 0x901;
pub const COEFF = 0xA00;
pub const ORDER = 0xA01;
pub const DOMAIN = 0xA02;
pub const CURRENT_COLOR = 0xB00;
pub const CURRENT_INDEX = 0xB01;
pub const CURRENT_NORMAL = 0xB02;
pub const CURRENT_TEXTURE_COORDS = 0xB03;
pub const CURRENT_RASTER_COLOR = 0xB04;
pub const CURRENT_RASTER_INDEX = 0xB05;
pub const CURRENT_RASTER_TEXTURE_COORDS = 0xB06;
pub const CURRENT_RASTER_POSITION = 0xB07;
pub const CURRENT_RASTER_POSITION_VALID = 0xB08;
pub const CURRENT_RASTER_DISTANCE = 0xB09;
pub const POINT_SMOOTH = 0xB10;
pub const POINT_SIZE = 0xB11;
pub const POINT_SIZE_RANGE = 0xB12;
pub const SMOOTH_POINT_SIZE_RANGE = 0xB12;
pub const POINT_SIZE_GRANULARITY = 0xB13;
pub const SMOOTH_POINT_SIZE_GRANULARITY = 0xB13;
pub const LINE_SMOOTH = 0xB20;
pub const LINE_WIDTH = 0xB21;
pub const LINE_WIDTH_RANGE = 0xB22;
pub const SMOOTH_LINE_WIDTH_RANGE = 0xB22;
pub const LINE_WIDTH_GRANULARITY = 0xB23;
pub const SMOOTH_LINE_WIDTH_GRANULARITY = 0xB23;
pub const LINE_STIPPLE = 0xB24;
pub const LINE_STIPPLE_PATTERN = 0xB25;
pub const LINE_STIPPLE_REPEAT = 0xB26;
pub const LIST_MODE = 0xB30;
pub const MAX_LIST_NESTING = 0xB31;
pub const LIST_BASE = 0xB32;
pub const LIST_INDEX = 0xB33;
pub const POLYGON_MODE = 0xB40;
pub const POLYGON_SMOOTH = 0xB41;
pub const POLYGON_STIPPLE = 0xB42;
pub const EDGE_FLAG = 0xB43;
pub const CULL_FACE = 0xB44;
pub const CULL_FACE_MODE = 0xB45;
pub const FRONT_FACE = 0xB46;
pub const LIGHTING = 0xB50;
pub const LIGHT_MODEL_LOCAL_VIEWER = 0xB51;
pub const LIGHT_MODEL_TWO_SIDE = 0xB52;
pub const LIGHT_MODEL_AMBIENT = 0xB53;
pub const SHADE_MODEL = 0xB54;
pub const COLOR_MATERIAL_FACE = 0xB55;
pub const COLOR_MATERIAL_PARAMETER = 0xB56;
pub const COLOR_MATERIAL = 0xB57;
pub const FOG = 0xB60;
pub const FOG_INDEX = 0xB61;
pub const FOG_DENSITY = 0xB62;
pub const FOG_START = 0xB63;
pub const FOG_END = 0xB64;
pub const FOG_MODE = 0xB65;
pub const FOG_COLOR = 0xB66;
pub const DEPTH_RANGE = 0xB70;
pub const DEPTH_TEST = 0xB71;
pub const DEPTH_WRITEMASK = 0xB72;
pub const DEPTH_CLEAR_VALUE = 0xB73;
pub const DEPTH_FUNC = 0xB74;
pub const ACCUM_CLEAR_VALUE = 0xB80;
pub const STENCIL_TEST = 0xB90;
pub const STENCIL_CLEAR_VALUE = 0xB91;
pub const STENCIL_FUNC = 0xB92;
pub const STENCIL_VALUE_MASK = 0xB93;
pub const STENCIL_FAIL = 0xB94;
pub const STENCIL_PASS_DEPTH_FAIL = 0xB95;
pub const STENCIL_PASS_DEPTH_PASS = 0xB96;
pub const STENCIL_REF = 0xB97;
pub const STENCIL_WRITEMASK = 0xB98;
pub const MATRIX_MODE = 0xBA0;
pub const NORMALIZE = 0xBA1;
pub const VIEWPORT = 0xBA2;
pub const MODELVIEW_STACK_DEPTH = 0xBA3;
pub const PROJECTION_STACK_DEPTH = 0xBA4;
pub const TEXTURE_STACK_DEPTH = 0xBA5;
pub const MODELVIEW_MATRIX = 0xBA6;
pub const PROJECTION_MATRIX = 0xBA7;
pub const TEXTURE_MATRIX = 0xBA8;
pub const ATTRIB_STACK_DEPTH = 0xBB0;
pub const CLIENT_ATTRIB_STACK_DEPTH = 0xBB1;
pub const ALPHA_TEST = 0xBC0;
pub const ALPHA_TEST_FUNC = 0xBC1;
pub const ALPHA_TEST_REF = 0xBC2;
pub const DITHER = 0xBD0;
pub const BLEND_DST = 0xBE0;
pub const BLEND_SRC = 0xBE1;
pub const BLEND = 0xBE2;
pub const LOGIC_OP_MODE = 0xBF0;
pub const INDEX_LOGIC_OP = 0xBF1;
pub const LOGIC_OP = 0xBF1;
pub const COLOR_LOGIC_OP = 0xBF2;
pub const AUX_BUFFERS = 0xC00;
pub const DRAW_BUFFER = 0xC01;
pub const READ_BUFFER = 0xC02;
pub const SCISSOR_BOX = 0xC10;
pub const SCISSOR_TEST = 0xC11;
pub const INDEX_CLEAR_VALUE = 0xC20;
pub const INDEX_WRITEMASK = 0xC21;
pub const COLOR_CLEAR_VALUE = 0xC22;
pub const COLOR_WRITEMASK = 0xC23;
pub const INDEX_MODE = 0xC30;
pub const RGBA_MODE = 0xC31;
pub const DOUBLEBUFFER = 0xC32;
pub const STEREO = 0xC33;
pub const RENDER_MODE = 0xC40;
pub const PERSPECTIVE_CORRECTION_HINT = 0xC50;
pub const POINT_SMOOTH_HINT = 0xC51;
pub const LINE_SMOOTH_HINT = 0xC52;
pub const POLYGON_SMOOTH_HINT = 0xC53;
pub const FOG_HINT = 0xC54;
pub const TEXTURE_GEN_S = 0xC60;
pub const TEXTURE_GEN_T = 0xC61;
pub const TEXTURE_GEN_R = 0xC62;
pub const TEXTURE_GEN_Q = 0xC63;
pub const PIXEL_MAP_I_TO_I = 0xC70;
pub const PIXEL_MAP_S_TO_S = 0xC71;
pub const PIXEL_MAP_I_TO_R = 0xC72;
pub const PIXEL_MAP_I_TO_G = 0xC73;
pub const PIXEL_MAP_I_TO_B = 0xC74;
pub const PIXEL_MAP_I_TO_A = 0xC75;
pub const PIXEL_MAP_R_TO_R = 0xC76;
pub const PIXEL_MAP_G_TO_G = 0xC77;
pub const PIXEL_MAP_B_TO_B = 0xC78;
pub const PIXEL_MAP_A_TO_A = 0xC79;
pub const PIXEL_MAP_I_TO_I_SIZE = 0xCB0;
pub const PIXEL_MAP_S_TO_S_SIZE = 0xCB1;
pub const PIXEL_MAP_I_TO_R_SIZE = 0xCB2;
pub const PIXEL_MAP_I_TO_G_SIZE = 0xCB3;
pub const PIXEL_MAP_I_TO_B_SIZE = 0xCB4;
pub const PIXEL_MAP_I_TO_A_SIZE = 0xCB5;
pub const PIXEL_MAP_R_TO_R_SIZE = 0xCB6;
pub const PIXEL_MAP_G_TO_G_SIZE = 0xCB7;
pub const PIXEL_MAP_B_TO_B_SIZE = 0xCB8;
pub const PIXEL_MAP_A_TO_A_SIZE = 0xCB9;
pub const UNPACK_SWAP_BYTES = 0xCF0;
pub const UNPACK_LSB_FIRST = 0xCF1;
pub const UNPACK_ROW_LENGTH = 0xCF2;
pub const UNPACK_SKIP_ROWS = 0xCF3;
pub const UNPACK_SKIP_PIXELS = 0xCF4;
pub const UNPACK_ALIGNMENT = 0xCF5;
pub const PACK_SWAP_BYTES = 0xD00;
pub const PACK_LSB_FIRST = 0xD01;
pub const PACK_ROW_LENGTH = 0xD02;
pub const PACK_SKIP_ROWS = 0xD03;
pub const PACK_SKIP_PIXELS = 0xD04;
pub const PACK_ALIGNMENT = 0xD05;
pub const MAP_COLOR = 0xD10;
pub const MAP_STENCIL = 0xD11;
pub const INDEX_SHIFT = 0xD12;
pub const INDEX_OFFSET = 0xD13;
pub const RED_SCALE = 0xD14;
pub const RED_BIAS = 0xD15;
pub const ZOOM_X = 0xD16;
pub const ZOOM_Y = 0xD17;
pub const GREEN_SCALE = 0xD18;
pub const GREEN_BIAS = 0xD19;
pub const BLUE_SCALE = 0xD1A;
pub const BLUE_BIAS = 0xD1B;
pub const ALPHA_SCALE = 0xD1C;
pub const ALPHA_BIAS = 0xD1D;
pub const DEPTH_SCALE = 0xD1E;
pub const DEPTH_BIAS = 0xD1F;
pub const MAX_EVAL_ORDER = 0xD30;
pub const MAX_LIGHTS = 0xD31;
pub const MAX_CLIP_DISTANCES = 0xD32;
pub const MAX_CLIP_PLANES = 0xD32;
pub const MAX_TEXTURE_SIZE = 0xD33;
pub const MAX_PIXEL_MAP_TABLE = 0xD34;
pub const MAX_ATTRIB_STACK_DEPTH = 0xD35;
pub const MAX_MODELVIEW_STACK_DEPTH = 0xD36;
pub const MAX_NAME_STACK_DEPTH = 0xD37;
pub const MAX_PROJECTION_STACK_DEPTH = 0xD38;
pub const MAX_TEXTURE_STACK_DEPTH = 0xD39;
pub const MAX_VIEWPORT_DIMS = 0xD3A;
pub const MAX_CLIENT_ATTRIB_STACK_DEPTH = 0xD3B;
pub const SUBPIXEL_BITS = 0xD50;
pub const INDEX_BITS = 0xD51;
pub const RED_BITS = 0xD52;
pub const GREEN_BITS = 0xD53;
pub const BLUE_BITS = 0xD54;
pub const ALPHA_BITS = 0xD55;
pub const DEPTH_BITS = 0xD56;
pub const STENCIL_BITS = 0xD57;
pub const ACCUM_RED_BITS = 0xD58;
pub const ACCUM_GREEN_BITS = 0xD59;
pub const ACCUM_BLUE_BITS = 0xD5A;
pub const ACCUM_ALPHA_BITS = 0xD5B;
pub const NAME_STACK_DEPTH = 0xD70;
pub const AUTO_NORMAL = 0xD80;
pub const MAP1_COLOR_4 = 0xD90;
pub const MAP1_INDEX = 0xD91;
pub const MAP1_NORMAL = 0xD92;
pub const MAP1_TEXTURE_COORD_1 = 0xD93;
pub const MAP1_TEXTURE_COORD_2 = 0xD94;
pub const MAP1_TEXTURE_COORD_3 = 0xD95;
pub const MAP1_TEXTURE_COORD_4 = 0xD96;
pub const MAP1_VERTEX_3 = 0xD97;
pub const MAP1_VERTEX_4 = 0xD98;
pub const MAP2_COLOR_4 = 0xDB0;
pub const MAP2_INDEX = 0xDB1;
pub const MAP2_NORMAL = 0xDB2;
pub const MAP2_TEXTURE_COORD_1 = 0xDB3;
pub const MAP2_TEXTURE_COORD_2 = 0xDB4;
pub const MAP2_TEXTURE_COORD_3 = 0xDB5;
pub const MAP2_TEXTURE_COORD_4 = 0xDB6;
pub const MAP2_VERTEX_3 = 0xDB7;
pub const MAP2_VERTEX_4 = 0xDB8;
pub const MAP1_GRID_DOMAIN = 0xDD0;
pub const MAP1_GRID_SEGMENTS = 0xDD1;
pub const MAP2_GRID_DOMAIN = 0xDD2;
pub const MAP2_GRID_SEGMENTS = 0xDD3;
pub const TEXTURE_1D = 0xDE0;
pub const TEXTURE_2D = 0xDE1;
pub const FEEDBACK_BUFFER_POINTER = 0xDF0;
pub const FEEDBACK_BUFFER_SIZE = 0xDF1;
pub const FEEDBACK_BUFFER_TYPE = 0xDF2;
pub const SELECTION_BUFFER_POINTER = 0xDF3;
pub const SELECTION_BUFFER_SIZE = 0xDF4;
pub const TEXTURE_WIDTH = 0x1000;
pub const TEXTURE_HEIGHT = 0x1001;
pub const TEXTURE_COMPONENTS = 0x1003;
pub const TEXTURE_INTERNAL_FORMAT = 0x1003;
pub const TEXTURE_BORDER_COLOR = 0x1004;
pub const TEXTURE_BORDER = 0x1005;
pub const DONT_CARE = 0x1100;
pub const FASTEST = 0x1101;
pub const NICEST = 0x1102;
pub const AMBIENT = 0x1200;
pub const DIFFUSE = 0x1201;
pub const SPECULAR = 0x1202;
pub const POSITION = 0x1203;
pub const SPOT_DIRECTION = 0x1204;
pub const SPOT_EXPONENT = 0x1205;
pub const SPOT_CUTOFF = 0x1206;
pub const CONSTANT_ATTENUATION = 0x1207;
pub const LINEAR_ATTENUATION = 0x1208;
pub const QUADRATIC_ATTENUATION = 0x1209;
pub const COMPILE = 0x1300;
pub const COMPILE_AND_EXECUTE = 0x1301;
pub const BYTE = 0x1400;
pub const UNSIGNED_BYTE = 0x1401;
pub const SHORT = 0x1402;
pub const UNSIGNED_SHORT = 0x1403;
pub const INT = 0x1404;
pub const UNSIGNED_INT = 0x1405;
pub const FLOAT = 0x1406;
pub const @"2_BYTES" = 0x1407;
pub const @"3_BYTES" = 0x1408;
pub const @"4_BYTES" = 0x1409;
pub const DOUBLE = 0x140A;
pub const HALF_FLOAT = 0x140B;
pub const CLEAR = 0x1500;
pub const AND = 0x1501;
pub const AND_REVERSE = 0x1502;
pub const COPY = 0x1503;
pub const AND_INVERTED = 0x1504;
pub const NOOP = 0x1505;
pub const XOR = 0x1506;
pub const OR = 0x1507;
pub const NOR = 0x1508;
pub const EQUIV = 0x1509;
pub const INVERT = 0x150A;
pub const OR_REVERSE = 0x150B;
pub const COPY_INVERTED = 0x150C;
pub const OR_INVERTED = 0x150D;
pub const NAND = 0x150E;
pub const SET = 0x150F;
pub const EMISSION = 0x1600;
pub const SHININESS = 0x1601;
pub const AMBIENT_AND_DIFFUSE = 0x1602;
pub const COLOR_INDEXES = 0x1603;
pub const MODELVIEW = 0x1700;
pub const PROJECTION = 0x1701;
pub const TEXTURE = 0x1702;
pub const COLOR = 0x1800;
pub const DEPTH = 0x1801;
pub const STENCIL = 0x1802;
pub const COLOR_INDEX = 0x1900;
pub const STENCIL_INDEX = 0x1901;
pub const DEPTH_COMPONENT = 0x1902;
pub const RED = 0x1903;
pub const GREEN = 0x1904;
pub const BLUE = 0x1905;
pub const ALPHA = 0x1906;
pub const RGB = 0x1907;
pub const RGBA = 0x1908;
pub const LUMINANCE = 0x1909;
pub const LUMINANCE_ALPHA = 0x190A;
pub const BITMAP = 0x1A00;
pub const POINT = 0x1B00;
pub const LINE = 0x1B01;
pub const FILL = 0x1B02;
pub const RENDER = 0x1C00;
pub const FEEDBACK = 0x1C01;
pub const SELECT = 0x1C02;
pub const FLAT = 0x1D00;
pub const SMOOTH = 0x1D01;
pub const KEEP = 0x1E00;
pub const REPLACE = 0x1E01;
pub const INCR = 0x1E02;
pub const DECR = 0x1E03;
pub const VENDOR = 0x1F00;
pub const RENDERER = 0x1F01;
pub const VERSION = 0x1F02;
pub const EXTENSIONS = 0x1F03;
pub const S = 0x2000;
pub const T = 0x2001;
pub const R = 0x2002;
pub const Q = 0x2003;
pub const MODULATE = 0x2100;
pub const DECAL = 0x2101;
pub const TEXTURE_ENV_MODE = 0x2200;
pub const TEXTURE_ENV_COLOR = 0x2201;
pub const TEXTURE_ENV = 0x2300;
pub const EYE_LINEAR = 0x2400;
pub const OBJECT_LINEAR = 0x2401;
pub const SPHERE_MAP = 0x2402;
pub const TEXTURE_GEN_MODE = 0x2500;
pub const OBJECT_PLANE = 0x2501;
pub const EYE_PLANE = 0x2502;
pub const NEAREST = 0x2600;
pub const LINEAR = 0x2601;
pub const NEAREST_MIPMAP_NEAREST = 0x2700;
pub const LINEAR_MIPMAP_NEAREST = 0x2701;
pub const NEAREST_MIPMAP_LINEAR = 0x2702;
pub const LINEAR_MIPMAP_LINEAR = 0x2703;
pub const TEXTURE_MAG_FILTER = 0x2800;
pub const TEXTURE_MIN_FILTER = 0x2801;
pub const TEXTURE_WRAP_S = 0x2802;
pub const TEXTURE_WRAP_T = 0x2803;
pub const CLAMP = 0x2900;
pub const REPEAT = 0x2901;
pub const POLYGON_OFFSET_UNITS = 0x2A00;
pub const POLYGON_OFFSET_POINT = 0x2A01;
pub const POLYGON_OFFSET_LINE = 0x2A02;
pub const R3_G3_B2 = 0x2A10;
pub const V2F = 0x2A20;
pub const V3F = 0x2A21;
pub const C4UB_V2F = 0x2A22;
pub const C4UB_V3F = 0x2A23;
pub const C3F_V3F = 0x2A24;
pub const N3F_V3F = 0x2A25;
pub const C4F_N3F_V3F = 0x2A26;
pub const T2F_V3F = 0x2A27;
pub const T4F_V4F = 0x2A28;
pub const T2F_C4UB_V3F = 0x2A29;
pub const T2F_C3F_V3F = 0x2A2A;
pub const T2F_N3F_V3F = 0x2A2B;
pub const T2F_C4F_N3F_V3F = 0x2A2C;
pub const T4F_C4F_N3F_V4F = 0x2A2D;
pub const CLIP_DISTANCE0 = 0x3000;
pub const CLIP_PLANE0 = 0x3000;
pub const CLIP_DISTANCE1 = 0x3001;
pub const CLIP_PLANE1 = 0x3001;
pub const CLIP_DISTANCE2 = 0x3002;
pub const CLIP_PLANE2 = 0x3002;
pub const CLIP_DISTANCE3 = 0x3003;
pub const CLIP_PLANE3 = 0x3003;
pub const CLIP_DISTANCE4 = 0x3004;
pub const CLIP_PLANE4 = 0x3004;
pub const CLIP_DISTANCE5 = 0x3005;
pub const CLIP_PLANE5 = 0x3005;
pub const CLIP_DISTANCE6 = 0x3006;
pub const CLIP_DISTANCE7 = 0x3007;
pub const LIGHT0 = 0x4000;
pub const LIGHT1 = 0x4001;
pub const LIGHT2 = 0x4002;
pub const LIGHT3 = 0x4003;
pub const LIGHT4 = 0x4004;
pub const LIGHT5 = 0x4005;
pub const LIGHT6 = 0x4006;
pub const LIGHT7 = 0x4007;
pub const CONSTANT_COLOR = 0x8001;
pub const ONE_MINUS_CONSTANT_COLOR = 0x8002;
pub const CONSTANT_ALPHA = 0x8003;
pub const ONE_MINUS_CONSTANT_ALPHA = 0x8004;
pub const BLEND_COLOR = 0x8005;
pub const FUNC_ADD = 0x8006;
pub const MIN = 0x8007;
pub const MAX = 0x8008;
pub const BLEND_EQUATION = 0x8009;
pub const BLEND_EQUATION_RGB = 0x8009;
pub const FUNC_SUBTRACT = 0x800A;
pub const FUNC_REVERSE_SUBTRACT = 0x800B;
pub const UNSIGNED_BYTE_3_3_2 = 0x8032;
pub const UNSIGNED_SHORT_4_4_4_4 = 0x8033;
pub const UNSIGNED_SHORT_5_5_5_1 = 0x8034;
pub const UNSIGNED_INT_8_8_8_8 = 0x8035;
pub const UNSIGNED_INT_10_10_10_2 = 0x8036;
pub const POLYGON_OFFSET_FILL = 0x8037;
pub const POLYGON_OFFSET_FACTOR = 0x8038;
pub const RESCALE_NORMAL = 0x803A;
pub const ALPHA4 = 0x803B;
pub const ALPHA8 = 0x803C;
pub const ALPHA12 = 0x803D;
pub const ALPHA16 = 0x803E;
pub const LUMINANCE4 = 0x803F;
pub const LUMINANCE8 = 0x8040;
pub const LUMINANCE12 = 0x8041;
pub const LUMINANCE16 = 0x8042;
pub const LUMINANCE4_ALPHA4 = 0x8043;
pub const LUMINANCE6_ALPHA2 = 0x8044;
pub const LUMINANCE8_ALPHA8 = 0x8045;
pub const LUMINANCE12_ALPHA4 = 0x8046;
pub const LUMINANCE12_ALPHA12 = 0x8047;
pub const LUMINANCE16_ALPHA16 = 0x8048;
pub const INTENSITY = 0x8049;
pub const INTENSITY4 = 0x804A;
pub const INTENSITY8 = 0x804B;
pub const INTENSITY12 = 0x804C;
pub const INTENSITY16 = 0x804D;
pub const RGB4 = 0x804F;
pub const RGB5 = 0x8050;
pub const RGB8 = 0x8051;
pub const RGB10 = 0x8052;
pub const RGB12 = 0x8053;
pub const RGB16 = 0x8054;
pub const RGBA2 = 0x8055;
pub const RGBA4 = 0x8056;
pub const RGB5_A1 = 0x8057;
pub const RGBA8 = 0x8058;
pub const RGB10_A2 = 0x8059;
pub const RGBA12 = 0x805A;
pub const RGBA16 = 0x805B;
pub const TEXTURE_RED_SIZE = 0x805C;
pub const TEXTURE_GREEN_SIZE = 0x805D;
pub const TEXTURE_BLUE_SIZE = 0x805E;
pub const TEXTURE_ALPHA_SIZE = 0x805F;
pub const TEXTURE_LUMINANCE_SIZE = 0x8060;
pub const TEXTURE_INTENSITY_SIZE = 0x8061;
pub const PROXY_TEXTURE_1D = 0x8063;
pub const PROXY_TEXTURE_2D = 0x8064;
pub const TEXTURE_PRIORITY = 0x8066;
pub const TEXTURE_RESIDENT = 0x8067;
pub const TEXTURE_BINDING_1D = 0x8068;
pub const TEXTURE_BINDING_2D = 0x8069;
pub const TEXTURE_BINDING_3D = 0x806A;
pub const PACK_SKIP_IMAGES = 0x806B;
pub const PACK_IMAGE_HEIGHT = 0x806C;
pub const UNPACK_SKIP_IMAGES = 0x806D;
pub const UNPACK_IMAGE_HEIGHT = 0x806E;
pub const TEXTURE_3D = 0x806F;
pub const PROXY_TEXTURE_3D = 0x8070;
pub const TEXTURE_DEPTH = 0x8071;
pub const TEXTURE_WRAP_R = 0x8072;
pub const MAX_3D_TEXTURE_SIZE = 0x8073;
pub const VERTEX_ARRAY = 0x8074;
pub const NORMAL_ARRAY = 0x8075;
pub const COLOR_ARRAY = 0x8076;
pub const INDEX_ARRAY = 0x8077;
pub const TEXTURE_COORD_ARRAY = 0x8078;
pub const EDGE_FLAG_ARRAY = 0x8079;
pub const VERTEX_ARRAY_SIZE = 0x807A;
pub const VERTEX_ARRAY_TYPE = 0x807B;
pub const VERTEX_ARRAY_STRIDE = 0x807C;
pub const NORMAL_ARRAY_TYPE = 0x807E;
pub const NORMAL_ARRAY_STRIDE = 0x807F;
pub const COLOR_ARRAY_SIZE = 0x8081;
pub const COLOR_ARRAY_TYPE = 0x8082;
pub const COLOR_ARRAY_STRIDE = 0x8083;
pub const INDEX_ARRAY_TYPE = 0x8085;
pub const INDEX_ARRAY_STRIDE = 0x8086;
pub const TEXTURE_COORD_ARRAY_SIZE = 0x8088;
pub const TEXTURE_COORD_ARRAY_TYPE = 0x8089;
pub const TEXTURE_COORD_ARRAY_STRIDE = 0x808A;
pub const EDGE_FLAG_ARRAY_STRIDE = 0x808C;
pub const VERTEX_ARRAY_POINTER = 0x808E;
pub const NORMAL_ARRAY_POINTER = 0x808F;
pub const COLOR_ARRAY_POINTER = 0x8090;
pub const INDEX_ARRAY_POINTER = 0x8091;
pub const TEXTURE_COORD_ARRAY_POINTER = 0x8092;
pub const EDGE_FLAG_ARRAY_POINTER = 0x8093;
pub const MULTISAMPLE = 0x809D;
pub const SAMPLE_ALPHA_TO_COVERAGE = 0x809E;
pub const SAMPLE_ALPHA_TO_ONE = 0x809F;
pub const SAMPLE_COVERAGE = 0x80A0;
pub const SAMPLE_BUFFERS = 0x80A8;
pub const SAMPLES = 0x80A9;
pub const SAMPLE_COVERAGE_VALUE = 0x80AA;
pub const SAMPLE_COVERAGE_INVERT = 0x80AB;
pub const BLEND_DST_RGB = 0x80C8;
pub const BLEND_SRC_RGB = 0x80C9;
pub const BLEND_DST_ALPHA = 0x80CA;
pub const BLEND_SRC_ALPHA = 0x80CB;
pub const BGR = 0x80E0;
pub const BGRA = 0x80E1;
pub const MAX_ELEMENTS_VERTICES = 0x80E8;
pub const MAX_ELEMENTS_INDICES = 0x80E9;
pub const POINT_SIZE_MIN = 0x8126;
pub const POINT_SIZE_MAX = 0x8127;
pub const POINT_FADE_THRESHOLD_SIZE = 0x8128;
pub const POINT_DISTANCE_ATTENUATION = 0x8129;
pub const CLAMP_TO_BORDER = 0x812D;
pub const CLAMP_TO_EDGE = 0x812F;
pub const TEXTURE_MIN_LOD = 0x813A;
pub const TEXTURE_MAX_LOD = 0x813B;
pub const TEXTURE_BASE_LEVEL = 0x813C;
pub const TEXTURE_MAX_LEVEL = 0x813D;
pub const GENERATE_MIPMAP = 0x8191;
pub const GENERATE_MIPMAP_HINT = 0x8192;
pub const DEPTH_COMPONENT16 = 0x81A5;
pub const DEPTH_COMPONENT24 = 0x81A6;
pub const DEPTH_COMPONENT32 = 0x81A7;
pub const LIGHT_MODEL_COLOR_CONTROL = 0x81F8;
pub const SINGLE_COLOR = 0x81F9;
pub const SEPARATE_SPECULAR_COLOR = 0x81FA;
pub const FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = 0x8210;
pub const FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = 0x8211;
pub const FRAMEBUFFER_ATTACHMENT_RED_SIZE = 0x8212;
pub const FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = 0x8213;
pub const FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = 0x8214;
pub const FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = 0x8215;
pub const FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = 0x8216;
pub const FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = 0x8217;
pub const FRAMEBUFFER_DEFAULT = 0x8218;
pub const FRAMEBUFFER_UNDEFINED = 0x8219;
pub const DEPTH_STENCIL_ATTACHMENT = 0x821A;
pub const MAJOR_VERSION = 0x821B;
pub const MINOR_VERSION = 0x821C;
pub const NUM_EXTENSIONS = 0x821D;
pub const CONTEXT_FLAGS = 0x821E;
pub const INDEX = 0x8222;
pub const COMPRESSED_RED = 0x8225;
pub const COMPRESSED_RG = 0x8226;
pub const RG = 0x8227;
pub const RG_INTEGER = 0x8228;
pub const R8 = 0x8229;
pub const R16 = 0x822A;
pub const RG8 = 0x822B;
pub const RG16 = 0x822C;
pub const R16F = 0x822D;
pub const R32F = 0x822E;
pub const RG16F = 0x822F;
pub const RG32F = 0x8230;
pub const R8I = 0x8231;
pub const R8UI = 0x8232;
pub const R16I = 0x8233;
pub const R16UI = 0x8234;
pub const R32I = 0x8235;
pub const R32UI = 0x8236;
pub const RG8I = 0x8237;
pub const RG8UI = 0x8238;
pub const RG16I = 0x8239;
pub const RG16UI = 0x823A;
pub const RG32I = 0x823B;
pub const RG32UI = 0x823C;
pub const UNSIGNED_BYTE_2_3_3_REV = 0x8362;
pub const UNSIGNED_SHORT_5_6_5 = 0x8363;
pub const UNSIGNED_SHORT_5_6_5_REV = 0x8364;
pub const UNSIGNED_SHORT_4_4_4_4_REV = 0x8365;
pub const UNSIGNED_SHORT_1_5_5_5_REV = 0x8366;
pub const UNSIGNED_INT_8_8_8_8_REV = 0x8367;
pub const UNSIGNED_INT_2_10_10_10_REV = 0x8368;
pub const MIRRORED_REPEAT = 0x8370;
pub const FOG_COORDINATE_SOURCE = 0x8450;
pub const FOG_COORD_SRC = 0x8450;
pub const FOG_COORD = 0x8451;
pub const FOG_COORDINATE = 0x8451;
pub const FRAGMENT_DEPTH = 0x8452;
pub const CURRENT_FOG_COORD = 0x8453;
pub const CURRENT_FOG_COORDINATE = 0x8453;
pub const FOG_COORDINATE_ARRAY_TYPE = 0x8454;
pub const FOG_COORD_ARRAY_TYPE = 0x8454;
pub const FOG_COORDINATE_ARRAY_STRIDE = 0x8455;
pub const FOG_COORD_ARRAY_STRIDE = 0x8455;
pub const FOG_COORDINATE_ARRAY_POINTER = 0x8456;
pub const FOG_COORD_ARRAY_POINTER = 0x8456;
pub const FOG_COORDINATE_ARRAY = 0x8457;
pub const FOG_COORD_ARRAY = 0x8457;
pub const COLOR_SUM = 0x8458;
pub const CURRENT_SECONDARY_COLOR = 0x8459;
pub const SECONDARY_COLOR_ARRAY_SIZE = 0x845A;
pub const SECONDARY_COLOR_ARRAY_TYPE = 0x845B;
pub const SECONDARY_COLOR_ARRAY_STRIDE = 0x845C;
pub const SECONDARY_COLOR_ARRAY_POINTER = 0x845D;
pub const SECONDARY_COLOR_ARRAY = 0x845E;
pub const CURRENT_RASTER_SECONDARY_COLOR = 0x845F;
pub const ALIASED_POINT_SIZE_RANGE = 0x846D;
pub const ALIASED_LINE_WIDTH_RANGE = 0x846E;
pub const TEXTURE0 = 0x84C0;
pub const TEXTURE1 = 0x84C1;
pub const TEXTURE2 = 0x84C2;
pub const TEXTURE3 = 0x84C3;
pub const TEXTURE4 = 0x84C4;
pub const TEXTURE5 = 0x84C5;
pub const TEXTURE6 = 0x84C6;
pub const TEXTURE7 = 0x84C7;
pub const TEXTURE8 = 0x84C8;
pub const TEXTURE9 = 0x84C9;
pub const TEXTURE10 = 0x84CA;
pub const TEXTURE11 = 0x84CB;
pub const TEXTURE12 = 0x84CC;
pub const TEXTURE13 = 0x84CD;
pub const TEXTURE14 = 0x84CE;
pub const TEXTURE15 = 0x84CF;
pub const TEXTURE16 = 0x84D0;
pub const TEXTURE17 = 0x84D1;
pub const TEXTURE18 = 0x84D2;
pub const TEXTURE19 = 0x84D3;
pub const TEXTURE20 = 0x84D4;
pub const TEXTURE21 = 0x84D5;
pub const TEXTURE22 = 0x84D6;
pub const TEXTURE23 = 0x84D7;
pub const TEXTURE24 = 0x84D8;
pub const TEXTURE25 = 0x84D9;
pub const TEXTURE26 = 0x84DA;
pub const TEXTURE27 = 0x84DB;
pub const TEXTURE28 = 0x84DC;
pub const TEXTURE29 = 0x84DD;
pub const TEXTURE30 = 0x84DE;
pub const TEXTURE31 = 0x84DF;
pub const ACTIVE_TEXTURE = 0x84E0;
pub const CLIENT_ACTIVE_TEXTURE = 0x84E1;
pub const MAX_TEXTURE_UNITS = 0x84E2;
pub const TRANSPOSE_MODELVIEW_MATRIX = 0x84E3;
pub const TRANSPOSE_PROJECTION_MATRIX = 0x84E4;
pub const TRANSPOSE_TEXTURE_MATRIX = 0x84E5;
pub const TRANSPOSE_COLOR_MATRIX = 0x84E6;
pub const SUBTRACT = 0x84E7;
pub const MAX_RENDERBUFFER_SIZE = 0x84E8;
pub const COMPRESSED_ALPHA = 0x84E9;
pub const COMPRESSED_LUMINANCE = 0x84EA;
pub const COMPRESSED_LUMINANCE_ALPHA = 0x84EB;
pub const COMPRESSED_INTENSITY = 0x84EC;
pub const COMPRESSED_RGB = 0x84ED;
pub const COMPRESSED_RGBA = 0x84EE;
pub const TEXTURE_COMPRESSION_HINT = 0x84EF;
pub const TEXTURE_RECTANGLE = 0x84F5;
pub const TEXTURE_BINDING_RECTANGLE = 0x84F6;
pub const PROXY_TEXTURE_RECTANGLE = 0x84F7;
pub const MAX_RECTANGLE_TEXTURE_SIZE = 0x84F8;
pub const DEPTH_STENCIL = 0x84F9;
pub const UNSIGNED_INT_24_8 = 0x84FA;
pub const MAX_TEXTURE_LOD_BIAS = 0x84FD;
pub const TEXTURE_FILTER_CONTROL = 0x8500;
pub const TEXTURE_LOD_BIAS = 0x8501;
pub const INCR_WRAP = 0x8507;
pub const DECR_WRAP = 0x8508;
pub const NORMAL_MAP = 0x8511;
pub const REFLECTION_MAP = 0x8512;
pub const TEXTURE_CUBE_MAP = 0x8513;
pub const TEXTURE_BINDING_CUBE_MAP = 0x8514;
pub const TEXTURE_CUBE_MAP_POSITIVE_X = 0x8515;
pub const TEXTURE_CUBE_MAP_NEGATIVE_X = 0x8516;
pub const TEXTURE_CUBE_MAP_POSITIVE_Y = 0x8517;
pub const TEXTURE_CUBE_MAP_NEGATIVE_Y = 0x8518;
pub const TEXTURE_CUBE_MAP_POSITIVE_Z = 0x8519;
pub const TEXTURE_CUBE_MAP_NEGATIVE_Z = 0x851A;
pub const PROXY_TEXTURE_CUBE_MAP = 0x851B;
pub const MAX_CUBE_MAP_TEXTURE_SIZE = 0x851C;
pub const COMBINE = 0x8570;
pub const COMBINE_RGB = 0x8571;
pub const COMBINE_ALPHA = 0x8572;
pub const RGB_SCALE = 0x8573;
pub const ADD_SIGNED = 0x8574;
pub const INTERPOLATE = 0x8575;
pub const CONSTANT = 0x8576;
pub const PRIMARY_COLOR = 0x8577;
pub const PREVIOUS = 0x8578;
pub const SOURCE0_RGB = 0x8580;
pub const SRC0_RGB = 0x8580;
pub const SOURCE1_RGB = 0x8581;
pub const SRC1_RGB = 0x8581;
pub const SOURCE2_RGB = 0x8582;
pub const SRC2_RGB = 0x8582;
pub const SOURCE0_ALPHA = 0x8588;
pub const SRC0_ALPHA = 0x8588;
pub const SOURCE1_ALPHA = 0x8589;
pub const SRC1_ALPHA = 0x8589;
pub const SOURCE2_ALPHA = 0x858A;
pub const SRC2_ALPHA = 0x858A;
pub const OPERAND0_RGB = 0x8590;
pub const OPERAND1_RGB = 0x8591;
pub const OPERAND2_RGB = 0x8592;
pub const OPERAND0_ALPHA = 0x8598;
pub const OPERAND1_ALPHA = 0x8599;
pub const OPERAND2_ALPHA = 0x859A;
pub const VERTEX_ARRAY_BINDING = 0x85B5;
pub const VERTEX_ATTRIB_ARRAY_ENABLED = 0x8622;
pub const VERTEX_ATTRIB_ARRAY_SIZE = 0x8623;
pub const VERTEX_ATTRIB_ARRAY_STRIDE = 0x8624;
pub const VERTEX_ATTRIB_ARRAY_TYPE = 0x8625;
pub const CURRENT_VERTEX_ATTRIB = 0x8626;
pub const VERTEX_PROGRAM_POINT_SIZE = 0x8642;
pub const VERTEX_PROGRAM_TWO_SIDE = 0x8643;
pub const VERTEX_ATTRIB_ARRAY_POINTER = 0x8645;
pub const TEXTURE_COMPRESSED_IMAGE_SIZE = 0x86A0;
pub const TEXTURE_COMPRESSED = 0x86A1;
pub const NUM_COMPRESSED_TEXTURE_FORMATS = 0x86A2;
pub const COMPRESSED_TEXTURE_FORMATS = 0x86A3;
pub const DOT3_RGB = 0x86AE;
pub const DOT3_RGBA = 0x86AF;
pub const BUFFER_SIZE = 0x8764;
pub const BUFFER_USAGE = 0x8765;
pub const STENCIL_BACK_FUNC = 0x8800;
pub const STENCIL_BACK_FAIL = 0x8801;
pub const STENCIL_BACK_PASS_DEPTH_FAIL = 0x8802;
pub const STENCIL_BACK_PASS_DEPTH_PASS = 0x8803;
pub const RGBA32F = 0x8814;
pub const RGB32F = 0x8815;
pub const RGBA16F = 0x881A;
pub const RGB16F = 0x881B;
pub const MAX_DRAW_BUFFERS = 0x8824;
pub const DRAW_BUFFER0 = 0x8825;
pub const DRAW_BUFFER1 = 0x8826;
pub const DRAW_BUFFER2 = 0x8827;
pub const DRAW_BUFFER3 = 0x8828;
pub const DRAW_BUFFER4 = 0x8829;
pub const DRAW_BUFFER5 = 0x882A;
pub const DRAW_BUFFER6 = 0x882B;
pub const DRAW_BUFFER7 = 0x882C;
pub const DRAW_BUFFER8 = 0x882D;
pub const DRAW_BUFFER9 = 0x882E;
pub const DRAW_BUFFER10 = 0x882F;
pub const DRAW_BUFFER11 = 0x8830;
pub const DRAW_BUFFER12 = 0x8831;
pub const DRAW_BUFFER13 = 0x8832;
pub const DRAW_BUFFER14 = 0x8833;
pub const DRAW_BUFFER15 = 0x8834;
pub const BLEND_EQUATION_ALPHA = 0x883D;
pub const TEXTURE_DEPTH_SIZE = 0x884A;
pub const DEPTH_TEXTURE_MODE = 0x884B;
pub const TEXTURE_COMPARE_MODE = 0x884C;
pub const TEXTURE_COMPARE_FUNC = 0x884D;
pub const COMPARE_REF_TO_TEXTURE = 0x884E;
pub const COMPARE_R_TO_TEXTURE = 0x884E;
pub const POINT_SPRITE = 0x8861;
pub const COORD_REPLACE = 0x8862;
pub const QUERY_COUNTER_BITS = 0x8864;
pub const CURRENT_QUERY = 0x8865;
pub const QUERY_RESULT = 0x8866;
pub const QUERY_RESULT_AVAILABLE = 0x8867;
pub const MAX_VERTEX_ATTRIBS = 0x8869;
pub const VERTEX_ATTRIB_ARRAY_NORMALIZED = 0x886A;
pub const MAX_TEXTURE_COORDS = 0x8871;
pub const MAX_TEXTURE_IMAGE_UNITS = 0x8872;
pub const ARRAY_BUFFER = 0x8892;
pub const ELEMENT_ARRAY_BUFFER = 0x8893;
pub const ARRAY_BUFFER_BINDING = 0x8894;
pub const ELEMENT_ARRAY_BUFFER_BINDING = 0x8895;
pub const VERTEX_ARRAY_BUFFER_BINDING = 0x8896;
pub const NORMAL_ARRAY_BUFFER_BINDING = 0x8897;
pub const COLOR_ARRAY_BUFFER_BINDING = 0x8898;
pub const INDEX_ARRAY_BUFFER_BINDING = 0x8899;
pub const TEXTURE_COORD_ARRAY_BUFFER_BINDING = 0x889A;
pub const EDGE_FLAG_ARRAY_BUFFER_BINDING = 0x889B;
pub const SECONDARY_COLOR_ARRAY_BUFFER_BINDING = 0x889C;
pub const FOG_COORDINATE_ARRAY_BUFFER_BINDING = 0x889D;
pub const FOG_COORD_ARRAY_BUFFER_BINDING = 0x889D;
pub const WEIGHT_ARRAY_BUFFER_BINDING = 0x889E;
pub const VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F;
pub const READ_ONLY = 0x88B8;
pub const WRITE_ONLY = 0x88B9;
pub const READ_WRITE = 0x88BA;
pub const BUFFER_ACCESS = 0x88BB;
pub const BUFFER_MAPPED = 0x88BC;
pub const BUFFER_MAP_POINTER = 0x88BD;
pub const STREAM_DRAW = 0x88E0;
pub const STREAM_READ = 0x88E1;
pub const STREAM_COPY = 0x88E2;
pub const STATIC_DRAW = 0x88E4;
pub const STATIC_READ = 0x88E5;
pub const STATIC_COPY = 0x88E6;
pub const DYNAMIC_DRAW = 0x88E8;
pub const DYNAMIC_READ = 0x88E9;
pub const DYNAMIC_COPY = 0x88EA;
pub const PIXEL_PACK_BUFFER = 0x88EB;
pub const PIXEL_UNPACK_BUFFER = 0x88EC;
pub const PIXEL_PACK_BUFFER_BINDING = 0x88ED;
pub const PIXEL_UNPACK_BUFFER_BINDING = 0x88EF;
pub const DEPTH24_STENCIL8 = 0x88F0;
pub const TEXTURE_STENCIL_SIZE = 0x88F1;
pub const VERTEX_ATTRIB_ARRAY_INTEGER = 0x88FD;
pub const MAX_ARRAY_TEXTURE_LAYERS = 0x88FF;
pub const MIN_PROGRAM_TEXEL_OFFSET = 0x8904;
pub const MAX_PROGRAM_TEXEL_OFFSET = 0x8905;
pub const SAMPLES_PASSED = 0x8914;
pub const CLAMP_VERTEX_COLOR = 0x891A;
pub const CLAMP_FRAGMENT_COLOR = 0x891B;
pub const CLAMP_READ_COLOR = 0x891C;
pub const FIXED_ONLY = 0x891D;
pub const UNIFORM_BUFFER = 0x8A11;
pub const UNIFORM_BUFFER_BINDING = 0x8A28;
pub const UNIFORM_BUFFER_START = 0x8A29;
pub const UNIFORM_BUFFER_SIZE = 0x8A2A;
pub const MAX_VERTEX_UNIFORM_BLOCKS = 0x8A2B;
pub const MAX_GEOMETRY_UNIFORM_BLOCKS = 0x8A2C;
pub const MAX_FRAGMENT_UNIFORM_BLOCKS = 0x8A2D;
pub const MAX_COMBINED_UNIFORM_BLOCKS = 0x8A2E;
pub const MAX_UNIFORM_BUFFER_BINDINGS = 0x8A2F;
pub const MAX_UNIFORM_BLOCK_SIZE = 0x8A30;
pub const MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = 0x8A31;
pub const MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = 0x8A32;
pub const MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = 0x8A33;
pub const UNIFORM_BUFFER_OFFSET_ALIGNMENT = 0x8A34;
pub const ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = 0x8A35;
pub const ACTIVE_UNIFORM_BLOCKS = 0x8A36;
pub const UNIFORM_TYPE = 0x8A37;
pub const UNIFORM_SIZE = 0x8A38;
pub const UNIFORM_NAME_LENGTH = 0x8A39;
pub const UNIFORM_BLOCK_INDEX = 0x8A3A;
pub const UNIFORM_OFFSET = 0x8A3B;
pub const UNIFORM_ARRAY_STRIDE = 0x8A3C;
pub const UNIFORM_MATRIX_STRIDE = 0x8A3D;
pub const UNIFORM_IS_ROW_MAJOR = 0x8A3E;
pub const UNIFORM_BLOCK_BINDING = 0x8A3F;
pub const UNIFORM_BLOCK_DATA_SIZE = 0x8A40;
pub const UNIFORM_BLOCK_NAME_LENGTH = 0x8A41;
pub const UNIFORM_BLOCK_ACTIVE_UNIFORMS = 0x8A42;
pub const UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = 0x8A43;
pub const UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = 0x8A44;
pub const UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = 0x8A45;
pub const UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = 0x8A46;
pub const FRAGMENT_SHADER = 0x8B30;
pub const VERTEX_SHADER = 0x8B31;
pub const MAX_FRAGMENT_UNIFORM_COMPONENTS = 0x8B49;
pub const MAX_VERTEX_UNIFORM_COMPONENTS = 0x8B4A;
pub const MAX_VARYING_COMPONENTS = 0x8B4B;
pub const MAX_VARYING_FLOATS = 0x8B4B;
pub const MAX_VERTEX_TEXTURE_IMAGE_UNITS = 0x8B4C;
pub const MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D;
pub const SHADER_TYPE = 0x8B4F;
pub const FLOAT_VEC2 = 0x8B50;
pub const FLOAT_VEC3 = 0x8B51;
pub const FLOAT_VEC4 = 0x8B52;
pub const INT_VEC2 = 0x8B53;
pub const INT_VEC3 = 0x8B54;
pub const INT_VEC4 = 0x8B55;
pub const BOOL = 0x8B56;
pub const BOOL_VEC2 = 0x8B57;
pub const BOOL_VEC3 = 0x8B58;
pub const BOOL_VEC4 = 0x8B59;
pub const FLOAT_MAT2 = 0x8B5A;
pub const FLOAT_MAT3 = 0x8B5B;
pub const FLOAT_MAT4 = 0x8B5C;
pub const SAMPLER_1D = 0x8B5D;
pub const SAMPLER_2D = 0x8B5E;
pub const SAMPLER_3D = 0x8B5F;
pub const SAMPLER_CUBE = 0x8B60;
pub const SAMPLER_1D_SHADOW = 0x8B61;
pub const SAMPLER_2D_SHADOW = 0x8B62;
pub const SAMPLER_2D_RECT = 0x8B63;
pub const SAMPLER_2D_RECT_SHADOW = 0x8B64;
pub const FLOAT_MAT2x3 = 0x8B65;
pub const FLOAT_MAT2x4 = 0x8B66;
pub const FLOAT_MAT3x2 = 0x8B67;
pub const FLOAT_MAT3x4 = 0x8B68;
pub const FLOAT_MAT4x2 = 0x8B69;
pub const FLOAT_MAT4x3 = 0x8B6A;
pub const DELETE_STATUS = 0x8B80;
pub const COMPILE_STATUS = 0x8B81;
pub const LINK_STATUS = 0x8B82;
pub const VALIDATE_STATUS = 0x8B83;
pub const INFO_LOG_LENGTH = 0x8B84;
pub const ATTACHED_SHADERS = 0x8B85;
pub const ACTIVE_UNIFORMS = 0x8B86;
pub const ACTIVE_UNIFORM_MAX_LENGTH = 0x8B87;
pub const SHADER_SOURCE_LENGTH = 0x8B88;
pub const ACTIVE_ATTRIBUTES = 0x8B89;
pub const ACTIVE_ATTRIBUTE_MAX_LENGTH = 0x8B8A;
pub const FRAGMENT_SHADER_DERIVATIVE_HINT = 0x8B8B;
pub const SHADING_LANGUAGE_VERSION = 0x8B8C;
pub const CURRENT_PROGRAM = 0x8B8D;
pub const TEXTURE_RED_TYPE = 0x8C10;
pub const TEXTURE_GREEN_TYPE = 0x8C11;
pub const TEXTURE_BLUE_TYPE = 0x8C12;
pub const TEXTURE_ALPHA_TYPE = 0x8C13;
pub const TEXTURE_LUMINANCE_TYPE = 0x8C14;
pub const TEXTURE_INTENSITY_TYPE = 0x8C15;
pub const TEXTURE_DEPTH_TYPE = 0x8C16;
pub const UNSIGNED_NORMALIZED = 0x8C17;
pub const TEXTURE_1D_ARRAY = 0x8C18;
pub const PROXY_TEXTURE_1D_ARRAY = 0x8C19;
pub const TEXTURE_2D_ARRAY = 0x8C1A;
pub const PROXY_TEXTURE_2D_ARRAY = 0x8C1B;
pub const TEXTURE_BINDING_1D_ARRAY = 0x8C1C;
pub const TEXTURE_BINDING_2D_ARRAY = 0x8C1D;
pub const TEXTURE_BUFFER = 0x8C2A;
pub const MAX_TEXTURE_BUFFER_SIZE = 0x8C2B;
pub const TEXTURE_BINDING_BUFFER = 0x8C2C;
pub const TEXTURE_BUFFER_DATA_STORE_BINDING = 0x8C2D;
pub const R11F_G11F_B10F = 0x8C3A;
pub const UNSIGNED_INT_10F_11F_11F_REV = 0x8C3B;
pub const RGB9_E5 = 0x8C3D;
pub const UNSIGNED_INT_5_9_9_9_REV = 0x8C3E;
pub const TEXTURE_SHARED_SIZE = 0x8C3F;
pub const SRGB = 0x8C40;
pub const SRGB8 = 0x8C41;
pub const SRGB_ALPHA = 0x8C42;
pub const SRGB8_ALPHA8 = 0x8C43;
pub const SLUMINANCE_ALPHA = 0x8C44;
pub const SLUMINANCE8_ALPHA8 = 0x8C45;
pub const SLUMINANCE = 0x8C46;
pub const SLUMINANCE8 = 0x8C47;
pub const COMPRESSED_SRGB = 0x8C48;
pub const COMPRESSED_SRGB_ALPHA = 0x8C49;
pub const COMPRESSED_SLUMINANCE = 0x8C4A;
pub const COMPRESSED_SLUMINANCE_ALPHA = 0x8C4B;
pub const TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = 0x8C76;
pub const TRANSFORM_FEEDBACK_BUFFER_MODE = 0x8C7F;
pub const MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = 0x8C80;
pub const TRANSFORM_FEEDBACK_VARYINGS = 0x8C83;
pub const TRANSFORM_FEEDBACK_BUFFER_START = 0x8C84;
pub const TRANSFORM_FEEDBACK_BUFFER_SIZE = 0x8C85;
pub const PRIMITIVES_GENERATED = 0x8C87;
pub const TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = 0x8C88;
pub const RASTERIZER_DISCARD = 0x8C89;
pub const MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 0x8C8A;
pub const MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = 0x8C8B;
pub const INTERLEAVED_ATTRIBS = 0x8C8C;
pub const SEPARATE_ATTRIBS = 0x8C8D;
pub const TRANSFORM_FEEDBACK_BUFFER = 0x8C8E;
pub const TRANSFORM_FEEDBACK_BUFFER_BINDING = 0x8C8F;
pub const POINT_SPRITE_COORD_ORIGIN = 0x8CA0;
pub const LOWER_LEFT = 0x8CA1;
pub const UPPER_LEFT = 0x8CA2;
pub const STENCIL_BACK_REF = 0x8CA3;
pub const STENCIL_BACK_VALUE_MASK = 0x8CA4;
pub const STENCIL_BACK_WRITEMASK = 0x8CA5;
pub const DRAW_FRAMEBUFFER_BINDING = 0x8CA6;
pub const FRAMEBUFFER_BINDING = 0x8CA6;
pub const RENDERBUFFER_BINDING = 0x8CA7;
pub const READ_FRAMEBUFFER = 0x8CA8;
pub const DRAW_FRAMEBUFFER = 0x8CA9;
pub const READ_FRAMEBUFFER_BINDING = 0x8CAA;
pub const RENDERBUFFER_SAMPLES = 0x8CAB;
pub const DEPTH_COMPONENT32F = 0x8CAC;
pub const DEPTH32F_STENCIL8 = 0x8CAD;
pub const FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 0x8CD0;
pub const FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 0x8CD1;
pub const FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 0x8CD2;
pub const FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3;
pub const FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = 0x8CD4;
pub const FRAMEBUFFER_COMPLETE = 0x8CD5;
pub const FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 0x8CD6;
pub const FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7;
pub const FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = 0x8CDB;
pub const FRAMEBUFFER_INCOMPLETE_READ_BUFFER = 0x8CDC;
pub const FRAMEBUFFER_UNSUPPORTED = 0x8CDD;
pub const MAX_COLOR_ATTACHMENTS = 0x8CDF;
pub const COLOR_ATTACHMENT0 = 0x8CE0;
pub const COLOR_ATTACHMENT1 = 0x8CE1;
pub const COLOR_ATTACHMENT2 = 0x8CE2;
pub const COLOR_ATTACHMENT3 = 0x8CE3;
pub const COLOR_ATTACHMENT4 = 0x8CE4;
pub const COLOR_ATTACHMENT5 = 0x8CE5;
pub const COLOR_ATTACHMENT6 = 0x8CE6;
pub const COLOR_ATTACHMENT7 = 0x8CE7;
pub const COLOR_ATTACHMENT8 = 0x8CE8;
pub const COLOR_ATTACHMENT9 = 0x8CE9;
pub const COLOR_ATTACHMENT10 = 0x8CEA;
pub const COLOR_ATTACHMENT11 = 0x8CEB;
pub const COLOR_ATTACHMENT12 = 0x8CEC;
pub const COLOR_ATTACHMENT13 = 0x8CED;
pub const COLOR_ATTACHMENT14 = 0x8CEE;
pub const COLOR_ATTACHMENT15 = 0x8CEF;
pub const COLOR_ATTACHMENT16 = 0x8CF0;
pub const COLOR_ATTACHMENT17 = 0x8CF1;
pub const COLOR_ATTACHMENT18 = 0x8CF2;
pub const COLOR_ATTACHMENT19 = 0x8CF3;
pub const COLOR_ATTACHMENT20 = 0x8CF4;
pub const COLOR_ATTACHMENT21 = 0x8CF5;
pub const COLOR_ATTACHMENT22 = 0x8CF6;
pub const COLOR_ATTACHMENT23 = 0x8CF7;
pub const COLOR_ATTACHMENT24 = 0x8CF8;
pub const COLOR_ATTACHMENT25 = 0x8CF9;
pub const COLOR_ATTACHMENT26 = 0x8CFA;
pub const COLOR_ATTACHMENT27 = 0x8CFB;
pub const COLOR_ATTACHMENT28 = 0x8CFC;
pub const COLOR_ATTACHMENT29 = 0x8CFD;
pub const COLOR_ATTACHMENT30 = 0x8CFE;
pub const COLOR_ATTACHMENT31 = 0x8CFF;
pub const DEPTH_ATTACHMENT = 0x8D00;
pub const STENCIL_ATTACHMENT = 0x8D20;
pub const FRAMEBUFFER = 0x8D40;
pub const RENDERBUFFER = 0x8D41;
pub const RENDERBUFFER_WIDTH = 0x8D42;
pub const RENDERBUFFER_HEIGHT = 0x8D43;
pub const RENDERBUFFER_INTERNAL_FORMAT = 0x8D44;
pub const STENCIL_INDEX1 = 0x8D46;
pub const STENCIL_INDEX4 = 0x8D47;
pub const STENCIL_INDEX8 = 0x8D48;
pub const STENCIL_INDEX16 = 0x8D49;
pub const RENDERBUFFER_RED_SIZE = 0x8D50;
pub const RENDERBUFFER_GREEN_SIZE = 0x8D51;
pub const RENDERBUFFER_BLUE_SIZE = 0x8D52;
pub const RENDERBUFFER_ALPHA_SIZE = 0x8D53;
pub const RENDERBUFFER_DEPTH_SIZE = 0x8D54;
pub const RENDERBUFFER_STENCIL_SIZE = 0x8D55;
pub const FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = 0x8D56;
pub const MAX_SAMPLES = 0x8D57;
pub const RGBA32UI = 0x8D70;
pub const RGB32UI = 0x8D71;
pub const RGBA16UI = 0x8D76;
pub const RGB16UI = 0x8D77;
pub const RGBA8UI = 0x8D7C;
pub const RGB8UI = 0x8D7D;
pub const RGBA32I = 0x8D82;
pub const RGB32I = 0x8D83;
pub const RGBA16I = 0x8D88;
pub const RGB16I = 0x8D89;
pub const RGBA8I = 0x8D8E;
pub const RGB8I = 0x8D8F;
pub const RED_INTEGER = 0x8D94;
pub const GREEN_INTEGER = 0x8D95;
pub const BLUE_INTEGER = 0x8D96;
pub const ALPHA_INTEGER = 0x8D97;
pub const RGB_INTEGER = 0x8D98;
pub const RGBA_INTEGER = 0x8D99;
pub const BGR_INTEGER = 0x8D9A;
pub const BGRA_INTEGER = 0x8D9B;
pub const FLOAT_32_UNSIGNED_INT_24_8_REV = 0x8DAD;
pub const FRAMEBUFFER_SRGB = 0x8DB9;
pub const COMPRESSED_RED_RGTC1 = 0x8DBB;
pub const COMPRESSED_SIGNED_RED_RGTC1 = 0x8DBC;
pub const COMPRESSED_RG_RGTC2 = 0x8DBD;
pub const COMPRESSED_SIGNED_RG_RGTC2 = 0x8DBE;
pub const SAMPLER_1D_ARRAY = 0x8DC0;
pub const SAMPLER_2D_ARRAY = 0x8DC1;
pub const SAMPLER_BUFFER = 0x8DC2;
pub const SAMPLER_1D_ARRAY_SHADOW = 0x8DC3;
pub const SAMPLER_2D_ARRAY_SHADOW = 0x8DC4;
pub const SAMPLER_CUBE_SHADOW = 0x8DC5;
pub const UNSIGNED_INT_VEC2 = 0x8DC6;
pub const UNSIGNED_INT_VEC3 = 0x8DC7;
pub const UNSIGNED_INT_VEC4 = 0x8DC8;
pub const INT_SAMPLER_1D = 0x8DC9;
pub const INT_SAMPLER_2D = 0x8DCA;
pub const INT_SAMPLER_3D = 0x8DCB;
pub const INT_SAMPLER_CUBE = 0x8DCC;
pub const INT_SAMPLER_2D_RECT = 0x8DCD;
pub const INT_SAMPLER_1D_ARRAY = 0x8DCE;
pub const INT_SAMPLER_2D_ARRAY = 0x8DCF;
pub const INT_SAMPLER_BUFFER = 0x8DD0;
pub const UNSIGNED_INT_SAMPLER_1D = 0x8DD1;
pub const UNSIGNED_INT_SAMPLER_2D = 0x8DD2;
pub const UNSIGNED_INT_SAMPLER_3D = 0x8DD3;
pub const UNSIGNED_INT_SAMPLER_CUBE = 0x8DD4;
pub const UNSIGNED_INT_SAMPLER_2D_RECT = 0x8DD5;
pub const UNSIGNED_INT_SAMPLER_1D_ARRAY = 0x8DD6;
pub const UNSIGNED_INT_SAMPLER_2D_ARRAY = 0x8DD7;
pub const UNSIGNED_INT_SAMPLER_BUFFER = 0x8DD8;
pub const QUERY_WAIT = 0x8E13;
pub const QUERY_NO_WAIT = 0x8E14;
pub const QUERY_BY_REGION_WAIT = 0x8E15;
pub const QUERY_BY_REGION_NO_WAIT = 0x8E16;
pub const COPY_READ_BUFFER = 0x8F36;
pub const COPY_WRITE_BUFFER = 0x8F37;
pub const R8_SNORM = 0x8F94;
pub const RG8_SNORM = 0x8F95;
pub const RGB8_SNORM = 0x8F96;
pub const RGBA8_SNORM = 0x8F97;
pub const R16_SNORM = 0x8F98;
pub const RG16_SNORM = 0x8F99;
pub const RGB16_SNORM = 0x8F9A;
pub const RGBA16_SNORM = 0x8F9B;
pub const SIGNED_NORMALIZED = 0x8F9C;
pub const PRIMITIVE_RESTART = 0x8F9D;
pub const PRIMITIVE_RESTART_INDEX = 0x8F9E;
pub const BUFFER_ACCESS_FLAGS = 0x911F;
pub const BUFFER_MAP_LENGTH = 0x9120;
pub const BUFFER_MAP_OFFSET = 0x9121;
//#endregion Constants

//#region Commands
pub fn accum(op: Enum, value: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glAccum", .{ op, value });
}
pub fn activeTexture(texture: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glActiveTexture", .{texture});
}
pub fn alphaFunc(func: Enum, ref: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glAlphaFunc", .{ func, ref });
}
pub fn areTexturesResident(n: Sizei, textures: [*c]const Uint, residences: [*c]Boolean) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glAreTexturesResident", .{ n, textures, residences });
}
pub fn arrayElement(i: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glArrayElement", .{i});
}
pub fn attachShader(program: Uint, shader: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glAttachShader", .{ program, shader });
}
pub fn begin(mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBegin", .{mode});
}
pub fn beginConditionalRender(id: Uint, mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBeginConditionalRender", .{ id, mode });
}
pub fn beginQuery(target: Enum, id: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBeginQuery", .{ target, id });
}
pub fn beginTransformFeedback(primitiveMode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBeginTransformFeedback", .{primitiveMode});
}
pub fn bindAttribLocation(program: Uint, index: Uint, name: [*c]const Char) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBindAttribLocation", .{ program, index, name });
}
pub fn bindBuffer(target: Enum, buffer: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBindBuffer", .{ target, buffer });
}
pub fn bindBufferBase(target: Enum, index: Uint, buffer: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBindBufferBase", .{ target, index, buffer });
}
pub fn bindBufferRange(target: Enum, index: Uint, buffer: Uint, offset: Intptr, size: Sizeiptr) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBindBufferRange", .{ target, index, buffer, offset, size });
}
pub fn bindFragDataLocation(program: Uint, color: Uint, name: [*c]const Char) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBindFragDataLocation", .{ program, color, name });
}
pub fn bindFramebuffer(target: Enum, framebuffer: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBindFramebuffer", .{ target, framebuffer });
}
pub fn bindRenderbuffer(target: Enum, renderbuffer: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBindRenderbuffer", .{ target, renderbuffer });
}
pub fn bindTexture(target: Enum, texture: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBindTexture", .{ target, texture });
}
pub fn bindVertexArray(array: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBindVertexArray", .{array});
}
pub fn bitmap(width: Sizei, height: Sizei, xorig: Float, yorig: Float, xmove: Float, ymove: Float, bitmap_: [*c]const Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBitmap", .{ width, height, xorig, yorig, xmove, ymove, bitmap_ });
}
pub fn blendColor(red: Float, green: Float, blue: Float, alpha: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBlendColor", .{ red, green, blue, alpha });
}
pub fn blendEquation(mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBlendEquation", .{mode});
}
pub fn blendEquationSeparate(modeRGB: Enum, modeAlpha: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBlendEquationSeparate", .{ modeRGB, modeAlpha });
}
pub fn blendFunc(sfactor: Enum, dfactor: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBlendFunc", .{ sfactor, dfactor });
}
pub fn blendFuncSeparate(sfactorRGB: Enum, dfactorRGB: Enum, sfactorAlpha: Enum, dfactorAlpha: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBlendFuncSeparate", .{ sfactorRGB, dfactorRGB, sfactorAlpha, dfactorAlpha });
}
pub fn blitFramebuffer(srcX0: Int, srcY0: Int, srcX1: Int, srcY1: Int, dstX0: Int, dstY0: Int, dstX1: Int, dstY1: Int, mask: Bitfield, filter: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBlitFramebuffer", .{ srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter });
}
pub fn bufferData(target: Enum, size: Sizeiptr, data: ?*const anyopaque, usage: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBufferData", .{ target, size, data, usage });
}
pub fn bufferSubData(target: Enum, offset: Intptr, size: Sizeiptr, data: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glBufferSubData", .{ target, offset, size, data });
}
pub fn callList(list: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCallList", .{list});
}
pub fn callLists(n: Sizei, @"type": Enum, lists: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCallLists", .{ n, @"type", lists });
}
pub fn checkFramebufferStatus(target: Enum) callconv(.C) Enum {
    return DispatchTable.current.?.invokeIntercepted("glCheckFramebufferStatus", .{target});
}
pub fn clampColor(target: Enum, clamp: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClampColor", .{ target, clamp });
}
pub fn clear(mask: Bitfield) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClear", .{mask});
}
pub fn clearAccum(red: Float, green: Float, blue: Float, alpha: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClearAccum", .{ red, green, blue, alpha });
}
pub fn clearBufferfi(buffer: Enum, drawbuffer: Int, depth: Float, stencil: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClearBufferfi", .{ buffer, drawbuffer, depth, stencil });
}
pub fn clearBufferfv(buffer: Enum, drawbuffer: Int, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClearBufferfv", .{ buffer, drawbuffer, value });
}
pub fn clearBufferiv(buffer: Enum, drawbuffer: Int, value: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClearBufferiv", .{ buffer, drawbuffer, value });
}
pub fn clearBufferuiv(buffer: Enum, drawbuffer: Int, value: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClearBufferuiv", .{ buffer, drawbuffer, value });
}
pub fn clearColor(red: Float, green: Float, blue: Float, alpha: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClearColor", .{ red, green, blue, alpha });
}
pub fn clearDepth(depth: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClearDepth", .{depth});
}
pub fn clearIndex(c: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClearIndex", .{c});
}
pub fn clearStencil(s: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClearStencil", .{s});
}
pub fn clientActiveTexture(texture: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClientActiveTexture", .{texture});
}
pub fn clipPlane(plane: Enum, equation: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glClipPlane", .{ plane, equation });
}
pub fn color3b(red: Byte, green: Byte, blue: Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3b", .{ red, green, blue });
}
pub fn color3bv(v: [*c]const Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3bv", .{v});
}
pub fn color3d(red: Double, green: Double, blue: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3d", .{ red, green, blue });
}
pub fn color3dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3dv", .{v});
}
pub fn color3f(red: Float, green: Float, blue: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3f", .{ red, green, blue });
}
pub fn color3fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3fv", .{v});
}
pub fn color3i(red: Int, green: Int, blue: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3i", .{ red, green, blue });
}
pub fn color3iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3iv", .{v});
}
pub fn color3s(red: Short, green: Short, blue: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3s", .{ red, green, blue });
}
pub fn color3sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3sv", .{v});
}
pub fn color3ub(red: Ubyte, green: Ubyte, blue: Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3ub", .{ red, green, blue });
}
pub fn color3ubv(v: [*c]const Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3ubv", .{v});
}
pub fn color3ui(red: Uint, green: Uint, blue: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3ui", .{ red, green, blue });
}
pub fn color3uiv(v: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3uiv", .{v});
}
pub fn color3us(red: Ushort, green: Ushort, blue: Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3us", .{ red, green, blue });
}
pub fn color3usv(v: [*c]const Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor3usv", .{v});
}
pub fn color4b(red: Byte, green: Byte, blue: Byte, alpha: Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4b", .{ red, green, blue, alpha });
}
pub fn color4bv(v: [*c]const Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4bv", .{v});
}
pub fn color4d(red: Double, green: Double, blue: Double, alpha: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4d", .{ red, green, blue, alpha });
}
pub fn color4dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4dv", .{v});
}
pub fn color4f(red: Float, green: Float, blue: Float, alpha: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4f", .{ red, green, blue, alpha });
}
pub fn color4fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4fv", .{v});
}
pub fn color4i(red: Int, green: Int, blue: Int, alpha: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4i", .{ red, green, blue, alpha });
}
pub fn color4iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4iv", .{v});
}
pub fn color4s(red: Short, green: Short, blue: Short, alpha: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4s", .{ red, green, blue, alpha });
}
pub fn color4sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4sv", .{v});
}
pub fn color4ub(red: Ubyte, green: Ubyte, blue: Ubyte, alpha: Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4ub", .{ red, green, blue, alpha });
}
pub fn color4ubv(v: [*c]const Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4ubv", .{v});
}
pub fn color4ui(red: Uint, green: Uint, blue: Uint, alpha: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4ui", .{ red, green, blue, alpha });
}
pub fn color4uiv(v: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4uiv", .{v});
}
pub fn color4us(red: Ushort, green: Ushort, blue: Ushort, alpha: Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4us", .{ red, green, blue, alpha });
}
pub fn color4usv(v: [*c]const Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColor4usv", .{v});
}
pub fn colorMask(red: Boolean, green: Boolean, blue: Boolean, alpha: Boolean) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColorMask", .{ red, green, blue, alpha });
}
pub fn colorMaski(index: Uint, r: Boolean, g: Boolean, b: Boolean, a: Boolean) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColorMaski", .{ index, r, g, b, a });
}
pub fn colorMaterial(face: Enum, mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColorMaterial", .{ face, mode });
}
pub fn colorPointer(size: Int, @"type": Enum, stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glColorPointer", .{ size, @"type", stride, pointer });
}
pub fn compileShader(shader: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCompileShader", .{shader});
}
pub fn compressedTexImage1D(target: Enum, level: Int, internalformat: Enum, width: Sizei, border: Int, imageSize: Sizei, data: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCompressedTexImage1D", .{ target, level, internalformat, width, border, imageSize, data });
}
pub fn compressedTexImage2D(target: Enum, level: Int, internalformat: Enum, width: Sizei, height: Sizei, border: Int, imageSize: Sizei, data: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCompressedTexImage2D", .{ target, level, internalformat, width, height, border, imageSize, data });
}
pub fn compressedTexImage3D(target: Enum, level: Int, internalformat: Enum, width: Sizei, height: Sizei, depth: Sizei, border: Int, imageSize: Sizei, data: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCompressedTexImage3D", .{ target, level, internalformat, width, height, depth, border, imageSize, data });
}
pub fn compressedTexSubImage1D(target: Enum, level: Int, xoffset: Int, width: Sizei, format: Enum, imageSize: Sizei, data: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCompressedTexSubImage1D", .{ target, level, xoffset, width, format, imageSize, data });
}
pub fn compressedTexSubImage2D(target: Enum, level: Int, xoffset: Int, yoffset: Int, width: Sizei, height: Sizei, format: Enum, imageSize: Sizei, data: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCompressedTexSubImage2D", .{ target, level, xoffset, yoffset, width, height, format, imageSize, data });
}
pub fn compressedTexSubImage3D(target: Enum, level: Int, xoffset: Int, yoffset: Int, zoffset: Int, width: Sizei, height: Sizei, depth: Sizei, format: Enum, imageSize: Sizei, data: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCompressedTexSubImage3D", .{ target, level, xoffset, yoffset, zoffset, width, height, depth, format, imageSize, data });
}
pub fn copyBufferSubData(readTarget: Enum, writeTarget: Enum, readOffset: Intptr, writeOffset: Intptr, size: Sizeiptr) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCopyBufferSubData", .{ readTarget, writeTarget, readOffset, writeOffset, size });
}
pub fn copyPixels(x: Int, y: Int, width: Sizei, height: Sizei, @"type": Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCopyPixels", .{ x, y, width, height, @"type" });
}
pub fn copyTexImage1D(target: Enum, level: Int, internalformat: Enum, x: Int, y: Int, width: Sizei, border: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCopyTexImage1D", .{ target, level, internalformat, x, y, width, border });
}
pub fn copyTexImage2D(target: Enum, level: Int, internalformat: Enum, x: Int, y: Int, width: Sizei, height: Sizei, border: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCopyTexImage2D", .{ target, level, internalformat, x, y, width, height, border });
}
pub fn copyTexSubImage1D(target: Enum, level: Int, xoffset: Int, x: Int, y: Int, width: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCopyTexSubImage1D", .{ target, level, xoffset, x, y, width });
}
pub fn copyTexSubImage2D(target: Enum, level: Int, xoffset: Int, yoffset: Int, x: Int, y: Int, width: Sizei, height: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCopyTexSubImage2D", .{ target, level, xoffset, yoffset, x, y, width, height });
}
pub fn copyTexSubImage3D(target: Enum, level: Int, xoffset: Int, yoffset: Int, zoffset: Int, x: Int, y: Int, width: Sizei, height: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCopyTexSubImage3D", .{ target, level, xoffset, yoffset, zoffset, x, y, width, height });
}
pub fn createProgram() callconv(.C) Uint {
    return DispatchTable.current.?.invokeIntercepted("glCreateProgram", .{});
}
pub fn createShader(@"type": Enum) callconv(.C) Uint {
    return DispatchTable.current.?.invokeIntercepted("glCreateShader", .{@"type"});
}
pub fn cullFace(mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glCullFace", .{mode});
}
pub fn deleteBuffers(n: Sizei, buffers: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDeleteBuffers", .{ n, buffers });
}
pub fn deleteFramebuffers(n: Sizei, framebuffers: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDeleteFramebuffers", .{ n, framebuffers });
}
pub fn deleteLists(list: Uint, range: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDeleteLists", .{ list, range });
}
pub fn deleteProgram(program: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDeleteProgram", .{program});
}
pub fn deleteQueries(n: Sizei, ids: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDeleteQueries", .{ n, ids });
}
pub fn deleteRenderbuffers(n: Sizei, renderbuffers: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDeleteRenderbuffers", .{ n, renderbuffers });
}
pub fn deleteShader(shader: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDeleteShader", .{shader});
}
pub fn deleteTextures(n: Sizei, textures: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDeleteTextures", .{ n, textures });
}
pub fn deleteVertexArrays(n: Sizei, arrays: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDeleteVertexArrays", .{ n, arrays });
}
pub fn depthFunc(func: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDepthFunc", .{func});
}
pub fn depthMask(flag: Boolean) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDepthMask", .{flag});
}
pub fn depthRange(n: Double, f: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDepthRange", .{ n, f });
}
pub fn detachShader(program: Uint, shader: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDetachShader", .{ program, shader });
}
pub fn disable(cap: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDisable", .{cap});
}
pub fn disableClientState(array: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDisableClientState", .{array});
}
pub fn disableVertexAttribArray(index: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDisableVertexAttribArray", .{index});
}
pub fn disablei(target: Enum, index: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDisablei", .{ target, index });
}
pub fn drawArrays(mode: Enum, first: Int, count: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDrawArrays", .{ mode, first, count });
}
pub fn drawArraysInstanced(mode: Enum, first: Int, count: Sizei, instancecount: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDrawArraysInstanced", .{ mode, first, count, instancecount });
}
pub fn drawBuffer(buf: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDrawBuffer", .{buf});
}
pub fn drawBuffers(n: Sizei, bufs: [*c]const Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDrawBuffers", .{ n, bufs });
}
pub fn drawElements(mode: Enum, count: Sizei, @"type": Enum, indices: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDrawElements", .{ mode, count, @"type", indices });
}
pub fn drawElementsInstanced(mode: Enum, count: Sizei, @"type": Enum, indices: ?*const anyopaque, instancecount: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDrawElementsInstanced", .{ mode, count, @"type", indices, instancecount });
}
pub fn drawPixels(width: Sizei, height: Sizei, format: Enum, @"type": Enum, pixels: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDrawPixels", .{ width, height, format, @"type", pixels });
}
pub fn drawRangeElements(mode: Enum, start: Uint, end_: Uint, count: Sizei, @"type": Enum, indices: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glDrawRangeElements", .{ mode, start, end_, count, @"type", indices });
}
pub fn edgeFlag(flag: Boolean) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEdgeFlag", .{flag});
}
pub fn edgeFlagPointer(stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEdgeFlagPointer", .{ stride, pointer });
}
pub fn edgeFlagv(flag: [*c]const Boolean) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEdgeFlagv", .{flag});
}
pub fn enable(cap: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEnable", .{cap});
}
pub fn enableClientState(array: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEnableClientState", .{array});
}
pub fn enableVertexAttribArray(index: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEnableVertexAttribArray", .{index});
}
pub fn enablei(target: Enum, index: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEnablei", .{ target, index });
}
pub fn end() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEnd", .{});
}
pub fn endConditionalRender() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEndConditionalRender", .{});
}
pub fn endList() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEndList", .{});
}
pub fn endQuery(target: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEndQuery", .{target});
}
pub fn endTransformFeedback() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEndTransformFeedback", .{});
}
pub fn evalCoord1d(u: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalCoord1d", .{u});
}
pub fn evalCoord1dv(u: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalCoord1dv", .{u});
}
pub fn evalCoord1f(u: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalCoord1f", .{u});
}
pub fn evalCoord1fv(u: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalCoord1fv", .{u});
}
pub fn evalCoord2d(u: Double, v: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalCoord2d", .{ u, v });
}
pub fn evalCoord2dv(u: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalCoord2dv", .{u});
}
pub fn evalCoord2f(u: Float, v: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalCoord2f", .{ u, v });
}
pub fn evalCoord2fv(u: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalCoord2fv", .{u});
}
pub fn evalMesh1(mode: Enum, @"i1": Int, @"i2": Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalMesh1", .{ mode, @"i1", @"i2" });
}
pub fn evalMesh2(mode: Enum, @"i1": Int, @"i2": Int, j1: Int, j2: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalMesh2", .{ mode, @"i1", @"i2", j1, j2 });
}
pub fn evalPoint1(i: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalPoint1", .{i});
}
pub fn evalPoint2(i: Int, j: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glEvalPoint2", .{ i, j });
}
pub fn feedbackBuffer(size: Sizei, @"type": Enum, buffer: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFeedbackBuffer", .{ size, @"type", buffer });
}
pub fn finish() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFinish", .{});
}
pub fn flush() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFlush", .{});
}
pub fn flushMappedBufferRange(target: Enum, offset: Intptr, length: Sizeiptr) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFlushMappedBufferRange", .{ target, offset, length });
}
pub fn fogCoordPointer(@"type": Enum, stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFogCoordPointer", .{ @"type", stride, pointer });
}
pub fn fogCoordd(coord: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFogCoordd", .{coord});
}
pub fn fogCoorddv(coord: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFogCoorddv", .{coord});
}
pub fn fogCoordf(coord: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFogCoordf", .{coord});
}
pub fn fogCoordfv(coord: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFogCoordfv", .{coord});
}
pub fn fogf(pname: Enum, param: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFogf", .{ pname, param });
}
pub fn fogfv(pname: Enum, params: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFogfv", .{ pname, params });
}
pub fn fogi(pname: Enum, param: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFogi", .{ pname, param });
}
pub fn fogiv(pname: Enum, params: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFogiv", .{ pname, params });
}
pub fn framebufferRenderbuffer(target: Enum, attachment: Enum, renderbuffertarget: Enum, renderbuffer: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFramebufferRenderbuffer", .{ target, attachment, renderbuffertarget, renderbuffer });
}
pub fn framebufferTexture1D(target: Enum, attachment: Enum, textarget: Enum, texture: Uint, level: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFramebufferTexture1D", .{ target, attachment, textarget, texture, level });
}
pub fn framebufferTexture2D(target: Enum, attachment: Enum, textarget: Enum, texture: Uint, level: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFramebufferTexture2D", .{ target, attachment, textarget, texture, level });
}
pub fn framebufferTexture3D(target: Enum, attachment: Enum, textarget: Enum, texture: Uint, level: Int, zoffset: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFramebufferTexture3D", .{ target, attachment, textarget, texture, level, zoffset });
}
pub fn framebufferTextureLayer(target: Enum, attachment: Enum, texture: Uint, level: Int, layer: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFramebufferTextureLayer", .{ target, attachment, texture, level, layer });
}
pub fn frontFace(mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFrontFace", .{mode});
}
pub fn frustum(left: Double, right: Double, bottom: Double, top: Double, zNear: Double, zFar: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glFrustum", .{ left, right, bottom, top, zNear, zFar });
}
pub fn genBuffers(n: Sizei, buffers: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGenBuffers", .{ n, buffers });
}
pub fn genFramebuffers(n: Sizei, framebuffers: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGenFramebuffers", .{ n, framebuffers });
}
pub fn genLists(range: Sizei) callconv(.C) Uint {
    return DispatchTable.current.?.invokeIntercepted("glGenLists", .{range});
}
pub fn genQueries(n: Sizei, ids: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGenQueries", .{ n, ids });
}
pub fn genRenderbuffers(n: Sizei, renderbuffers: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGenRenderbuffers", .{ n, renderbuffers });
}
pub fn genTextures(n: Sizei, textures: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGenTextures", .{ n, textures });
}
pub fn genVertexArrays(n: Sizei, arrays: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGenVertexArrays", .{ n, arrays });
}
pub fn generateMipmap(target: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGenerateMipmap", .{target});
}
pub fn getActiveAttrib(program: Uint, index: Uint, bufSize: Sizei, length: [*c]Sizei, size: [*c]Int, @"type": [*c]Enum, name: [*c]Char) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetActiveAttrib", .{ program, index, bufSize, length, size, @"type", name });
}
pub fn getActiveUniform(program: Uint, index: Uint, bufSize: Sizei, length: [*c]Sizei, size: [*c]Int, @"type": [*c]Enum, name: [*c]Char) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetActiveUniform", .{ program, index, bufSize, length, size, @"type", name });
}
pub fn getActiveUniformBlockName(program: Uint, uniformBlockIndex: Uint, bufSize: Sizei, length: [*c]Sizei, uniformBlockName: [*c]Char) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetActiveUniformBlockName", .{ program, uniformBlockIndex, bufSize, length, uniformBlockName });
}
pub fn getActiveUniformBlockiv(program: Uint, uniformBlockIndex: Uint, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetActiveUniformBlockiv", .{ program, uniformBlockIndex, pname, params });
}
pub fn getActiveUniformName(program: Uint, uniformIndex: Uint, bufSize: Sizei, length: [*c]Sizei, uniformName: [*c]Char) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetActiveUniformName", .{ program, uniformIndex, bufSize, length, uniformName });
}
pub fn getActiveUniformsiv(program: Uint, uniformCount: Sizei, uniformIndices: [*c]const Uint, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetActiveUniformsiv", .{ program, uniformCount, uniformIndices, pname, params });
}
pub fn getAttachedShaders(program: Uint, maxCount: Sizei, count: [*c]Sizei, shaders: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetAttachedShaders", .{ program, maxCount, count, shaders });
}
pub fn getAttribLocation(program: Uint, name: [*c]const Char) callconv(.C) Int {
    return DispatchTable.current.?.invokeIntercepted("glGetAttribLocation", .{ program, name });
}
pub fn getBooleani_v(target: Enum, index: Uint, data: [*c]Boolean) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetBooleani_v", .{ target, index, data });
}
pub fn getBooleanv(pname: Enum, data: [*c]Boolean) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetBooleanv", .{ pname, data });
}
pub fn getBufferParameteriv(target: Enum, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetBufferParameteriv", .{ target, pname, params });
}
pub fn getBufferPointerv(target: Enum, pname: Enum, params: [*c]?*anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetBufferPointerv", .{ target, pname, params });
}
pub fn getBufferSubData(target: Enum, offset: Intptr, size: Sizeiptr, data: ?*anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetBufferSubData", .{ target, offset, size, data });
}
pub fn getClipPlane(plane: Enum, equation: [*c]Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetClipPlane", .{ plane, equation });
}
pub fn getCompressedTexImage(target: Enum, level: Int, img: ?*anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetCompressedTexImage", .{ target, level, img });
}
pub fn getDoublev(pname: Enum, data: [*c]Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetDoublev", .{ pname, data });
}
pub fn getError() callconv(.C) Enum {
    return DispatchTable.current.?.invokeIntercepted("glGetError", .{});
}
pub fn getFloatv(pname: Enum, data: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetFloatv", .{ pname, data });
}
pub fn getFragDataLocation(program: Uint, name: [*c]const Char) callconv(.C) Int {
    return DispatchTable.current.?.invokeIntercepted("glGetFragDataLocation", .{ program, name });
}
pub fn getFramebufferAttachmentParameteriv(target: Enum, attachment: Enum, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetFramebufferAttachmentParameteriv", .{ target, attachment, pname, params });
}
pub fn getIntegeri_v(target: Enum, index: Uint, data: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetIntegeri_v", .{ target, index, data });
}
pub fn getIntegerv(pname: Enum, data: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetIntegerv", .{ pname, data });
}
pub fn getLightfv(light: Enum, pname: Enum, params: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetLightfv", .{ light, pname, params });
}
pub fn getLightiv(light: Enum, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetLightiv", .{ light, pname, params });
}
pub fn getMapdv(target: Enum, query: Enum, v: [*c]Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetMapdv", .{ target, query, v });
}
pub fn getMapfv(target: Enum, query: Enum, v: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetMapfv", .{ target, query, v });
}
pub fn getMapiv(target: Enum, query: Enum, v: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetMapiv", .{ target, query, v });
}
pub fn getMaterialfv(face: Enum, pname: Enum, params: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetMaterialfv", .{ face, pname, params });
}
pub fn getMaterialiv(face: Enum, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetMaterialiv", .{ face, pname, params });
}
pub fn getPixelMapfv(map: Enum, values: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetPixelMapfv", .{ map, values });
}
pub fn getPixelMapuiv(map: Enum, values: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetPixelMapuiv", .{ map, values });
}
pub fn getPixelMapusv(map: Enum, values: [*c]Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetPixelMapusv", .{ map, values });
}
pub fn getPointerv(pname: Enum, params: [*c]?*anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetPointerv", .{ pname, params });
}
pub fn getPolygonStipple(mask: [*c]Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetPolygonStipple", .{mask});
}
pub fn getProgramInfoLog(program: Uint, bufSize: Sizei, length: [*c]Sizei, infoLog: [*c]Char) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetProgramInfoLog", .{ program, bufSize, length, infoLog });
}
pub fn getProgramiv(program: Uint, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetProgramiv", .{ program, pname, params });
}
pub fn getQueryObjectiv(id: Uint, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetQueryObjectiv", .{ id, pname, params });
}
pub fn getQueryObjectuiv(id: Uint, pname: Enum, params: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetQueryObjectuiv", .{ id, pname, params });
}
pub fn getQueryiv(target: Enum, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetQueryiv", .{ target, pname, params });
}
pub fn getRenderbufferParameteriv(target: Enum, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetRenderbufferParameteriv", .{ target, pname, params });
}
pub fn getShaderInfoLog(shader: Uint, bufSize: Sizei, length: [*c]Sizei, infoLog: [*c]Char) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetShaderInfoLog", .{ shader, bufSize, length, infoLog });
}
pub fn getShaderSource(shader: Uint, bufSize: Sizei, length: [*c]Sizei, source: [*c]Char) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetShaderSource", .{ shader, bufSize, length, source });
}
pub fn getShaderiv(shader: Uint, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetShaderiv", .{ shader, pname, params });
}
pub fn getString(name: Enum) callconv(.C) [*c]const Ubyte {
    return DispatchTable.current.?.invokeIntercepted("glGetString", .{name});
}
pub fn getStringi(name: Enum, index: Uint) callconv(.C) [*c]const Ubyte {
    return DispatchTable.current.?.invokeIntercepted("glGetStringi", .{ name, index });
}
pub fn getTexEnvfv(target: Enum, pname: Enum, params: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexEnvfv", .{ target, pname, params });
}
pub fn getTexEnviv(target: Enum, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexEnviv", .{ target, pname, params });
}
pub fn getTexGendv(coord: Enum, pname: Enum, params: [*c]Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexGendv", .{ coord, pname, params });
}
pub fn getTexGenfv(coord: Enum, pname: Enum, params: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexGenfv", .{ coord, pname, params });
}
pub fn getTexGeniv(coord: Enum, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexGeniv", .{ coord, pname, params });
}
pub fn getTexImage(target: Enum, level: Int, format: Enum, @"type": Enum, pixels: ?*anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexImage", .{ target, level, format, @"type", pixels });
}
pub fn getTexLevelParameterfv(target: Enum, level: Int, pname: Enum, params: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexLevelParameterfv", .{ target, level, pname, params });
}
pub fn getTexLevelParameteriv(target: Enum, level: Int, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexLevelParameteriv", .{ target, level, pname, params });
}
pub fn getTexParameterIiv(target: Enum, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexParameterIiv", .{ target, pname, params });
}
pub fn getTexParameterIuiv(target: Enum, pname: Enum, params: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexParameterIuiv", .{ target, pname, params });
}
pub fn getTexParameterfv(target: Enum, pname: Enum, params: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexParameterfv", .{ target, pname, params });
}
pub fn getTexParameteriv(target: Enum, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTexParameteriv", .{ target, pname, params });
}
pub fn getTransformFeedbackVarying(program: Uint, index: Uint, bufSize: Sizei, length: [*c]Sizei, size: [*c]Sizei, @"type": [*c]Enum, name: [*c]Char) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetTransformFeedbackVarying", .{ program, index, bufSize, length, size, @"type", name });
}
pub fn getUniformBlockIndex(program: Uint, uniformBlockName: [*c]const Char) callconv(.C) Uint {
    return DispatchTable.current.?.invokeIntercepted("glGetUniformBlockIndex", .{ program, uniformBlockName });
}
pub fn getUniformIndices(program: Uint, uniformCount: Sizei, uniformNames: [*c]const [*c]const Char, uniformIndices: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetUniformIndices", .{ program, uniformCount, uniformNames, uniformIndices });
}
pub fn getUniformLocation(program: Uint, name: [*c]const Char) callconv(.C) Int {
    return DispatchTable.current.?.invokeIntercepted("glGetUniformLocation", .{ program, name });
}
pub fn getUniformfv(program: Uint, location: Int, params: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetUniformfv", .{ program, location, params });
}
pub fn getUniformiv(program: Uint, location: Int, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetUniformiv", .{ program, location, params });
}
pub fn getUniformuiv(program: Uint, location: Int, params: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetUniformuiv", .{ program, location, params });
}
pub fn getVertexAttribIiv(index: Uint, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetVertexAttribIiv", .{ index, pname, params });
}
pub fn getVertexAttribIuiv(index: Uint, pname: Enum, params: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetVertexAttribIuiv", .{ index, pname, params });
}
pub fn getVertexAttribPointerv(index: Uint, pname: Enum, pointer: [*c]?*anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetVertexAttribPointerv", .{ index, pname, pointer });
}
pub fn getVertexAttribdv(index: Uint, pname: Enum, params: [*c]Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetVertexAttribdv", .{ index, pname, params });
}
pub fn getVertexAttribfv(index: Uint, pname: Enum, params: [*c]Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetVertexAttribfv", .{ index, pname, params });
}
pub fn getVertexAttribiv(index: Uint, pname: Enum, params: [*c]Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glGetVertexAttribiv", .{ index, pname, params });
}
pub fn hint(target: Enum, mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glHint", .{ target, mode });
}
pub fn indexMask(mask: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexMask", .{mask});
}
pub fn indexPointer(@"type": Enum, stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexPointer", .{ @"type", stride, pointer });
}
pub fn indexd(c: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexd", .{c});
}
pub fn indexdv(c: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexdv", .{c});
}
pub fn indexf(c: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexf", .{c});
}
pub fn indexfv(c: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexfv", .{c});
}
pub fn indexi(c: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexi", .{c});
}
pub fn indexiv(c: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexiv", .{c});
}
pub fn indexs(c: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexs", .{c});
}
pub fn indexsv(c: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexsv", .{c});
}
pub fn indexub(c: Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexub", .{c});
}
pub fn indexubv(c: [*c]const Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glIndexubv", .{c});
}
pub fn initNames() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glInitNames", .{});
}
pub fn interleavedArrays(format: Enum, stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glInterleavedArrays", .{ format, stride, pointer });
}
pub fn isBuffer(buffer: Uint) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsBuffer", .{buffer});
}
pub fn isEnabled(cap: Enum) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsEnabled", .{cap});
}
pub fn isEnabledi(target: Enum, index: Uint) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsEnabledi", .{ target, index });
}
pub fn isFramebuffer(framebuffer: Uint) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsFramebuffer", .{framebuffer});
}
pub fn isList(list: Uint) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsList", .{list});
}
pub fn isProgram(program: Uint) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsProgram", .{program});
}
pub fn isQuery(id: Uint) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsQuery", .{id});
}
pub fn isRenderbuffer(renderbuffer: Uint) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsRenderbuffer", .{renderbuffer});
}
pub fn isShader(shader: Uint) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsShader", .{shader});
}
pub fn isTexture(texture: Uint) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsTexture", .{texture});
}
pub fn isVertexArray(array: Uint) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glIsVertexArray", .{array});
}
pub fn lightModelf(pname: Enum, param: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLightModelf", .{ pname, param });
}
pub fn lightModelfv(pname: Enum, params: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLightModelfv", .{ pname, params });
}
pub fn lightModeli(pname: Enum, param: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLightModeli", .{ pname, param });
}
pub fn lightModeliv(pname: Enum, params: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLightModeliv", .{ pname, params });
}
pub fn lightf(light: Enum, pname: Enum, param: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLightf", .{ light, pname, param });
}
pub fn lightfv(light: Enum, pname: Enum, params: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLightfv", .{ light, pname, params });
}
pub fn lighti(light: Enum, pname: Enum, param: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLighti", .{ light, pname, param });
}
pub fn lightiv(light: Enum, pname: Enum, params: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLightiv", .{ light, pname, params });
}
pub fn lineStipple(factor: Int, pattern: Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLineStipple", .{ factor, pattern });
}
pub fn lineWidth(width: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLineWidth", .{width});
}
pub fn linkProgram(program: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLinkProgram", .{program});
}
pub fn listBase(base: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glListBase", .{base});
}
pub fn loadIdentity() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLoadIdentity", .{});
}
pub fn loadMatrixd(m: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLoadMatrixd", .{m});
}
pub fn loadMatrixf(m: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLoadMatrixf", .{m});
}
pub fn loadName(name: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLoadName", .{name});
}
pub fn loadTransposeMatrixd(m: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLoadTransposeMatrixd", .{m});
}
pub fn loadTransposeMatrixf(m: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLoadTransposeMatrixf", .{m});
}
pub fn logicOp(opcode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glLogicOp", .{opcode});
}
pub fn map1d(target: Enum, @"u1": Double, @"u2": Double, stride: Int, order: Int, points: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMap1d", .{ target, @"u1", @"u2", stride, order, points });
}
pub fn map1f(target: Enum, @"u1": Float, @"u2": Float, stride: Int, order: Int, points: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMap1f", .{ target, @"u1", @"u2", stride, order, points });
}
pub fn map2d(target: Enum, @"u1": Double, @"u2": Double, ustride: Int, uorder: Int, v1: Double, v2: Double, vstride: Int, vorder: Int, points: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMap2d", .{ target, @"u1", @"u2", ustride, uorder, v1, v2, vstride, vorder, points });
}
pub fn map2f(target: Enum, @"u1": Float, @"u2": Float, ustride: Int, uorder: Int, v1: Float, v2: Float, vstride: Int, vorder: Int, points: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMap2f", .{ target, @"u1", @"u2", ustride, uorder, v1, v2, vstride, vorder, points });
}
pub fn mapBuffer(target: Enum, access: Enum) callconv(.C) ?*anyopaque {
    return DispatchTable.current.?.invokeIntercepted("glMapBuffer", .{ target, access });
}
pub fn mapBufferRange(target: Enum, offset: Intptr, length: Sizeiptr, access: Bitfield) callconv(.C) ?*anyopaque {
    return DispatchTable.current.?.invokeIntercepted("glMapBufferRange", .{ target, offset, length, access });
}
pub fn mapGrid1d(un: Int, @"u1": Double, @"u2": Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMapGrid1d", .{ un, @"u1", @"u2" });
}
pub fn mapGrid1f(un: Int, @"u1": Float, @"u2": Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMapGrid1f", .{ un, @"u1", @"u2" });
}
pub fn mapGrid2d(un: Int, @"u1": Double, @"u2": Double, vn: Int, v1: Double, v2: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMapGrid2d", .{ un, @"u1", @"u2", vn, v1, v2 });
}
pub fn mapGrid2f(un: Int, @"u1": Float, @"u2": Float, vn: Int, v1: Float, v2: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMapGrid2f", .{ un, @"u1", @"u2", vn, v1, v2 });
}
pub fn materialf(face: Enum, pname: Enum, param: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMaterialf", .{ face, pname, param });
}
pub fn materialfv(face: Enum, pname: Enum, params: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMaterialfv", .{ face, pname, params });
}
pub fn materiali(face: Enum, pname: Enum, param: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMateriali", .{ face, pname, param });
}
pub fn materialiv(face: Enum, pname: Enum, params: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMaterialiv", .{ face, pname, params });
}
pub fn matrixMode(mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMatrixMode", .{mode});
}
pub fn multMatrixd(m: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultMatrixd", .{m});
}
pub fn multMatrixf(m: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultMatrixf", .{m});
}
pub fn multTransposeMatrixd(m: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultTransposeMatrixd", .{m});
}
pub fn multTransposeMatrixf(m: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultTransposeMatrixf", .{m});
}
pub fn multiDrawArrays(mode: Enum, first: [*c]const Int, count: [*c]const Sizei, drawcount: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiDrawArrays", .{ mode, first, count, drawcount });
}
pub fn multiDrawElements(mode: Enum, count: [*c]const Sizei, @"type": Enum, indices: [*c]const ?*const anyopaque, drawcount: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiDrawElements", .{ mode, count, @"type", indices, drawcount });
}
pub fn multiTexCoord1d(target: Enum, s: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord1d", .{ target, s });
}
pub fn multiTexCoord1dv(target: Enum, v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord1dv", .{ target, v });
}
pub fn multiTexCoord1f(target: Enum, s: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord1f", .{ target, s });
}
pub fn multiTexCoord1fv(target: Enum, v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord1fv", .{ target, v });
}
pub fn multiTexCoord1i(target: Enum, s: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord1i", .{ target, s });
}
pub fn multiTexCoord1iv(target: Enum, v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord1iv", .{ target, v });
}
pub fn multiTexCoord1s(target: Enum, s: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord1s", .{ target, s });
}
pub fn multiTexCoord1sv(target: Enum, v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord1sv", .{ target, v });
}
pub fn multiTexCoord2d(target: Enum, s: Double, t: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord2d", .{ target, s, t });
}
pub fn multiTexCoord2dv(target: Enum, v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord2dv", .{ target, v });
}
pub fn multiTexCoord2f(target: Enum, s: Float, t: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord2f", .{ target, s, t });
}
pub fn multiTexCoord2fv(target: Enum, v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord2fv", .{ target, v });
}
pub fn multiTexCoord2i(target: Enum, s: Int, t: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord2i", .{ target, s, t });
}
pub fn multiTexCoord2iv(target: Enum, v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord2iv", .{ target, v });
}
pub fn multiTexCoord2s(target: Enum, s: Short, t: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord2s", .{ target, s, t });
}
pub fn multiTexCoord2sv(target: Enum, v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord2sv", .{ target, v });
}
pub fn multiTexCoord3d(target: Enum, s: Double, t: Double, r: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord3d", .{ target, s, t, r });
}
pub fn multiTexCoord3dv(target: Enum, v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord3dv", .{ target, v });
}
pub fn multiTexCoord3f(target: Enum, s: Float, t: Float, r: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord3f", .{ target, s, t, r });
}
pub fn multiTexCoord3fv(target: Enum, v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord3fv", .{ target, v });
}
pub fn multiTexCoord3i(target: Enum, s: Int, t: Int, r: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord3i", .{ target, s, t, r });
}
pub fn multiTexCoord3iv(target: Enum, v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord3iv", .{ target, v });
}
pub fn multiTexCoord3s(target: Enum, s: Short, t: Short, r: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord3s", .{ target, s, t, r });
}
pub fn multiTexCoord3sv(target: Enum, v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord3sv", .{ target, v });
}
pub fn multiTexCoord4d(target: Enum, s: Double, t: Double, r: Double, q: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord4d", .{ target, s, t, r, q });
}
pub fn multiTexCoord4dv(target: Enum, v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord4dv", .{ target, v });
}
pub fn multiTexCoord4f(target: Enum, s: Float, t: Float, r: Float, q: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord4f", .{ target, s, t, r, q });
}
pub fn multiTexCoord4fv(target: Enum, v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord4fv", .{ target, v });
}
pub fn multiTexCoord4i(target: Enum, s: Int, t: Int, r: Int, q: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord4i", .{ target, s, t, r, q });
}
pub fn multiTexCoord4iv(target: Enum, v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord4iv", .{ target, v });
}
pub fn multiTexCoord4s(target: Enum, s: Short, t: Short, r: Short, q: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord4s", .{ target, s, t, r, q });
}
pub fn multiTexCoord4sv(target: Enum, v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glMultiTexCoord4sv", .{ target, v });
}
pub fn newList(list: Uint, mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNewList", .{ list, mode });
}
pub fn normal3b(nx: Byte, ny: Byte, nz: Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormal3b", .{ nx, ny, nz });
}
pub fn normal3bv(v: [*c]const Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormal3bv", .{v});
}
pub fn normal3d(nx: Double, ny: Double, nz: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormal3d", .{ nx, ny, nz });
}
pub fn normal3dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormal3dv", .{v});
}
pub fn normal3f(nx: Float, ny: Float, nz: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormal3f", .{ nx, ny, nz });
}
pub fn normal3fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormal3fv", .{v});
}
pub fn normal3i(nx: Int, ny: Int, nz: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormal3i", .{ nx, ny, nz });
}
pub fn normal3iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormal3iv", .{v});
}
pub fn normal3s(nx: Short, ny: Short, nz: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormal3s", .{ nx, ny, nz });
}
pub fn normal3sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormal3sv", .{v});
}
pub fn normalPointer(@"type": Enum, stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glNormalPointer", .{ @"type", stride, pointer });
}
pub fn ortho(left: Double, right: Double, bottom: Double, top: Double, zNear: Double, zFar: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glOrtho", .{ left, right, bottom, top, zNear, zFar });
}
pub fn passThrough(token: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPassThrough", .{token});
}
pub fn pixelMapfv(map: Enum, mapsize: Sizei, values: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPixelMapfv", .{ map, mapsize, values });
}
pub fn pixelMapuiv(map: Enum, mapsize: Sizei, values: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPixelMapuiv", .{ map, mapsize, values });
}
pub fn pixelMapusv(map: Enum, mapsize: Sizei, values: [*c]const Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPixelMapusv", .{ map, mapsize, values });
}
pub fn pixelStoref(pname: Enum, param: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPixelStoref", .{ pname, param });
}
pub fn pixelStorei(pname: Enum, param: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPixelStorei", .{ pname, param });
}
pub fn pixelTransferf(pname: Enum, param: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPixelTransferf", .{ pname, param });
}
pub fn pixelTransferi(pname: Enum, param: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPixelTransferi", .{ pname, param });
}
pub fn pixelZoom(xfactor: Float, yfactor: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPixelZoom", .{ xfactor, yfactor });
}
pub fn pointParameterf(pname: Enum, param: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPointParameterf", .{ pname, param });
}
pub fn pointParameterfv(pname: Enum, params: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPointParameterfv", .{ pname, params });
}
pub fn pointParameteri(pname: Enum, param: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPointParameteri", .{ pname, param });
}
pub fn pointParameteriv(pname: Enum, params: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPointParameteriv", .{ pname, params });
}
pub fn pointSize(size: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPointSize", .{size});
}
pub fn polygonMode(face: Enum, mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPolygonMode", .{ face, mode });
}
pub fn polygonOffset(factor: Float, units: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPolygonOffset", .{ factor, units });
}
pub fn polygonStipple(mask: [*c]const Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPolygonStipple", .{mask});
}
pub fn popAttrib() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPopAttrib", .{});
}
pub fn popClientAttrib() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPopClientAttrib", .{});
}
pub fn popMatrix() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPopMatrix", .{});
}
pub fn popName() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPopName", .{});
}
pub fn primitiveRestartIndex(index: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPrimitiveRestartIndex", .{index});
}
pub fn prioritizeTextures(n: Sizei, textures: [*c]const Uint, priorities: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPrioritizeTextures", .{ n, textures, priorities });
}
pub fn pushAttrib(mask: Bitfield) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPushAttrib", .{mask});
}
pub fn pushClientAttrib(mask: Bitfield) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPushClientAttrib", .{mask});
}
pub fn pushMatrix() callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPushMatrix", .{});
}
pub fn pushName(name: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glPushName", .{name});
}
pub fn rasterPos2d(x: Double, y: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos2d", .{ x, y });
}
pub fn rasterPos2dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos2dv", .{v});
}
pub fn rasterPos2f(x: Float, y: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos2f", .{ x, y });
}
pub fn rasterPos2fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos2fv", .{v});
}
pub fn rasterPos2i(x: Int, y: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos2i", .{ x, y });
}
pub fn rasterPos2iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos2iv", .{v});
}
pub fn rasterPos2s(x: Short, y: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos2s", .{ x, y });
}
pub fn rasterPos2sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos2sv", .{v});
}
pub fn rasterPos3d(x: Double, y: Double, z: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos3d", .{ x, y, z });
}
pub fn rasterPos3dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos3dv", .{v});
}
pub fn rasterPos3f(x: Float, y: Float, z: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos3f", .{ x, y, z });
}
pub fn rasterPos3fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos3fv", .{v});
}
pub fn rasterPos3i(x: Int, y: Int, z: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos3i", .{ x, y, z });
}
pub fn rasterPos3iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos3iv", .{v});
}
pub fn rasterPos3s(x: Short, y: Short, z: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos3s", .{ x, y, z });
}
pub fn rasterPos3sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos3sv", .{v});
}
pub fn rasterPos4d(x: Double, y: Double, z: Double, w: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos4d", .{ x, y, z, w });
}
pub fn rasterPos4dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos4dv", .{v});
}
pub fn rasterPos4f(x: Float, y: Float, z: Float, w: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos4f", .{ x, y, z, w });
}
pub fn rasterPos4fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos4fv", .{v});
}
pub fn rasterPos4i(x: Int, y: Int, z: Int, w: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos4i", .{ x, y, z, w });
}
pub fn rasterPos4iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos4iv", .{v});
}
pub fn rasterPos4s(x: Short, y: Short, z: Short, w: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos4s", .{ x, y, z, w });
}
pub fn rasterPos4sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRasterPos4sv", .{v});
}
pub fn readBuffer(src: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glReadBuffer", .{src});
}
pub fn readPixels(x: Int, y: Int, width: Sizei, height: Sizei, format: Enum, @"type": Enum, pixels: ?*anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glReadPixels", .{ x, y, width, height, format, @"type", pixels });
}
pub fn rectd(x1: Double, y1: Double, x2: Double, y2: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRectd", .{ x1, y1, x2, y2 });
}
pub fn rectdv(v1: [*c]const Double, v2: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRectdv", .{ v1, v2 });
}
pub fn rectf(x1: Float, y1: Float, x2: Float, y2: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRectf", .{ x1, y1, x2, y2 });
}
pub fn rectfv(v1: [*c]const Float, v2: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRectfv", .{ v1, v2 });
}
pub fn recti(x1: Int, y1: Int, x2: Int, y2: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRecti", .{ x1, y1, x2, y2 });
}
pub fn rectiv(v1: [*c]const Int, v2: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRectiv", .{ v1, v2 });
}
pub fn rects(x1: Short, y1: Short, x2: Short, y2: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRects", .{ x1, y1, x2, y2 });
}
pub fn rectsv(v1: [*c]const Short, v2: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRectsv", .{ v1, v2 });
}
pub fn renderMode(mode: Enum) callconv(.C) Int {
    return DispatchTable.current.?.invokeIntercepted("glRenderMode", .{mode});
}
pub fn renderbufferStorage(target: Enum, internalformat: Enum, width: Sizei, height: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRenderbufferStorage", .{ target, internalformat, width, height });
}
pub fn renderbufferStorageMultisample(target: Enum, samples: Sizei, internalformat: Enum, width: Sizei, height: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRenderbufferStorageMultisample", .{ target, samples, internalformat, width, height });
}
pub fn rotated(angle: Double, x: Double, y: Double, z: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRotated", .{ angle, x, y, z });
}
pub fn rotatef(angle: Float, x: Float, y: Float, z: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glRotatef", .{ angle, x, y, z });
}
pub fn sampleCoverage(value: Float, invert: Boolean) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSampleCoverage", .{ value, invert });
}
pub fn scaled(x: Double, y: Double, z: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glScaled", .{ x, y, z });
}
pub fn scalef(x: Float, y: Float, z: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glScalef", .{ x, y, z });
}
pub fn scissor(x: Int, y: Int, width: Sizei, height: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glScissor", .{ x, y, width, height });
}
pub fn secondaryColor3b(red: Byte, green: Byte, blue: Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3b", .{ red, green, blue });
}
pub fn secondaryColor3bv(v: [*c]const Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3bv", .{v});
}
pub fn secondaryColor3d(red: Double, green: Double, blue: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3d", .{ red, green, blue });
}
pub fn secondaryColor3dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3dv", .{v});
}
pub fn secondaryColor3f(red: Float, green: Float, blue: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3f", .{ red, green, blue });
}
pub fn secondaryColor3fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3fv", .{v});
}
pub fn secondaryColor3i(red: Int, green: Int, blue: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3i", .{ red, green, blue });
}
pub fn secondaryColor3iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3iv", .{v});
}
pub fn secondaryColor3s(red: Short, green: Short, blue: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3s", .{ red, green, blue });
}
pub fn secondaryColor3sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3sv", .{v});
}
pub fn secondaryColor3ub(red: Ubyte, green: Ubyte, blue: Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3ub", .{ red, green, blue });
}
pub fn secondaryColor3ubv(v: [*c]const Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3ubv", .{v});
}
pub fn secondaryColor3ui(red: Uint, green: Uint, blue: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3ui", .{ red, green, blue });
}
pub fn secondaryColor3uiv(v: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3uiv", .{v});
}
pub fn secondaryColor3us(red: Ushort, green: Ushort, blue: Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3us", .{ red, green, blue });
}
pub fn secondaryColor3usv(v: [*c]const Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColor3usv", .{v});
}
pub fn secondaryColorPointer(size: Int, @"type": Enum, stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSecondaryColorPointer", .{ size, @"type", stride, pointer });
}
pub fn selectBuffer(size: Sizei, buffer: [*c]Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glSelectBuffer", .{ size, buffer });
}
pub fn shadeModel(mode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glShadeModel", .{mode});
}
pub fn shaderSource(shader: Uint, count: Sizei, string: [*c]const [*c]const Char, length: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glShaderSource", .{ shader, count, string, length });
}
pub fn stencilFunc(func: Enum, ref: Int, mask: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glStencilFunc", .{ func, ref, mask });
}
pub fn stencilFuncSeparate(face: Enum, func: Enum, ref: Int, mask: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glStencilFuncSeparate", .{ face, func, ref, mask });
}
pub fn stencilMask(mask: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glStencilMask", .{mask});
}
pub fn stencilMaskSeparate(face: Enum, mask: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glStencilMaskSeparate", .{ face, mask });
}
pub fn stencilOp(fail: Enum, zfail: Enum, zpass: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glStencilOp", .{ fail, zfail, zpass });
}
pub fn stencilOpSeparate(face: Enum, sfail: Enum, dpfail: Enum, dppass: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glStencilOpSeparate", .{ face, sfail, dpfail, dppass });
}
pub fn texBuffer(target: Enum, internalformat: Enum, buffer: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexBuffer", .{ target, internalformat, buffer });
}
pub fn texCoord1d(s: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord1d", .{s});
}
pub fn texCoord1dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord1dv", .{v});
}
pub fn texCoord1f(s: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord1f", .{s});
}
pub fn texCoord1fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord1fv", .{v});
}
pub fn texCoord1i(s: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord1i", .{s});
}
pub fn texCoord1iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord1iv", .{v});
}
pub fn texCoord1s(s: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord1s", .{s});
}
pub fn texCoord1sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord1sv", .{v});
}
pub fn texCoord2d(s: Double, t: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord2d", .{ s, t });
}
pub fn texCoord2dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord2dv", .{v});
}
pub fn texCoord2f(s: Float, t: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord2f", .{ s, t });
}
pub fn texCoord2fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord2fv", .{v});
}
pub fn texCoord2i(s: Int, t: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord2i", .{ s, t });
}
pub fn texCoord2iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord2iv", .{v});
}
pub fn texCoord2s(s: Short, t: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord2s", .{ s, t });
}
pub fn texCoord2sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord2sv", .{v});
}
pub fn texCoord3d(s: Double, t: Double, r: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord3d", .{ s, t, r });
}
pub fn texCoord3dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord3dv", .{v});
}
pub fn texCoord3f(s: Float, t: Float, r: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord3f", .{ s, t, r });
}
pub fn texCoord3fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord3fv", .{v});
}
pub fn texCoord3i(s: Int, t: Int, r: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord3i", .{ s, t, r });
}
pub fn texCoord3iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord3iv", .{v});
}
pub fn texCoord3s(s: Short, t: Short, r: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord3s", .{ s, t, r });
}
pub fn texCoord3sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord3sv", .{v});
}
pub fn texCoord4d(s: Double, t: Double, r: Double, q: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord4d", .{ s, t, r, q });
}
pub fn texCoord4dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord4dv", .{v});
}
pub fn texCoord4f(s: Float, t: Float, r: Float, q: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord4f", .{ s, t, r, q });
}
pub fn texCoord4fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord4fv", .{v});
}
pub fn texCoord4i(s: Int, t: Int, r: Int, q: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord4i", .{ s, t, r, q });
}
pub fn texCoord4iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord4iv", .{v});
}
pub fn texCoord4s(s: Short, t: Short, r: Short, q: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord4s", .{ s, t, r, q });
}
pub fn texCoord4sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoord4sv", .{v});
}
pub fn texCoordPointer(size: Int, @"type": Enum, stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexCoordPointer", .{ size, @"type", stride, pointer });
}
pub fn texEnvf(target: Enum, pname: Enum, param: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexEnvf", .{ target, pname, param });
}
pub fn texEnvfv(target: Enum, pname: Enum, params: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexEnvfv", .{ target, pname, params });
}
pub fn texEnvi(target: Enum, pname: Enum, param: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexEnvi", .{ target, pname, param });
}
pub fn texEnviv(target: Enum, pname: Enum, params: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexEnviv", .{ target, pname, params });
}
pub fn texGend(coord: Enum, pname: Enum, param: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexGend", .{ coord, pname, param });
}
pub fn texGendv(coord: Enum, pname: Enum, params: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexGendv", .{ coord, pname, params });
}
pub fn texGenf(coord: Enum, pname: Enum, param: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexGenf", .{ coord, pname, param });
}
pub fn texGenfv(coord: Enum, pname: Enum, params: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexGenfv", .{ coord, pname, params });
}
pub fn texGeni(coord: Enum, pname: Enum, param: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexGeni", .{ coord, pname, param });
}
pub fn texGeniv(coord: Enum, pname: Enum, params: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexGeniv", .{ coord, pname, params });
}
pub fn texImage1D(target: Enum, level: Int, internalformat: Int, width: Sizei, border: Int, format: Enum, @"type": Enum, pixels: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexImage1D", .{ target, level, internalformat, width, border, format, @"type", pixels });
}
pub fn texImage2D(target: Enum, level: Int, internalformat: Int, width: Sizei, height: Sizei, border: Int, format: Enum, @"type": Enum, pixels: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexImage2D", .{ target, level, internalformat, width, height, border, format, @"type", pixels });
}
pub fn texImage3D(target: Enum, level: Int, internalformat: Int, width: Sizei, height: Sizei, depth: Sizei, border: Int, format: Enum, @"type": Enum, pixels: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexImage3D", .{ target, level, internalformat, width, height, depth, border, format, @"type", pixels });
}
pub fn texParameterIiv(target: Enum, pname: Enum, params: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexParameterIiv", .{ target, pname, params });
}
pub fn texParameterIuiv(target: Enum, pname: Enum, params: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexParameterIuiv", .{ target, pname, params });
}
pub fn texParameterf(target: Enum, pname: Enum, param: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexParameterf", .{ target, pname, param });
}
pub fn texParameterfv(target: Enum, pname: Enum, params: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexParameterfv", .{ target, pname, params });
}
pub fn texParameteri(target: Enum, pname: Enum, param: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexParameteri", .{ target, pname, param });
}
pub fn texParameteriv(target: Enum, pname: Enum, params: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexParameteriv", .{ target, pname, params });
}
pub fn texSubImage1D(target: Enum, level: Int, xoffset: Int, width: Sizei, format: Enum, @"type": Enum, pixels: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexSubImage1D", .{ target, level, xoffset, width, format, @"type", pixels });
}
pub fn texSubImage2D(target: Enum, level: Int, xoffset: Int, yoffset: Int, width: Sizei, height: Sizei, format: Enum, @"type": Enum, pixels: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexSubImage2D", .{ target, level, xoffset, yoffset, width, height, format, @"type", pixels });
}
pub fn texSubImage3D(target: Enum, level: Int, xoffset: Int, yoffset: Int, zoffset: Int, width: Sizei, height: Sizei, depth: Sizei, format: Enum, @"type": Enum, pixels: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTexSubImage3D", .{ target, level, xoffset, yoffset, zoffset, width, height, depth, format, @"type", pixels });
}
pub fn transformFeedbackVaryings(program: Uint, count: Sizei, varyings: [*c]const [*c]const Char, bufferMode: Enum) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTransformFeedbackVaryings", .{ program, count, varyings, bufferMode });
}
pub fn translated(x: Double, y: Double, z: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTranslated", .{ x, y, z });
}
pub fn translatef(x: Float, y: Float, z: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glTranslatef", .{ x, y, z });
}
pub fn uniform1f(location: Int, v0: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform1f", .{ location, v0 });
}
pub fn uniform1fv(location: Int, count: Sizei, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform1fv", .{ location, count, value });
}
pub fn uniform1i(location: Int, v0: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform1i", .{ location, v0 });
}
pub fn uniform1iv(location: Int, count: Sizei, value: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform1iv", .{ location, count, value });
}
pub fn uniform1ui(location: Int, v0: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform1ui", .{ location, v0 });
}
pub fn uniform1uiv(location: Int, count: Sizei, value: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform1uiv", .{ location, count, value });
}
pub fn uniform2f(location: Int, v0: Float, v1: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform2f", .{ location, v0, v1 });
}
pub fn uniform2fv(location: Int, count: Sizei, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform2fv", .{ location, count, value });
}
pub fn uniform2i(location: Int, v0: Int, v1: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform2i", .{ location, v0, v1 });
}
pub fn uniform2iv(location: Int, count: Sizei, value: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform2iv", .{ location, count, value });
}
pub fn uniform2ui(location: Int, v0: Uint, v1: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform2ui", .{ location, v0, v1 });
}
pub fn uniform2uiv(location: Int, count: Sizei, value: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform2uiv", .{ location, count, value });
}
pub fn uniform3f(location: Int, v0: Float, v1: Float, v2: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform3f", .{ location, v0, v1, v2 });
}
pub fn uniform3fv(location: Int, count: Sizei, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform3fv", .{ location, count, value });
}
pub fn uniform3i(location: Int, v0: Int, v1: Int, v2: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform3i", .{ location, v0, v1, v2 });
}
pub fn uniform3iv(location: Int, count: Sizei, value: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform3iv", .{ location, count, value });
}
pub fn uniform3ui(location: Int, v0: Uint, v1: Uint, v2: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform3ui", .{ location, v0, v1, v2 });
}
pub fn uniform3uiv(location: Int, count: Sizei, value: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform3uiv", .{ location, count, value });
}
pub fn uniform4f(location: Int, v0: Float, v1: Float, v2: Float, v3: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform4f", .{ location, v0, v1, v2, v3 });
}
pub fn uniform4fv(location: Int, count: Sizei, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform4fv", .{ location, count, value });
}
pub fn uniform4i(location: Int, v0: Int, v1: Int, v2: Int, v3: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform4i", .{ location, v0, v1, v2, v3 });
}
pub fn uniform4iv(location: Int, count: Sizei, value: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform4iv", .{ location, count, value });
}
pub fn uniform4ui(location: Int, v0: Uint, v1: Uint, v2: Uint, v3: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform4ui", .{ location, v0, v1, v2, v3 });
}
pub fn uniform4uiv(location: Int, count: Sizei, value: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniform4uiv", .{ location, count, value });
}
pub fn uniformBlockBinding(program: Uint, uniformBlockIndex: Uint, uniformBlockBinding_: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniformBlockBinding", .{ program, uniformBlockIndex, uniformBlockBinding_ });
}
pub fn uniformMatrix2fv(location: Int, count: Sizei, transpose: Boolean, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniformMatrix2fv", .{ location, count, transpose, value });
}
pub fn uniformMatrix2x3fv(location: Int, count: Sizei, transpose: Boolean, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniformMatrix2x3fv", .{ location, count, transpose, value });
}
pub fn uniformMatrix2x4fv(location: Int, count: Sizei, transpose: Boolean, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniformMatrix2x4fv", .{ location, count, transpose, value });
}
pub fn uniformMatrix3fv(location: Int, count: Sizei, transpose: Boolean, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniformMatrix3fv", .{ location, count, transpose, value });
}
pub fn uniformMatrix3x2fv(location: Int, count: Sizei, transpose: Boolean, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniformMatrix3x2fv", .{ location, count, transpose, value });
}
pub fn uniformMatrix3x4fv(location: Int, count: Sizei, transpose: Boolean, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniformMatrix3x4fv", .{ location, count, transpose, value });
}
pub fn uniformMatrix4fv(location: Int, count: Sizei, transpose: Boolean, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniformMatrix4fv", .{ location, count, transpose, value });
}
pub fn uniformMatrix4x2fv(location: Int, count: Sizei, transpose: Boolean, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniformMatrix4x2fv", .{ location, count, transpose, value });
}
pub fn uniformMatrix4x3fv(location: Int, count: Sizei, transpose: Boolean, value: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUniformMatrix4x3fv", .{ location, count, transpose, value });
}
pub fn unmapBuffer(target: Enum) callconv(.C) Boolean {
    return DispatchTable.current.?.invokeIntercepted("glUnmapBuffer", .{target});
}
pub fn useProgram(program: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glUseProgram", .{program});
}
pub fn validateProgram(program: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glValidateProgram", .{program});
}
pub fn vertex2d(x: Double, y: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex2d", .{ x, y });
}
pub fn vertex2dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex2dv", .{v});
}
pub fn vertex2f(x: Float, y: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex2f", .{ x, y });
}
pub fn vertex2fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex2fv", .{v});
}
pub fn vertex2i(x: Int, y: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex2i", .{ x, y });
}
pub fn vertex2iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex2iv", .{v});
}
pub fn vertex2s(x: Short, y: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex2s", .{ x, y });
}
pub fn vertex2sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex2sv", .{v});
}
pub fn vertex3d(x: Double, y: Double, z: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex3d", .{ x, y, z });
}
pub fn vertex3dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex3dv", .{v});
}
pub fn vertex3f(x: Float, y: Float, z: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex3f", .{ x, y, z });
}
pub fn vertex3fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex3fv", .{v});
}
pub fn vertex3i(x: Int, y: Int, z: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex3i", .{ x, y, z });
}
pub fn vertex3iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex3iv", .{v});
}
pub fn vertex3s(x: Short, y: Short, z: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex3s", .{ x, y, z });
}
pub fn vertex3sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex3sv", .{v});
}
pub fn vertex4d(x: Double, y: Double, z: Double, w: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex4d", .{ x, y, z, w });
}
pub fn vertex4dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex4dv", .{v});
}
pub fn vertex4f(x: Float, y: Float, z: Float, w: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex4f", .{ x, y, z, w });
}
pub fn vertex4fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex4fv", .{v});
}
pub fn vertex4i(x: Int, y: Int, z: Int, w: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex4i", .{ x, y, z, w });
}
pub fn vertex4iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex4iv", .{v});
}
pub fn vertex4s(x: Short, y: Short, z: Short, w: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex4s", .{ x, y, z, w });
}
pub fn vertex4sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertex4sv", .{v});
}
pub fn vertexAttrib1d(index: Uint, x: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib1d", .{ index, x });
}
pub fn vertexAttrib1dv(index: Uint, v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib1dv", .{ index, v });
}
pub fn vertexAttrib1f(index: Uint, x: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib1f", .{ index, x });
}
pub fn vertexAttrib1fv(index: Uint, v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib1fv", .{ index, v });
}
pub fn vertexAttrib1s(index: Uint, x: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib1s", .{ index, x });
}
pub fn vertexAttrib1sv(index: Uint, v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib1sv", .{ index, v });
}
pub fn vertexAttrib2d(index: Uint, x: Double, y: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib2d", .{ index, x, y });
}
pub fn vertexAttrib2dv(index: Uint, v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib2dv", .{ index, v });
}
pub fn vertexAttrib2f(index: Uint, x: Float, y: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib2f", .{ index, x, y });
}
pub fn vertexAttrib2fv(index: Uint, v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib2fv", .{ index, v });
}
pub fn vertexAttrib2s(index: Uint, x: Short, y: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib2s", .{ index, x, y });
}
pub fn vertexAttrib2sv(index: Uint, v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib2sv", .{ index, v });
}
pub fn vertexAttrib3d(index: Uint, x: Double, y: Double, z: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib3d", .{ index, x, y, z });
}
pub fn vertexAttrib3dv(index: Uint, v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib3dv", .{ index, v });
}
pub fn vertexAttrib3f(index: Uint, x: Float, y: Float, z: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib3f", .{ index, x, y, z });
}
pub fn vertexAttrib3fv(index: Uint, v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib3fv", .{ index, v });
}
pub fn vertexAttrib3s(index: Uint, x: Short, y: Short, z: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib3s", .{ index, x, y, z });
}
pub fn vertexAttrib3sv(index: Uint, v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib3sv", .{ index, v });
}
pub fn vertexAttrib4Nbv(index: Uint, v: [*c]const Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4Nbv", .{ index, v });
}
pub fn vertexAttrib4Niv(index: Uint, v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4Niv", .{ index, v });
}
pub fn vertexAttrib4Nsv(index: Uint, v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4Nsv", .{ index, v });
}
pub fn vertexAttrib4Nub(index: Uint, x: Ubyte, y: Ubyte, z: Ubyte, w: Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4Nub", .{ index, x, y, z, w });
}
pub fn vertexAttrib4Nubv(index: Uint, v: [*c]const Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4Nubv", .{ index, v });
}
pub fn vertexAttrib4Nuiv(index: Uint, v: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4Nuiv", .{ index, v });
}
pub fn vertexAttrib4Nusv(index: Uint, v: [*c]const Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4Nusv", .{ index, v });
}
pub fn vertexAttrib4bv(index: Uint, v: [*c]const Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4bv", .{ index, v });
}
pub fn vertexAttrib4d(index: Uint, x: Double, y: Double, z: Double, w: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4d", .{ index, x, y, z, w });
}
pub fn vertexAttrib4dv(index: Uint, v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4dv", .{ index, v });
}
pub fn vertexAttrib4f(index: Uint, x: Float, y: Float, z: Float, w: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4f", .{ index, x, y, z, w });
}
pub fn vertexAttrib4fv(index: Uint, v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4fv", .{ index, v });
}
pub fn vertexAttrib4iv(index: Uint, v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4iv", .{ index, v });
}
pub fn vertexAttrib4s(index: Uint, x: Short, y: Short, z: Short, w: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4s", .{ index, x, y, z, w });
}
pub fn vertexAttrib4sv(index: Uint, v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4sv", .{ index, v });
}
pub fn vertexAttrib4ubv(index: Uint, v: [*c]const Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4ubv", .{ index, v });
}
pub fn vertexAttrib4uiv(index: Uint, v: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4uiv", .{ index, v });
}
pub fn vertexAttrib4usv(index: Uint, v: [*c]const Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttrib4usv", .{ index, v });
}
pub fn vertexAttribI1i(index: Uint, x: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI1i", .{ index, x });
}
pub fn vertexAttribI1iv(index: Uint, v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI1iv", .{ index, v });
}
pub fn vertexAttribI1ui(index: Uint, x: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI1ui", .{ index, x });
}
pub fn vertexAttribI1uiv(index: Uint, v: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI1uiv", .{ index, v });
}
pub fn vertexAttribI2i(index: Uint, x: Int, y: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI2i", .{ index, x, y });
}
pub fn vertexAttribI2iv(index: Uint, v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI2iv", .{ index, v });
}
pub fn vertexAttribI2ui(index: Uint, x: Uint, y: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI2ui", .{ index, x, y });
}
pub fn vertexAttribI2uiv(index: Uint, v: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI2uiv", .{ index, v });
}
pub fn vertexAttribI3i(index: Uint, x: Int, y: Int, z: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI3i", .{ index, x, y, z });
}
pub fn vertexAttribI3iv(index: Uint, v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI3iv", .{ index, v });
}
pub fn vertexAttribI3ui(index: Uint, x: Uint, y: Uint, z: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI3ui", .{ index, x, y, z });
}
pub fn vertexAttribI3uiv(index: Uint, v: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI3uiv", .{ index, v });
}
pub fn vertexAttribI4bv(index: Uint, v: [*c]const Byte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI4bv", .{ index, v });
}
pub fn vertexAttribI4i(index: Uint, x: Int, y: Int, z: Int, w: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI4i", .{ index, x, y, z, w });
}
pub fn vertexAttribI4iv(index: Uint, v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI4iv", .{ index, v });
}
pub fn vertexAttribI4sv(index: Uint, v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI4sv", .{ index, v });
}
pub fn vertexAttribI4ubv(index: Uint, v: [*c]const Ubyte) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI4ubv", .{ index, v });
}
pub fn vertexAttribI4ui(index: Uint, x: Uint, y: Uint, z: Uint, w: Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI4ui", .{ index, x, y, z, w });
}
pub fn vertexAttribI4uiv(index: Uint, v: [*c]const Uint) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI4uiv", .{ index, v });
}
pub fn vertexAttribI4usv(index: Uint, v: [*c]const Ushort) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribI4usv", .{ index, v });
}
pub fn vertexAttribIPointer(index: Uint, size: Int, @"type": Enum, stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribIPointer", .{ index, size, @"type", stride, pointer });
}
pub fn vertexAttribPointer(index: Uint, size: Int, @"type": Enum, normalized: Boolean, stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexAttribPointer", .{ index, size, @"type", normalized, stride, pointer });
}
pub fn vertexPointer(size: Int, @"type": Enum, stride: Sizei, pointer: ?*const anyopaque) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glVertexPointer", .{ size, @"type", stride, pointer });
}
pub fn viewport(x: Int, y: Int, width: Sizei, height: Sizei) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glViewport", .{ x, y, width, height });
}
pub fn windowPos2d(x: Double, y: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos2d", .{ x, y });
}
pub fn windowPos2dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos2dv", .{v});
}
pub fn windowPos2f(x: Float, y: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos2f", .{ x, y });
}
pub fn windowPos2fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos2fv", .{v});
}
pub fn windowPos2i(x: Int, y: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos2i", .{ x, y });
}
pub fn windowPos2iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos2iv", .{v});
}
pub fn windowPos2s(x: Short, y: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos2s", .{ x, y });
}
pub fn windowPos2sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos2sv", .{v});
}
pub fn windowPos3d(x: Double, y: Double, z: Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos3d", .{ x, y, z });
}
pub fn windowPos3dv(v: [*c]const Double) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos3dv", .{v});
}
pub fn windowPos3f(x: Float, y: Float, z: Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos3f", .{ x, y, z });
}
pub fn windowPos3fv(v: [*c]const Float) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos3fv", .{v});
}
pub fn windowPos3i(x: Int, y: Int, z: Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos3i", .{ x, y, z });
}
pub fn windowPos3iv(v: [*c]const Int) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos3iv", .{v});
}
pub fn windowPos3s(x: Short, y: Short, z: Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos3s", .{ x, y, z });
}
pub fn windowPos3sv(v: [*c]const Short) callconv(.C) void {
    return DispatchTable.current.?.invokeIntercepted("glWindowPos3sv", .{v});
}
//#endregion Commands

/// Holds dynamically loaded OpenGL features.
///
/// This struct is very large; avoid storing instances of it on the stack.
pub const DispatchTable = struct {
    threadlocal var current: ?*const DispatchTable = null;

    //#region Fields
    glAccum: *const @TypeOf(accum),
    glActiveTexture: *const @TypeOf(activeTexture),
    glAlphaFunc: *const @TypeOf(alphaFunc),
    glAreTexturesResident: *const @TypeOf(areTexturesResident),
    glArrayElement: *const @TypeOf(arrayElement),
    glAttachShader: *const @TypeOf(attachShader),
    glBegin: *const @TypeOf(begin),
    glBeginConditionalRender: *const @TypeOf(beginConditionalRender),
    glBeginQuery: *const @TypeOf(beginQuery),
    glBeginTransformFeedback: *const @TypeOf(beginTransformFeedback),
    glBindAttribLocation: *const @TypeOf(bindAttribLocation),
    glBindBuffer: *const @TypeOf(bindBuffer),
    glBindBufferBase: *const @TypeOf(bindBufferBase),
    glBindBufferRange: *const @TypeOf(bindBufferRange),
    glBindFragDataLocation: *const @TypeOf(bindFragDataLocation),
    glBindFramebuffer: *const @TypeOf(bindFramebuffer),
    glBindRenderbuffer: *const @TypeOf(bindRenderbuffer),
    glBindTexture: *const @TypeOf(bindTexture),
    glBindVertexArray: *const @TypeOf(bindVertexArray),
    glBitmap: *const @TypeOf(bitmap),
    glBlendColor: *const @TypeOf(blendColor),
    glBlendEquation: *const @TypeOf(blendEquation),
    glBlendEquationSeparate: *const @TypeOf(blendEquationSeparate),
    glBlendFunc: *const @TypeOf(blendFunc),
    glBlendFuncSeparate: *const @TypeOf(blendFuncSeparate),
    glBlitFramebuffer: *const @TypeOf(blitFramebuffer),
    glBufferData: *const @TypeOf(bufferData),
    glBufferSubData: *const @TypeOf(bufferSubData),
    glCallList: *const @TypeOf(callList),
    glCallLists: *const @TypeOf(callLists),
    glCheckFramebufferStatus: *const @TypeOf(checkFramebufferStatus),
    glClampColor: *const @TypeOf(clampColor),
    glClear: *const @TypeOf(clear),
    glClearAccum: *const @TypeOf(clearAccum),
    glClearBufferfi: *const @TypeOf(clearBufferfi),
    glClearBufferfv: *const @TypeOf(clearBufferfv),
    glClearBufferiv: *const @TypeOf(clearBufferiv),
    glClearBufferuiv: *const @TypeOf(clearBufferuiv),
    glClearColor: *const @TypeOf(clearColor),
    glClearDepth: *const @TypeOf(clearDepth),
    glClearIndex: *const @TypeOf(clearIndex),
    glClearStencil: *const @TypeOf(clearStencil),
    glClientActiveTexture: *const @TypeOf(clientActiveTexture),
    glClipPlane: *const @TypeOf(clipPlane),
    glColor3b: *const @TypeOf(color3b),
    glColor3bv: *const @TypeOf(color3bv),
    glColor3d: *const @TypeOf(color3d),
    glColor3dv: *const @TypeOf(color3dv),
    glColor3f: *const @TypeOf(color3f),
    glColor3fv: *const @TypeOf(color3fv),
    glColor3i: *const @TypeOf(color3i),
    glColor3iv: *const @TypeOf(color3iv),
    glColor3s: *const @TypeOf(color3s),
    glColor3sv: *const @TypeOf(color3sv),
    glColor3ub: *const @TypeOf(color3ub),
    glColor3ubv: *const @TypeOf(color3ubv),
    glColor3ui: *const @TypeOf(color3ui),
    glColor3uiv: *const @TypeOf(color3uiv),
    glColor3us: *const @TypeOf(color3us),
    glColor3usv: *const @TypeOf(color3usv),
    glColor4b: *const @TypeOf(color4b),
    glColor4bv: *const @TypeOf(color4bv),
    glColor4d: *const @TypeOf(color4d),
    glColor4dv: *const @TypeOf(color4dv),
    glColor4f: *const @TypeOf(color4f),
    glColor4fv: *const @TypeOf(color4fv),
    glColor4i: *const @TypeOf(color4i),
    glColor4iv: *const @TypeOf(color4iv),
    glColor4s: *const @TypeOf(color4s),
    glColor4sv: *const @TypeOf(color4sv),
    glColor4ub: *const @TypeOf(color4ub),
    glColor4ubv: *const @TypeOf(color4ubv),
    glColor4ui: *const @TypeOf(color4ui),
    glColor4uiv: *const @TypeOf(color4uiv),
    glColor4us: *const @TypeOf(color4us),
    glColor4usv: *const @TypeOf(color4usv),
    glColorMask: *const @TypeOf(colorMask),
    glColorMaski: *const @TypeOf(colorMaski),
    glColorMaterial: *const @TypeOf(colorMaterial),
    glColorPointer: *const @TypeOf(colorPointer),
    glCompileShader: *const @TypeOf(compileShader),
    glCompressedTexImage1D: *const @TypeOf(compressedTexImage1D),
    glCompressedTexImage2D: *const @TypeOf(compressedTexImage2D),
    glCompressedTexImage3D: *const @TypeOf(compressedTexImage3D),
    glCompressedTexSubImage1D: *const @TypeOf(compressedTexSubImage1D),
    glCompressedTexSubImage2D: *const @TypeOf(compressedTexSubImage2D),
    glCompressedTexSubImage3D: *const @TypeOf(compressedTexSubImage3D),
    glCopyBufferSubData: *const @TypeOf(copyBufferSubData),
    glCopyPixels: *const @TypeOf(copyPixels),
    glCopyTexImage1D: *const @TypeOf(copyTexImage1D),
    glCopyTexImage2D: *const @TypeOf(copyTexImage2D),
    glCopyTexSubImage1D: *const @TypeOf(copyTexSubImage1D),
    glCopyTexSubImage2D: *const @TypeOf(copyTexSubImage2D),
    glCopyTexSubImage3D: *const @TypeOf(copyTexSubImage3D),
    glCreateProgram: *const @TypeOf(createProgram),
    glCreateShader: *const @TypeOf(createShader),
    glCullFace: *const @TypeOf(cullFace),
    glDeleteBuffers: *const @TypeOf(deleteBuffers),
    glDeleteFramebuffers: *const @TypeOf(deleteFramebuffers),
    glDeleteLists: *const @TypeOf(deleteLists),
    glDeleteProgram: *const @TypeOf(deleteProgram),
    glDeleteQueries: *const @TypeOf(deleteQueries),
    glDeleteRenderbuffers: *const @TypeOf(deleteRenderbuffers),
    glDeleteShader: *const @TypeOf(deleteShader),
    glDeleteTextures: *const @TypeOf(deleteTextures),
    glDeleteVertexArrays: *const @TypeOf(deleteVertexArrays),
    glDepthFunc: *const @TypeOf(depthFunc),
    glDepthMask: *const @TypeOf(depthMask),
    glDepthRange: *const @TypeOf(depthRange),
    glDetachShader: *const @TypeOf(detachShader),
    glDisable: *const @TypeOf(disable),
    glDisableClientState: *const @TypeOf(disableClientState),
    glDisableVertexAttribArray: *const @TypeOf(disableVertexAttribArray),
    glDisablei: *const @TypeOf(disablei),
    glDrawArrays: *const @TypeOf(drawArrays),
    glDrawArraysInstanced: *const @TypeOf(drawArraysInstanced),
    glDrawBuffer: *const @TypeOf(drawBuffer),
    glDrawBuffers: *const @TypeOf(drawBuffers),
    glDrawElements: *const @TypeOf(drawElements),
    glDrawElementsInstanced: *const @TypeOf(drawElementsInstanced),
    glDrawPixels: *const @TypeOf(drawPixels),
    glDrawRangeElements: *const @TypeOf(drawRangeElements),
    glEdgeFlag: *const @TypeOf(edgeFlag),
    glEdgeFlagPointer: *const @TypeOf(edgeFlagPointer),
    glEdgeFlagv: *const @TypeOf(edgeFlagv),
    glEnable: *const @TypeOf(enable),
    glEnableClientState: *const @TypeOf(enableClientState),
    glEnableVertexAttribArray: *const @TypeOf(enableVertexAttribArray),
    glEnablei: *const @TypeOf(enablei),
    glEnd: *const @TypeOf(end),
    glEndConditionalRender: *const @TypeOf(endConditionalRender),
    glEndList: *const @TypeOf(endList),
    glEndQuery: *const @TypeOf(endQuery),
    glEndTransformFeedback: *const @TypeOf(endTransformFeedback),
    glEvalCoord1d: *const @TypeOf(evalCoord1d),
    glEvalCoord1dv: *const @TypeOf(evalCoord1dv),
    glEvalCoord1f: *const @TypeOf(evalCoord1f),
    glEvalCoord1fv: *const @TypeOf(evalCoord1fv),
    glEvalCoord2d: *const @TypeOf(evalCoord2d),
    glEvalCoord2dv: *const @TypeOf(evalCoord2dv),
    glEvalCoord2f: *const @TypeOf(evalCoord2f),
    glEvalCoord2fv: *const @TypeOf(evalCoord2fv),
    glEvalMesh1: *const @TypeOf(evalMesh1),
    glEvalMesh2: *const @TypeOf(evalMesh2),
    glEvalPoint1: *const @TypeOf(evalPoint1),
    glEvalPoint2: *const @TypeOf(evalPoint2),
    glFeedbackBuffer: *const @TypeOf(feedbackBuffer),
    glFinish: *const @TypeOf(finish),
    glFlush: *const @TypeOf(flush),
    glFlushMappedBufferRange: *const @TypeOf(flushMappedBufferRange),
    glFogCoordPointer: *const @TypeOf(fogCoordPointer),
    glFogCoordd: *const @TypeOf(fogCoordd),
    glFogCoorddv: *const @TypeOf(fogCoorddv),
    glFogCoordf: *const @TypeOf(fogCoordf),
    glFogCoordfv: *const @TypeOf(fogCoordfv),
    glFogf: *const @TypeOf(fogf),
    glFogfv: *const @TypeOf(fogfv),
    glFogi: *const @TypeOf(fogi),
    glFogiv: *const @TypeOf(fogiv),
    glFramebufferRenderbuffer: *const @TypeOf(framebufferRenderbuffer),
    glFramebufferTexture1D: *const @TypeOf(framebufferTexture1D),
    glFramebufferTexture2D: *const @TypeOf(framebufferTexture2D),
    glFramebufferTexture3D: *const @TypeOf(framebufferTexture3D),
    glFramebufferTextureLayer: *const @TypeOf(framebufferTextureLayer),
    glFrontFace: *const @TypeOf(frontFace),
    glFrustum: *const @TypeOf(frustum),
    glGenBuffers: *const @TypeOf(genBuffers),
    glGenFramebuffers: *const @TypeOf(genFramebuffers),
    glGenLists: *const @TypeOf(genLists),
    glGenQueries: *const @TypeOf(genQueries),
    glGenRenderbuffers: *const @TypeOf(genRenderbuffers),
    glGenTextures: *const @TypeOf(genTextures),
    glGenVertexArrays: *const @TypeOf(genVertexArrays),
    glGenerateMipmap: *const @TypeOf(generateMipmap),
    glGetActiveAttrib: *const @TypeOf(getActiveAttrib),
    glGetActiveUniform: *const @TypeOf(getActiveUniform),
    glGetActiveUniformBlockName: *const @TypeOf(getActiveUniformBlockName),
    glGetActiveUniformBlockiv: *const @TypeOf(getActiveUniformBlockiv),
    glGetActiveUniformName: *const @TypeOf(getActiveUniformName),
    glGetActiveUniformsiv: *const @TypeOf(getActiveUniformsiv),
    glGetAttachedShaders: *const @TypeOf(getAttachedShaders),
    glGetAttribLocation: *const @TypeOf(getAttribLocation),
    glGetBooleani_v: *const @TypeOf(getBooleani_v),
    glGetBooleanv: *const @TypeOf(getBooleanv),
    glGetBufferParameteriv: *const @TypeOf(getBufferParameteriv),
    glGetBufferPointerv: *const @TypeOf(getBufferPointerv),
    glGetBufferSubData: *const @TypeOf(getBufferSubData),
    glGetClipPlane: *const @TypeOf(getClipPlane),
    glGetCompressedTexImage: *const @TypeOf(getCompressedTexImage),
    glGetDoublev: *const @TypeOf(getDoublev),
    glGetError: *const @TypeOf(getError),
    glGetFloatv: *const @TypeOf(getFloatv),
    glGetFragDataLocation: *const @TypeOf(getFragDataLocation),
    glGetFramebufferAttachmentParameteriv: *const @TypeOf(getFramebufferAttachmentParameteriv),
    glGetIntegeri_v: *const @TypeOf(getIntegeri_v),
    glGetIntegerv: *const @TypeOf(getIntegerv),
    glGetLightfv: *const @TypeOf(getLightfv),
    glGetLightiv: *const @TypeOf(getLightiv),
    glGetMapdv: *const @TypeOf(getMapdv),
    glGetMapfv: *const @TypeOf(getMapfv),
    glGetMapiv: *const @TypeOf(getMapiv),
    glGetMaterialfv: *const @TypeOf(getMaterialfv),
    glGetMaterialiv: *const @TypeOf(getMaterialiv),
    glGetPixelMapfv: *const @TypeOf(getPixelMapfv),
    glGetPixelMapuiv: *const @TypeOf(getPixelMapuiv),
    glGetPixelMapusv: *const @TypeOf(getPixelMapusv),
    glGetPointerv: *const @TypeOf(getPointerv),
    glGetPolygonStipple: *const @TypeOf(getPolygonStipple),
    glGetProgramInfoLog: *const @TypeOf(getProgramInfoLog),
    glGetProgramiv: *const @TypeOf(getProgramiv),
    glGetQueryObjectiv: *const @TypeOf(getQueryObjectiv),
    glGetQueryObjectuiv: *const @TypeOf(getQueryObjectuiv),
    glGetQueryiv: *const @TypeOf(getQueryiv),
    glGetRenderbufferParameteriv: *const @TypeOf(getRenderbufferParameteriv),
    glGetShaderInfoLog: *const @TypeOf(getShaderInfoLog),
    glGetShaderSource: *const @TypeOf(getShaderSource),
    glGetShaderiv: *const @TypeOf(getShaderiv),
    glGetString: *const @TypeOf(getString),
    glGetStringi: *const @TypeOf(getStringi),
    glGetTexEnvfv: *const @TypeOf(getTexEnvfv),
    glGetTexEnviv: *const @TypeOf(getTexEnviv),
    glGetTexGendv: *const @TypeOf(getTexGendv),
    glGetTexGenfv: *const @TypeOf(getTexGenfv),
    glGetTexGeniv: *const @TypeOf(getTexGeniv),
    glGetTexImage: *const @TypeOf(getTexImage),
    glGetTexLevelParameterfv: *const @TypeOf(getTexLevelParameterfv),
    glGetTexLevelParameteriv: *const @TypeOf(getTexLevelParameteriv),
    glGetTexParameterIiv: *const @TypeOf(getTexParameterIiv),
    glGetTexParameterIuiv: *const @TypeOf(getTexParameterIuiv),
    glGetTexParameterfv: *const @TypeOf(getTexParameterfv),
    glGetTexParameteriv: *const @TypeOf(getTexParameteriv),
    glGetTransformFeedbackVarying: *const @TypeOf(getTransformFeedbackVarying),
    glGetUniformBlockIndex: *const @TypeOf(getUniformBlockIndex),
    glGetUniformIndices: *const @TypeOf(getUniformIndices),
    glGetUniformLocation: *const @TypeOf(getUniformLocation),
    glGetUniformfv: *const @TypeOf(getUniformfv),
    glGetUniformiv: *const @TypeOf(getUniformiv),
    glGetUniformuiv: *const @TypeOf(getUniformuiv),
    glGetVertexAttribIiv: *const @TypeOf(getVertexAttribIiv),
    glGetVertexAttribIuiv: *const @TypeOf(getVertexAttribIuiv),
    glGetVertexAttribPointerv: *const @TypeOf(getVertexAttribPointerv),
    glGetVertexAttribdv: *const @TypeOf(getVertexAttribdv),
    glGetVertexAttribfv: *const @TypeOf(getVertexAttribfv),
    glGetVertexAttribiv: *const @TypeOf(getVertexAttribiv),
    glHint: *const @TypeOf(hint),
    glIndexMask: *const @TypeOf(indexMask),
    glIndexPointer: *const @TypeOf(indexPointer),
    glIndexd: *const @TypeOf(indexd),
    glIndexdv: *const @TypeOf(indexdv),
    glIndexf: *const @TypeOf(indexf),
    glIndexfv: *const @TypeOf(indexfv),
    glIndexi: *const @TypeOf(indexi),
    glIndexiv: *const @TypeOf(indexiv),
    glIndexs: *const @TypeOf(indexs),
    glIndexsv: *const @TypeOf(indexsv),
    glIndexub: *const @TypeOf(indexub),
    glIndexubv: *const @TypeOf(indexubv),
    glInitNames: *const @TypeOf(initNames),
    glInterleavedArrays: *const @TypeOf(interleavedArrays),
    glIsBuffer: *const @TypeOf(isBuffer),
    glIsEnabled: *const @TypeOf(isEnabled),
    glIsEnabledi: *const @TypeOf(isEnabledi),
    glIsFramebuffer: *const @TypeOf(isFramebuffer),
    glIsList: *const @TypeOf(isList),
    glIsProgram: *const @TypeOf(isProgram),
    glIsQuery: *const @TypeOf(isQuery),
    glIsRenderbuffer: *const @TypeOf(isRenderbuffer),
    glIsShader: *const @TypeOf(isShader),
    glIsTexture: *const @TypeOf(isTexture),
    glIsVertexArray: *const @TypeOf(isVertexArray),
    glLightModelf: *const @TypeOf(lightModelf),
    glLightModelfv: *const @TypeOf(lightModelfv),
    glLightModeli: *const @TypeOf(lightModeli),
    glLightModeliv: *const @TypeOf(lightModeliv),
    glLightf: *const @TypeOf(lightf),
    glLightfv: *const @TypeOf(lightfv),
    glLighti: *const @TypeOf(lighti),
    glLightiv: *const @TypeOf(lightiv),
    glLineStipple: *const @TypeOf(lineStipple),
    glLineWidth: *const @TypeOf(lineWidth),
    glLinkProgram: *const @TypeOf(linkProgram),
    glListBase: *const @TypeOf(listBase),
    glLoadIdentity: *const @TypeOf(loadIdentity),
    glLoadMatrixd: *const @TypeOf(loadMatrixd),
    glLoadMatrixf: *const @TypeOf(loadMatrixf),
    glLoadName: *const @TypeOf(loadName),
    glLoadTransposeMatrixd: *const @TypeOf(loadTransposeMatrixd),
    glLoadTransposeMatrixf: *const @TypeOf(loadTransposeMatrixf),
    glLogicOp: *const @TypeOf(logicOp),
    glMap1d: *const @TypeOf(map1d),
    glMap1f: *const @TypeOf(map1f),
    glMap2d: *const @TypeOf(map2d),
    glMap2f: *const @TypeOf(map2f),
    glMapBuffer: *const @TypeOf(mapBuffer),
    glMapBufferRange: *const @TypeOf(mapBufferRange),
    glMapGrid1d: *const @TypeOf(mapGrid1d),
    glMapGrid1f: *const @TypeOf(mapGrid1f),
    glMapGrid2d: *const @TypeOf(mapGrid2d),
    glMapGrid2f: *const @TypeOf(mapGrid2f),
    glMaterialf: *const @TypeOf(materialf),
    glMaterialfv: *const @TypeOf(materialfv),
    glMateriali: *const @TypeOf(materiali),
    glMaterialiv: *const @TypeOf(materialiv),
    glMatrixMode: *const @TypeOf(matrixMode),
    glMultMatrixd: *const @TypeOf(multMatrixd),
    glMultMatrixf: *const @TypeOf(multMatrixf),
    glMultTransposeMatrixd: *const @TypeOf(multTransposeMatrixd),
    glMultTransposeMatrixf: *const @TypeOf(multTransposeMatrixf),
    glMultiDrawArrays: *const @TypeOf(multiDrawArrays),
    glMultiDrawElements: *const @TypeOf(multiDrawElements),
    glMultiTexCoord1d: *const @TypeOf(multiTexCoord1d),
    glMultiTexCoord1dv: *const @TypeOf(multiTexCoord1dv),
    glMultiTexCoord1f: *const @TypeOf(multiTexCoord1f),
    glMultiTexCoord1fv: *const @TypeOf(multiTexCoord1fv),
    glMultiTexCoord1i: *const @TypeOf(multiTexCoord1i),
    glMultiTexCoord1iv: *const @TypeOf(multiTexCoord1iv),
    glMultiTexCoord1s: *const @TypeOf(multiTexCoord1s),
    glMultiTexCoord1sv: *const @TypeOf(multiTexCoord1sv),
    glMultiTexCoord2d: *const @TypeOf(multiTexCoord2d),
    glMultiTexCoord2dv: *const @TypeOf(multiTexCoord2dv),
    glMultiTexCoord2f: *const @TypeOf(multiTexCoord2f),
    glMultiTexCoord2fv: *const @TypeOf(multiTexCoord2fv),
    glMultiTexCoord2i: *const @TypeOf(multiTexCoord2i),
    glMultiTexCoord2iv: *const @TypeOf(multiTexCoord2iv),
    glMultiTexCoord2s: *const @TypeOf(multiTexCoord2s),
    glMultiTexCoord2sv: *const @TypeOf(multiTexCoord2sv),
    glMultiTexCoord3d: *const @TypeOf(multiTexCoord3d),
    glMultiTexCoord3dv: *const @TypeOf(multiTexCoord3dv),
    glMultiTexCoord3f: *const @TypeOf(multiTexCoord3f),
    glMultiTexCoord3fv: *const @TypeOf(multiTexCoord3fv),
    glMultiTexCoord3i: *const @TypeOf(multiTexCoord3i),
    glMultiTexCoord3iv: *const @TypeOf(multiTexCoord3iv),
    glMultiTexCoord3s: *const @TypeOf(multiTexCoord3s),
    glMultiTexCoord3sv: *const @TypeOf(multiTexCoord3sv),
    glMultiTexCoord4d: *const @TypeOf(multiTexCoord4d),
    glMultiTexCoord4dv: *const @TypeOf(multiTexCoord4dv),
    glMultiTexCoord4f: *const @TypeOf(multiTexCoord4f),
    glMultiTexCoord4fv: *const @TypeOf(multiTexCoord4fv),
    glMultiTexCoord4i: *const @TypeOf(multiTexCoord4i),
    glMultiTexCoord4iv: *const @TypeOf(multiTexCoord4iv),
    glMultiTexCoord4s: *const @TypeOf(multiTexCoord4s),
    glMultiTexCoord4sv: *const @TypeOf(multiTexCoord4sv),
    glNewList: *const @TypeOf(newList),
    glNormal3b: *const @TypeOf(normal3b),
    glNormal3bv: *const @TypeOf(normal3bv),
    glNormal3d: *const @TypeOf(normal3d),
    glNormal3dv: *const @TypeOf(normal3dv),
    glNormal3f: *const @TypeOf(normal3f),
    glNormal3fv: *const @TypeOf(normal3fv),
    glNormal3i: *const @TypeOf(normal3i),
    glNormal3iv: *const @TypeOf(normal3iv),
    glNormal3s: *const @TypeOf(normal3s),
    glNormal3sv: *const @TypeOf(normal3sv),
    glNormalPointer: *const @TypeOf(normalPointer),
    glOrtho: *const @TypeOf(ortho),
    glPassThrough: *const @TypeOf(passThrough),
    glPixelMapfv: *const @TypeOf(pixelMapfv),
    glPixelMapuiv: *const @TypeOf(pixelMapuiv),
    glPixelMapusv: *const @TypeOf(pixelMapusv),
    glPixelStoref: *const @TypeOf(pixelStoref),
    glPixelStorei: *const @TypeOf(pixelStorei),
    glPixelTransferf: *const @TypeOf(pixelTransferf),
    glPixelTransferi: *const @TypeOf(pixelTransferi),
    glPixelZoom: *const @TypeOf(pixelZoom),
    glPointParameterf: *const @TypeOf(pointParameterf),
    glPointParameterfv: *const @TypeOf(pointParameterfv),
    glPointParameteri: *const @TypeOf(pointParameteri),
    glPointParameteriv: *const @TypeOf(pointParameteriv),
    glPointSize: *const @TypeOf(pointSize),
    glPolygonMode: *const @TypeOf(polygonMode),
    glPolygonOffset: *const @TypeOf(polygonOffset),
    glPolygonStipple: *const @TypeOf(polygonStipple),
    glPopAttrib: *const @TypeOf(popAttrib),
    glPopClientAttrib: *const @TypeOf(popClientAttrib),
    glPopMatrix: *const @TypeOf(popMatrix),
    glPopName: *const @TypeOf(popName),
    glPrimitiveRestartIndex: *const @TypeOf(primitiveRestartIndex),
    glPrioritizeTextures: *const @TypeOf(prioritizeTextures),
    glPushAttrib: *const @TypeOf(pushAttrib),
    glPushClientAttrib: *const @TypeOf(pushClientAttrib),
    glPushMatrix: *const @TypeOf(pushMatrix),
    glPushName: *const @TypeOf(pushName),
    glRasterPos2d: *const @TypeOf(rasterPos2d),
    glRasterPos2dv: *const @TypeOf(rasterPos2dv),
    glRasterPos2f: *const @TypeOf(rasterPos2f),
    glRasterPos2fv: *const @TypeOf(rasterPos2fv),
    glRasterPos2i: *const @TypeOf(rasterPos2i),
    glRasterPos2iv: *const @TypeOf(rasterPos2iv),
    glRasterPos2s: *const @TypeOf(rasterPos2s),
    glRasterPos2sv: *const @TypeOf(rasterPos2sv),
    glRasterPos3d: *const @TypeOf(rasterPos3d),
    glRasterPos3dv: *const @TypeOf(rasterPos3dv),
    glRasterPos3f: *const @TypeOf(rasterPos3f),
    glRasterPos3fv: *const @TypeOf(rasterPos3fv),
    glRasterPos3i: *const @TypeOf(rasterPos3i),
    glRasterPos3iv: *const @TypeOf(rasterPos3iv),
    glRasterPos3s: *const @TypeOf(rasterPos3s),
    glRasterPos3sv: *const @TypeOf(rasterPos3sv),
    glRasterPos4d: *const @TypeOf(rasterPos4d),
    glRasterPos4dv: *const @TypeOf(rasterPos4dv),
    glRasterPos4f: *const @TypeOf(rasterPos4f),
    glRasterPos4fv: *const @TypeOf(rasterPos4fv),
    glRasterPos4i: *const @TypeOf(rasterPos4i),
    glRasterPos4iv: *const @TypeOf(rasterPos4iv),
    glRasterPos4s: *const @TypeOf(rasterPos4s),
    glRasterPos4sv: *const @TypeOf(rasterPos4sv),
    glReadBuffer: *const @TypeOf(readBuffer),
    glReadPixels: *const @TypeOf(readPixels),
    glRectd: *const @TypeOf(rectd),
    glRectdv: *const @TypeOf(rectdv),
    glRectf: *const @TypeOf(rectf),
    glRectfv: *const @TypeOf(rectfv),
    glRecti: *const @TypeOf(recti),
    glRectiv: *const @TypeOf(rectiv),
    glRects: *const @TypeOf(rects),
    glRectsv: *const @TypeOf(rectsv),
    glRenderMode: *const @TypeOf(renderMode),
    glRenderbufferStorage: *const @TypeOf(renderbufferStorage),
    glRenderbufferStorageMultisample: *const @TypeOf(renderbufferStorageMultisample),
    glRotated: *const @TypeOf(rotated),
    glRotatef: *const @TypeOf(rotatef),
    glSampleCoverage: *const @TypeOf(sampleCoverage),
    glScaled: *const @TypeOf(scaled),
    glScalef: *const @TypeOf(scalef),
    glScissor: *const @TypeOf(scissor),
    glSecondaryColor3b: *const @TypeOf(secondaryColor3b),
    glSecondaryColor3bv: *const @TypeOf(secondaryColor3bv),
    glSecondaryColor3d: *const @TypeOf(secondaryColor3d),
    glSecondaryColor3dv: *const @TypeOf(secondaryColor3dv),
    glSecondaryColor3f: *const @TypeOf(secondaryColor3f),
    glSecondaryColor3fv: *const @TypeOf(secondaryColor3fv),
    glSecondaryColor3i: *const @TypeOf(secondaryColor3i),
    glSecondaryColor3iv: *const @TypeOf(secondaryColor3iv),
    glSecondaryColor3s: *const @TypeOf(secondaryColor3s),
    glSecondaryColor3sv: *const @TypeOf(secondaryColor3sv),
    glSecondaryColor3ub: *const @TypeOf(secondaryColor3ub),
    glSecondaryColor3ubv: *const @TypeOf(secondaryColor3ubv),
    glSecondaryColor3ui: *const @TypeOf(secondaryColor3ui),
    glSecondaryColor3uiv: *const @TypeOf(secondaryColor3uiv),
    glSecondaryColor3us: *const @TypeOf(secondaryColor3us),
    glSecondaryColor3usv: *const @TypeOf(secondaryColor3usv),
    glSecondaryColorPointer: *const @TypeOf(secondaryColorPointer),
    glSelectBuffer: *const @TypeOf(selectBuffer),
    glShadeModel: *const @TypeOf(shadeModel),
    glShaderSource: *const @TypeOf(shaderSource),
    glStencilFunc: *const @TypeOf(stencilFunc),
    glStencilFuncSeparate: *const @TypeOf(stencilFuncSeparate),
    glStencilMask: *const @TypeOf(stencilMask),
    glStencilMaskSeparate: *const @TypeOf(stencilMaskSeparate),
    glStencilOp: *const @TypeOf(stencilOp),
    glStencilOpSeparate: *const @TypeOf(stencilOpSeparate),
    glTexBuffer: *const @TypeOf(texBuffer),
    glTexCoord1d: *const @TypeOf(texCoord1d),
    glTexCoord1dv: *const @TypeOf(texCoord1dv),
    glTexCoord1f: *const @TypeOf(texCoord1f),
    glTexCoord1fv: *const @TypeOf(texCoord1fv),
    glTexCoord1i: *const @TypeOf(texCoord1i),
    glTexCoord1iv: *const @TypeOf(texCoord1iv),
    glTexCoord1s: *const @TypeOf(texCoord1s),
    glTexCoord1sv: *const @TypeOf(texCoord1sv),
    glTexCoord2d: *const @TypeOf(texCoord2d),
    glTexCoord2dv: *const @TypeOf(texCoord2dv),
    glTexCoord2f: *const @TypeOf(texCoord2f),
    glTexCoord2fv: *const @TypeOf(texCoord2fv),
    glTexCoord2i: *const @TypeOf(texCoord2i),
    glTexCoord2iv: *const @TypeOf(texCoord2iv),
    glTexCoord2s: *const @TypeOf(texCoord2s),
    glTexCoord2sv: *const @TypeOf(texCoord2sv),
    glTexCoord3d: *const @TypeOf(texCoord3d),
    glTexCoord3dv: *const @TypeOf(texCoord3dv),
    glTexCoord3f: *const @TypeOf(texCoord3f),
    glTexCoord3fv: *const @TypeOf(texCoord3fv),
    glTexCoord3i: *const @TypeOf(texCoord3i),
    glTexCoord3iv: *const @TypeOf(texCoord3iv),
    glTexCoord3s: *const @TypeOf(texCoord3s),
    glTexCoord3sv: *const @TypeOf(texCoord3sv),
    glTexCoord4d: *const @TypeOf(texCoord4d),
    glTexCoord4dv: *const @TypeOf(texCoord4dv),
    glTexCoord4f: *const @TypeOf(texCoord4f),
    glTexCoord4fv: *const @TypeOf(texCoord4fv),
    glTexCoord4i: *const @TypeOf(texCoord4i),
    glTexCoord4iv: *const @TypeOf(texCoord4iv),
    glTexCoord4s: *const @TypeOf(texCoord4s),
    glTexCoord4sv: *const @TypeOf(texCoord4sv),
    glTexCoordPointer: *const @TypeOf(texCoordPointer),
    glTexEnvf: *const @TypeOf(texEnvf),
    glTexEnvfv: *const @TypeOf(texEnvfv),
    glTexEnvi: *const @TypeOf(texEnvi),
    glTexEnviv: *const @TypeOf(texEnviv),
    glTexGend: *const @TypeOf(texGend),
    glTexGendv: *const @TypeOf(texGendv),
    glTexGenf: *const @TypeOf(texGenf),
    glTexGenfv: *const @TypeOf(texGenfv),
    glTexGeni: *const @TypeOf(texGeni),
    glTexGeniv: *const @TypeOf(texGeniv),
    glTexImage1D: *const @TypeOf(texImage1D),
    glTexImage2D: *const @TypeOf(texImage2D),
    glTexImage3D: *const @TypeOf(texImage3D),
    glTexParameterIiv: *const @TypeOf(texParameterIiv),
    glTexParameterIuiv: *const @TypeOf(texParameterIuiv),
    glTexParameterf: *const @TypeOf(texParameterf),
    glTexParameterfv: *const @TypeOf(texParameterfv),
    glTexParameteri: *const @TypeOf(texParameteri),
    glTexParameteriv: *const @TypeOf(texParameteriv),
    glTexSubImage1D: *const @TypeOf(texSubImage1D),
    glTexSubImage2D: *const @TypeOf(texSubImage2D),
    glTexSubImage3D: *const @TypeOf(texSubImage3D),
    glTransformFeedbackVaryings: *const @TypeOf(transformFeedbackVaryings),
    glTranslated: *const @TypeOf(translated),
    glTranslatef: *const @TypeOf(translatef),
    glUniform1f: *const @TypeOf(uniform1f),
    glUniform1fv: *const @TypeOf(uniform1fv),
    glUniform1i: *const @TypeOf(uniform1i),
    glUniform1iv: *const @TypeOf(uniform1iv),
    glUniform1ui: *const @TypeOf(uniform1ui),
    glUniform1uiv: *const @TypeOf(uniform1uiv),
    glUniform2f: *const @TypeOf(uniform2f),
    glUniform2fv: *const @TypeOf(uniform2fv),
    glUniform2i: *const @TypeOf(uniform2i),
    glUniform2iv: *const @TypeOf(uniform2iv),
    glUniform2ui: *const @TypeOf(uniform2ui),
    glUniform2uiv: *const @TypeOf(uniform2uiv),
    glUniform3f: *const @TypeOf(uniform3f),
    glUniform3fv: *const @TypeOf(uniform3fv),
    glUniform3i: *const @TypeOf(uniform3i),
    glUniform3iv: *const @TypeOf(uniform3iv),
    glUniform3ui: *const @TypeOf(uniform3ui),
    glUniform3uiv: *const @TypeOf(uniform3uiv),
    glUniform4f: *const @TypeOf(uniform4f),
    glUniform4fv: *const @TypeOf(uniform4fv),
    glUniform4i: *const @TypeOf(uniform4i),
    glUniform4iv: *const @TypeOf(uniform4iv),
    glUniform4ui: *const @TypeOf(uniform4ui),
    glUniform4uiv: *const @TypeOf(uniform4uiv),
    glUniformBlockBinding: *const @TypeOf(uniformBlockBinding),
    glUniformMatrix2fv: *const @TypeOf(uniformMatrix2fv),
    glUniformMatrix2x3fv: *const @TypeOf(uniformMatrix2x3fv),
    glUniformMatrix2x4fv: *const @TypeOf(uniformMatrix2x4fv),
    glUniformMatrix3fv: *const @TypeOf(uniformMatrix3fv),
    glUniformMatrix3x2fv: *const @TypeOf(uniformMatrix3x2fv),
    glUniformMatrix3x4fv: *const @TypeOf(uniformMatrix3x4fv),
    glUniformMatrix4fv: *const @TypeOf(uniformMatrix4fv),
    glUniformMatrix4x2fv: *const @TypeOf(uniformMatrix4x2fv),
    glUniformMatrix4x3fv: *const @TypeOf(uniformMatrix4x3fv),
    glUnmapBuffer: *const @TypeOf(unmapBuffer),
    glUseProgram: *const @TypeOf(useProgram),
    glValidateProgram: *const @TypeOf(validateProgram),
    glVertex2d: *const @TypeOf(vertex2d),
    glVertex2dv: *const @TypeOf(vertex2dv),
    glVertex2f: *const @TypeOf(vertex2f),
    glVertex2fv: *const @TypeOf(vertex2fv),
    glVertex2i: *const @TypeOf(vertex2i),
    glVertex2iv: *const @TypeOf(vertex2iv),
    glVertex2s: *const @TypeOf(vertex2s),
    glVertex2sv: *const @TypeOf(vertex2sv),
    glVertex3d: *const @TypeOf(vertex3d),
    glVertex3dv: *const @TypeOf(vertex3dv),
    glVertex3f: *const @TypeOf(vertex3f),
    glVertex3fv: *const @TypeOf(vertex3fv),
    glVertex3i: *const @TypeOf(vertex3i),
    glVertex3iv: *const @TypeOf(vertex3iv),
    glVertex3s: *const @TypeOf(vertex3s),
    glVertex3sv: *const @TypeOf(vertex3sv),
    glVertex4d: *const @TypeOf(vertex4d),
    glVertex4dv: *const @TypeOf(vertex4dv),
    glVertex4f: *const @TypeOf(vertex4f),
    glVertex4fv: *const @TypeOf(vertex4fv),
    glVertex4i: *const @TypeOf(vertex4i),
    glVertex4iv: *const @TypeOf(vertex4iv),
    glVertex4s: *const @TypeOf(vertex4s),
    glVertex4sv: *const @TypeOf(vertex4sv),
    glVertexAttrib1d: *const @TypeOf(vertexAttrib1d),
    glVertexAttrib1dv: *const @TypeOf(vertexAttrib1dv),
    glVertexAttrib1f: *const @TypeOf(vertexAttrib1f),
    glVertexAttrib1fv: *const @TypeOf(vertexAttrib1fv),
    glVertexAttrib1s: *const @TypeOf(vertexAttrib1s),
    glVertexAttrib1sv: *const @TypeOf(vertexAttrib1sv),
    glVertexAttrib2d: *const @TypeOf(vertexAttrib2d),
    glVertexAttrib2dv: *const @TypeOf(vertexAttrib2dv),
    glVertexAttrib2f: *const @TypeOf(vertexAttrib2f),
    glVertexAttrib2fv: *const @TypeOf(vertexAttrib2fv),
    glVertexAttrib2s: *const @TypeOf(vertexAttrib2s),
    glVertexAttrib2sv: *const @TypeOf(vertexAttrib2sv),
    glVertexAttrib3d: *const @TypeOf(vertexAttrib3d),
    glVertexAttrib3dv: *const @TypeOf(vertexAttrib3dv),
    glVertexAttrib3f: *const @TypeOf(vertexAttrib3f),
    glVertexAttrib3fv: *const @TypeOf(vertexAttrib3fv),
    glVertexAttrib3s: *const @TypeOf(vertexAttrib3s),
    glVertexAttrib3sv: *const @TypeOf(vertexAttrib3sv),
    glVertexAttrib4Nbv: *const @TypeOf(vertexAttrib4Nbv),
    glVertexAttrib4Niv: *const @TypeOf(vertexAttrib4Niv),
    glVertexAttrib4Nsv: *const @TypeOf(vertexAttrib4Nsv),
    glVertexAttrib4Nub: *const @TypeOf(vertexAttrib4Nub),
    glVertexAttrib4Nubv: *const @TypeOf(vertexAttrib4Nubv),
    glVertexAttrib4Nuiv: *const @TypeOf(vertexAttrib4Nuiv),
    glVertexAttrib4Nusv: *const @TypeOf(vertexAttrib4Nusv),
    glVertexAttrib4bv: *const @TypeOf(vertexAttrib4bv),
    glVertexAttrib4d: *const @TypeOf(vertexAttrib4d),
    glVertexAttrib4dv: *const @TypeOf(vertexAttrib4dv),
    glVertexAttrib4f: *const @TypeOf(vertexAttrib4f),
    glVertexAttrib4fv: *const @TypeOf(vertexAttrib4fv),
    glVertexAttrib4iv: *const @TypeOf(vertexAttrib4iv),
    glVertexAttrib4s: *const @TypeOf(vertexAttrib4s),
    glVertexAttrib4sv: *const @TypeOf(vertexAttrib4sv),
    glVertexAttrib4ubv: *const @TypeOf(vertexAttrib4ubv),
    glVertexAttrib4uiv: *const @TypeOf(vertexAttrib4uiv),
    glVertexAttrib4usv: *const @TypeOf(vertexAttrib4usv),
    glVertexAttribI1i: *const @TypeOf(vertexAttribI1i),
    glVertexAttribI1iv: *const @TypeOf(vertexAttribI1iv),
    glVertexAttribI1ui: *const @TypeOf(vertexAttribI1ui),
    glVertexAttribI1uiv: *const @TypeOf(vertexAttribI1uiv),
    glVertexAttribI2i: *const @TypeOf(vertexAttribI2i),
    glVertexAttribI2iv: *const @TypeOf(vertexAttribI2iv),
    glVertexAttribI2ui: *const @TypeOf(vertexAttribI2ui),
    glVertexAttribI2uiv: *const @TypeOf(vertexAttribI2uiv),
    glVertexAttribI3i: *const @TypeOf(vertexAttribI3i),
    glVertexAttribI3iv: *const @TypeOf(vertexAttribI3iv),
    glVertexAttribI3ui: *const @TypeOf(vertexAttribI3ui),
    glVertexAttribI3uiv: *const @TypeOf(vertexAttribI3uiv),
    glVertexAttribI4bv: *const @TypeOf(vertexAttribI4bv),
    glVertexAttribI4i: *const @TypeOf(vertexAttribI4i),
    glVertexAttribI4iv: *const @TypeOf(vertexAttribI4iv),
    glVertexAttribI4sv: *const @TypeOf(vertexAttribI4sv),
    glVertexAttribI4ubv: *const @TypeOf(vertexAttribI4ubv),
    glVertexAttribI4ui: *const @TypeOf(vertexAttribI4ui),
    glVertexAttribI4uiv: *const @TypeOf(vertexAttribI4uiv),
    glVertexAttribI4usv: *const @TypeOf(vertexAttribI4usv),
    glVertexAttribIPointer: *const @TypeOf(vertexAttribIPointer),
    glVertexAttribPointer: *const @TypeOf(vertexAttribPointer),
    glVertexPointer: *const @TypeOf(vertexPointer),
    glViewport: *const @TypeOf(viewport),
    glWindowPos2d: *const @TypeOf(windowPos2d),
    glWindowPos2dv: *const @TypeOf(windowPos2dv),
    glWindowPos2f: *const @TypeOf(windowPos2f),
    glWindowPos2fv: *const @TypeOf(windowPos2fv),
    glWindowPos2i: *const @TypeOf(windowPos2i),
    glWindowPos2iv: *const @TypeOf(windowPos2iv),
    glWindowPos2s: *const @TypeOf(windowPos2s),
    glWindowPos2sv: *const @TypeOf(windowPos2sv),
    glWindowPos3d: *const @TypeOf(windowPos3d),
    glWindowPos3dv: *const @TypeOf(windowPos3dv),
    glWindowPos3f: *const @TypeOf(windowPos3f),
    glWindowPos3fv: *const @TypeOf(windowPos3fv),
    glWindowPos3i: *const @TypeOf(windowPos3i),
    glWindowPos3iv: *const @TypeOf(windowPos3iv),
    glWindowPos3s: *const @TypeOf(windowPos3s),
    glWindowPos3sv: *const @TypeOf(windowPos3sv),
    //#endregion Fields

    /// Initializes the specified dispatch table. Returns `true` if successful, `false` otherwise.
    ///
    /// This function must be called successfully before passing the dispatch table to
    /// `makeDispatchTableCurrent()`, `invoke()`, `invokeIntercepted()` or accessing any of its
    /// fields.
    ///
    /// `loader` is duck-typed and can be either a container or an instance, so long as it satisfies
    /// the following code:
    ///
    /// ```
    /// const prefixed_command_name: [:0]const u8 = "glExample";
    /// const AnyCFnPtr = *align(@alignOf(fn () callconv(.C) void)) const anyopaque;
    /// const fn_ptr_opt: ?AnyCFnPtr = loader.GetCommandFnPtr(prefixed_command_name);
    /// _ = fn_ptr_opt;
    /// ```
    ///
    /// No references to `loader` are retained after this function returns. There is no
    /// corresponding `deinit()` function.
    pub fn init(self: *DispatchTable, loader: anytype) bool {
        @setEvalBranchQuota(1_000_000);
        var success: u1 = 1;
        inline for (@typeInfo(DispatchTable).Struct.fields) |field_info| {
            const prefixed_feature_name = comptime nullTerminate(field_info.name);
            switch (@typeInfo(field_info.type)) {
                .Pointer => |ptr_info| switch (@typeInfo(ptr_info.child)) {
                    .Fn => success &= @intFromBool(self.load(loader, prefixed_feature_name)),
                    else => comptime unreachable,
                },
                else => comptime unreachable,
            }
        }
        return success != 0;
    }

    fn nullTerminate(comptime string: []const u8) [:0]const u8 {
        comptime {
            var buf: [string.len + 1]u8 = undefined;
            std.mem.copy(u8, &buf, string);
            buf[string.len] = 0;
            return buf[0..string.len :0];
        }
    }

    fn load(
        self: *DispatchTable,
        loader: anytype,
        comptime prefixed_command_name: [:0]const u8,
    ) bool {
        const FieldType = @TypeOf(@field(self, prefixed_command_name));
        const AnyCFnPtr = *align(@alignOf(fn () callconv(.C) void)) const anyopaque;
        const fn_ptr_opt: ?AnyCFnPtr = loader.getCommandFnPtr(prefixed_command_name);
        if (fn_ptr_opt) |fn_ptr| {
            @field(self, prefixed_command_name) = @ptrCast(fn_ptr);
            return true;
        } else {
            return @typeInfo(FieldType) == .Optional;
        }
    }

    /// Invokes the specified OpenGL command with the specified arguments. The invocation will not
    /// be intercepted.
    pub fn invoke(
        self: *const DispatchTable,
        comptime prefixed_command_name: [:0]const u8,
        args: anytype,
    ) ReturnType(prefixed_command_name) {
        const FieldType = @TypeOf(@field(self, prefixed_command_name));
        return if (@typeInfo(FieldType) == .Optional)
            @call(.auto, @field(self, prefixed_command_name).?, args)
        else
            @call(.auto, @field(self, prefixed_command_name), args);
    }

    /// Invokes the specified OpenGL command with the specified arguments. The invocation will be
    /// intercepted by `options.intercept()`.
    pub fn invokeIntercepted(
        self: *const DispatchTable,
        comptime prefixed_command_name: [:0]const u8,
        args: anytype,
    ) ReturnType(prefixed_command_name) {
        return options.intercept(self, prefixed_command_name, args);
    }

    pub fn ReturnType(comptime prefixed_command_name: [:0]const u8) type {
        const FieldType = @TypeOf(@field(@as(DispatchTable, undefined), prefixed_command_name));
        if (@hasField(DispatchTable, prefixed_command_name)) {
            switch (@typeInfo(FieldType)) {
                .Pointer => |ptr_info| switch (@typeInfo(ptr_info.child)) {
                    .Fn => |fn_info| return fn_info.return_type.?,
                    else => comptime unreachable,
                },
                .Bool => {},
                .Optional => |opt_info| switch (@typeInfo(opt_info.child)) {
                    .Pointer => |ptr_info| switch (@typeInfo(ptr_info.child)) {
                        .Fn => |fn_info| return fn_info.return_type.?,
                        else => comptime unreachable,
                    },
                    else => comptime unreachable,
                },
                else => comptime unreachable,
            }
        }
        @compileError("unknown command: '" ++ prefixed_command_name ++ "'");
    }
};

/// Options that can be overriden by publicly declaring a container named `gl_options` in the root
/// source file.
pub const options = struct {
    /// Intercepts OpenGL command invocations.
    pub const intercept: @TypeOf(struct {
        fn intercept(
            dispatch_table: *const DispatchTable,
            comptime prefixed_command_name: [:0]const u8,
            args: anytype,
        ) DispatchTable.ReturnType(prefixed_command_name) {
            _ = args;
            _ = dispatch_table;
            comptime unreachable;
        }
    }.intercept) = if (@hasDecl(options_overrides, "intercept"))
        options_overrides.intercept
    else
        DispatchTable.invoke;
};

const options_overrides = if (@hasDecl(root, "gl_options")) root.gl_options else struct {};

comptime {
    for (@typeInfo(options_overrides).Struct.decls) |decl| {
        if (!@hasDecl(options, decl.name)) @compileError("unknown option: '" ++ decl.name ++ "'");
    }
}

test {
    @setEvalBranchQuota(1_000_000);
    std.testing.refAllDeclsRecursive(@This());
}
