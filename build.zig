// build.zig - Concept compilation script for Aura Moby
const std = @import("std");

pub fn build(b: *std.Build) void {
    // 1. Establish cross-compilation target and release optimization levels
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // 2. Instantiate a static C-ABI artifact library container
    const lib = b.addStaticLibrary(.{
        .name = "aurabridge",
        .target = target,
        .optimize = optimize,
    });

    // 3. Inject native C/Zig bridging interfaces
    lib.addCSourceFile(.{
        .file = b.path("native/bridge.zig"),
        .flags = &[_][]const u8{ "-Wall", "-Wextra" },
    });

    // 4. Compile and link the 21.7% pure assembly code layout
    lib.addAssemblyFile(b.path("native/windows1252.yasm"));

    // 5. Enforce standard system C library linking paths
    lib.linkLibC();

    // 6. Direct the compiler to output the build object to ../build/native
    const artifact = b.addInstallArtifact(lib, .{});
    b.getInstallStep().dependOn(&artifact.step);
}
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Example step to compile a Go binary utilizing Zig as the high-performance cross-compiler link
    const go_build = b.addSystemCommand(&.{ "go", "build" });
    
    // Define environment arguments to inject Zig's compilation architecture into Go 
    go_build.addArgs(&.{ "-ldflags", "-w -s", "-o", "server" });

    // Expose this runner task via target invocation line: `zig build run-go`
    const run_step = b.step("run-go", "Compile application utilizing standard execution frameworks");
    run_step.dependency(&go_build.step);
}
