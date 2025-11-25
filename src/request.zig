const std = @import("std");
const net = std.Io.net;

pub fn read_request(io: std.Io, stream: net.Stream, buffer: []u8) !void {
    var read_buffer: [1024]u8 = undefined;
    var reader: net.Stream.Reader = stream.reader(io, &read_buffer);

    var i: usize = 0;
    var value: ?u8 = reader.interface.takeByte() catch null;
    while (value) |not_null_value| {
        buffer[i] = not_null_value;
        value = reader.interface.takeByte() catch null;
        i += 1;
    }
}
