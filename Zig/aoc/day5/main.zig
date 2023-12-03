const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    // _ = allocator;

    var file = try std.fs.cwd().openFile("smolinput.txt", .{});
    defer file.close();
    // var reader = std.io.bufferedReader(file.reader());
    // // var line = "";
    var buf: [1024]u8 = undefined;
    // const message = "The quick brown fox.";

    // var writer = std.io.bufferedWriter(buf);

    // const line = try file.reader().readAllAlloc(
    //     allocator,
    //     1024,
    // );
    // var array_list = std.ArrayList(u8).init(allocator);
    // defer array_list.deinit();
    // try reader.reader().streamUntilDelimiter(array_list.writer(), "\n", 1024);
    // var stack = std.ArrayList(u8).init(
    //     allocator,
    // );
    var stacks = std.ArrayList(std.ArrayList(u8)).init(
        allocator,
    );
    for (0..8) |_| {
        var s = std.ArrayList(u8).init(
            allocator,
        );
        try stacks.append(s);
    }

    var line = try file.reader().readUntilDelimiterOrEof(&buf, '\n');
    // std.debug.print("line: {s}\n", .{line});
    for (0..8) |i| {
        std.debug.print("i: {d} | line: {?s}!\n", .{ i, line });
        for (0..@min(line.?.len-2, 8 * 4 - 1)) |index| {
            if (index % 4 == 1 and line.?[index] != ' ') {
                // std.debug.print("'{}':{c} ", .{(index / 4), line.?[index]});
                try stacks.items[(index / 4)].append(line.?[index]);
            }
        }
        // std.debug.print("\n", .{});
        // if (line.?.len > 2) {
        // try stacks.items[i / 4].append(line.?[1]);
        // }
        line = try file.reader().readUntilDelimiterOrEof(&buf, '\n');
    }
    // line = try file.reader().readUntilDelimiterOrEof(&buf, '\n');
    std.debug.print("\t     {?s}\n", .{line});
    line = try file.reader().readUntilDelimiterOrEof(&buf, '\n');
    // var line = try file.reader().readUntilDelimiter(&buf, '\n');
    // var line = try reader.reader().readUntilDelimiter( &buf, '\n');

    // var instream = reader.reader().streamUntilDelimiter(line, "\n");
    // const stdout = std.io.getStdOut().writer();
    // _ = stdout;
    // std.

    // std.debug.print("line: {d}!end\n", .{line});
    for (stacks.items, 0..) |stack, i| {
        std.debug.print("stack {d}: {s}\n", .{i, stack.items});
    }

    while (line != null) {
        std.debug.print("{?s}\n", .{ line });
        // std.debug.print("\n", .{});
        // if (line.?.len > 2) {
        // try stacks.items[i / 4].append(line.?[1]);
        // }
        line = try file.reader().readUntilDelimiterOrEof(&buf, '\n');
    }

    // std.debug.print("line: {?d}\n!", .{line});
    // std.debug.print("buf: {d}\n", .{buf});
    // try stdout.print("Hello, {s}!\n", .{"world"});
    // std.debug.print("Hello, {s}!\n", .{"World"});
}
