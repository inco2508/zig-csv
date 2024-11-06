const std = @import("std");

pub fn main() !void {
    const dir = std.fs.cwd();
    const file = try dir.openFile("input.csv", .{});
    const reader = file.reader();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var rows = std.ArrayList(std.ArrayList([]const u8)).init(allocator);

    // TODO : maybe find something better than a hardlimit of 1024
    while (try reader.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024)) |data| {
        var row = std.ArrayList([]const u8).init(allocator);

        var splitIterator = std.mem.splitAny(u8, data, ",");

        while (splitIterator.next()) |column| {
            // TODO : if i do that some characters are not printed ???
            // std.debug.print("{s}    ", .{column});
            std.debug.print("{s}", .{column});
            try row.append(column);
        }

        std.debug.print("\n", .{});

        // TODO : maybe i can't convert the row from an arraylist to a []const u8 ??
        // TODO : same for rows to [][]const u8
        try rows.append(row);
    }

    std.debug.print("{!}\n", .{rows});
}
