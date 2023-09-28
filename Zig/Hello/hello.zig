const std = @import("std");
const assert = std.debug.assert;

var x: i32 = 1;

test "checking" {
    assert(x == 1);
}

pub fn main() !void {
    std.debug.print("Hey World\n", .{});
}