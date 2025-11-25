const std = @import("std");
const net = std.Io.net;

pub const Server = struct {
    io: std.Io,
    address: net.IpAddress,

    pub fn init(io: std.Io, address: net.IpAddress) Server {
        return Server{
            .io = io,
            .address = address,
        };
    }

    pub fn listen(self: Server) !net.Server {
        return try self.address.listen(self.io, .{ .reuse_address = true });
    }
};
