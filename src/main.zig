const std = @import("std");
const net = std.Io.net;
const print = std.debug.print;

pub fn main() !void {
    const ip_addr = try net.IpAddress.parse("127.0.0.1", 8000);

    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var threaded: std.Io.Threaded = std.Io.Threaded.init(allocator);
    defer threaded.deinit();
    const io = threaded.io();

    var listener = try ip_addr.listen(io, .{ .reuse_address = true });
    defer listener.deinit(io);

    const connection = try listener.accept(io);
    defer connection.close(io);

    var buffer: [1024]u8 = undefined;

    var reader = connection.reader(io, &buffer);
    const readed_bytes = try reader.interface.peekArray(10);

    // print("{any}\n", .{@TypeOf(readed_bytes)});

    print("letto: {s}\n", .{readed_bytes[0..readed_bytes.len]});
}
