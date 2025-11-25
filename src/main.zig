const std = @import("std");
const net = std.Io.net;
const print = std.debug.print;

const Server = @import("server.zig").Server;
const Request = @import("request.zig");

pub fn main() !void {
    var alloc = std.heap.DebugAllocator(.{}){};
    const memory = alloc.allocator();
    defer _ = alloc.deinit();

    var threaded: std.Io.Threaded = .init(memory);
    defer threaded.deinit();
    const io = threaded.io();

    const server = Server.init(io, try net.IpAddress.parseIp4("127.0.0.1", 8000));
    var listen = try server.listen();

    const connection = try listen.accept(io);
    defer connection.close(io);

    var request_buffer: [10000]u8 = undefined;
    @memset(request_buffer[0..], 0);
    try Request.read_request(io, connection, request_buffer[0..]);

    std.debug.print("{s}\n", .{request_buffer});
}
