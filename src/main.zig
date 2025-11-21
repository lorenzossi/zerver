const std = @import("std");
const net = std.Io.net;
const print = std.debug.print;

pub fn main() !void {
    // Prints to stderr, ignoring potential errors.
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    const ip_addr = try net.IpAddress.parse("172.0.0.1", 3843);
    print("Port: {d}\n", .{ip_addr.ip4.port});

    // const socket = ip_addr.bind(, options: BindOptions)
}
