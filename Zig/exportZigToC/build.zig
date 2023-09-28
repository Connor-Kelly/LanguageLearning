// const Builder = @import("std").build.Builder;

// pub fn build(b: *Builder) void {
//     const lib = b.addSharedLibrary(.{
//         .name = "mathtest",
//         .root_source_file = .{ .path = "mathtest.zig" },
//         .version = .{ .major = 1, .minor = 0, .patch = 0 },
//         // .version = b.version(1, 0, 0)
//     });

//     const exe = b.addExecutable("test", null);
//     exe.addCSourceFile("test.c", &[_][]const u8{"-std=c99"});
//     exe.linkLibrary(lib);
//     exe.linkSystemLibrary("c");

//     b.default_step.dependOn(&exe.step);

//     const run_cmd = exe.run();

//     const test_step = b.step("test", "Test the program");
//     test_step.dependOn(&run_cmd.step);
// }
const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});
    const lib = b.addSharedLibrary(.{
        .name = "mathtest",
        // .optimize =,
        .target = target,
        .optimize = optimize,
        .root_source_file = .{ .path = "mathtest.zig" },
        .version = .{ .major = 1, .minor = 0, .patch = 0 },
    });
    // const lib = b.addSharedLibrary("mathtest", "mathtest.zig", b.version(1, 0, 0));
    // lib.femit_h = true;
    const exe = b.addExecutable(.{ .name = "test" });
    exe.addCSourceFile(.{ .file = .{ .path = "test.c" }, .flags = &[_][]const u8{"-std=c99"} });
    exe.linkLibrary(lib);
    exe.linkSystemLibrary("c");

    b.default_step.dependOn(&exe.step);

    // const run_cmd = exe.run();
    const run_cmd = b.addRunArtifact(exe);

    const test_step = b.step("test", "Test the program");
    test_step.dependOn(&run_cmd.step);
}
