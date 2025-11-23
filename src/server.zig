const std = @import("std");
const net = std.Io.net;

pub const Server = struct {
    address: net.IpAddress,

    pub fn init(address: net.IpAddress) Server {
        return Server{
            .address = address,
        };
    }

    // const ip_addr = try net.IpAddress.parse("127.0.0.1", 8000);

    // var gpa = std.heap.DebugAllocator(.{}){};
    // defer _ = gpa.deinit();
    // const allocator = gpa.allocator();

    // var threaded: std.Io.Threaded = std.Io.Threaded.init(allocator);
    // defer threaded.deinit();
    // const io = threaded.io();

    // var listener = try ip_addr.listen(io, .{ .reuse_address = true });
    // defer listener.deinit(io);

    // const connection = try listener.accept(io);
    // defer connection.close(io);

    // var buffer: [4096]u8 = undefined;

    // var reader = connection.reader(io, &buffer);

    // var request_string: [8192]u8 = [_]u8{0} ** 8192;
    // const request = read_request(&reader.interface, &request_string);

    // print("{any}\n", .{request});

};
