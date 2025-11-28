const std = @import("std");
const net = std.Io.net;

pub fn read_request(io: std.Io, stream: net.Stream, buffer: []u8, length: *usize) !void {
    var read_buffer: [1]u8 = undefined;
    var reader: net.Stream.Reader = stream.reader(io, &read_buffer);

    const delim = "\r\n\r";

    var i: usize = 0;
    var value: ?u8 = reader.interface.takeByte() catch null;
    while (value) |not_null_value| : (i += 1) {
        if (not_null_value == '\n' and i >= 3) {
            if (std.mem.eql(u8, buffer[(i - 3)..(i)], delim)) {
                buffer[i] = not_null_value;
                length.* += 1;
                break;
            }
        }

        buffer[i] = not_null_value;
        length.* += 1;
        value = reader.interface.takeByte() catch null;
    }
}
