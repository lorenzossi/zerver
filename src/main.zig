const std = @import("std");
const net = std.Io.net;
const print = std.debug.print;
const log = std.log;

const Server = @import("server.zig").Server;
const Request = @import("request.zig");
const Parser = @import("parser.zig").Parser;

pub fn main() !void {
    log.info("Starting server...", .{});

    const address = try net.IpAddress.parseIp4("127.0.0.1", 8000);
    log.info("Listening on address {f}", .{address});

    var alloc = std.heap.DebugAllocator(.{}){};
    const memory = alloc.allocator();
    defer _ = alloc.deinit();

    var threaded: std.Io.Threaded = .init(memory);
    defer threaded.deinit();
    const io = threaded.io();

    var listener = try address.listen(io, .{ .reuse_address = true });
    defer listener.deinit(io);

    while (listener.accept(io)) |conn| {
        defer conn.close(io);
        // log.info("Connection established with: {f}\n", .{conn.socket.address});

        var request_buffer: [8192]u8 = undefined;
        var request_len: usize = 0;
        try Request.read_request(io, conn, request_buffer[0..], &request_len);

        const parser: Parser = .{};
        _ = parser.parse(&request_buffer);
    } else |err| {
        log.err("Error while accepting connection: {any}", .{err});
    }
}
