const std = @import("std");

pub const Parser = struct {
    const Method = enum { GET, HEAD, POST, PUT, DELETE, CONNECT, OPTIONS, TRACE, PATCH };

    method: Method = undefined,

    pub fn parse(self: Parser, buffer: *[8192]u8) void {
        const space_index = std.mem.indexOfScalar(u8, buffer, ' ') orelse return error.InvalidRequest;

        const method_str = buffer[0..space_index];
        self.method = try parseMethod(method_str);

        std.debug.print("{s}\n", .{buffer});
    }

    fn parseMethod(name: []const u8) !Method {
        inline for (@typeInfo(Method).Enum.fields) |field| {
            if (std.ascii.eqlIgnoreCase(field.name, name))
                return field;
        }
        return error.UnknownMethod;
    }
};
