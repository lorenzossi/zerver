const std = @import("std");

pub const Parser = struct {
    const HTTPHeader = struct {};

    pub fn parse(buffer: *[8192]u8) !void {
        std.debug.print("{s}\n", .{buffer});
    }
};

// GET / HTTP/1.1
// Host: 127.0.0.1:8000
// User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0
// Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
// Accept-Language: it-IT,it;q=0.8,en-US;q=0.5,en;q=0.3
// Accept-Encoding: gzip, deflate, br, zstd
// Connection: keep-alive
// Upgrade-Insecure-Requests: 1
// Sec-Fetch-Dest: document
// Sec-Fetch-Mode: navigate
// Sec-Fetch-Site: none
// Sec-Fetch-User: ?1
// DNT: 1
// Sec-GPC: 1
// Priority: u=0, i
