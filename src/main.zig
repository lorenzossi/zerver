const std = @import("std");
const net = std.Io.net;
const print = std.debug.print;

const Server = @import("server.zig").Server;

pub fn main() !void {
    const server = Server.init(try net.IpAddress.parseIp4("127.0.0.1", 8000));

    print("This is the Ip: {any}\n", .{server.address});

    // print("letto: {d}\n", .{reader_len});
}
