const std = @import("std");

const Command = enum {
    validate,
    lint,
    convert,
};

const CommonFlags = enum {
    outputFile,
    filePath,
};

const ValidateFlags = enum {};
const LintFlags = enum {};
const ConvertFlags = enum {};

const ValidationError = error{
    ValidationFailed,
};

fn validate(file_path: []const u8) !void {
    const fs = std.fs;
    // const allocator = std.heap.page_allocator;

    // Open the file
    var file = try fs.cwd().openFile(file_path, .{});
    defer file.close();

    // Create a buffered reader for efficient line reading
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined; // Buffer to store each line
    var line_num: usize = 0; // Track line number for error reporting

    // Parse line-by-line
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        line_num += 1;
        const trimmed = std.mem.trimRight(u8, line, "\r\n");

        std.debug.print("{s}\n", .{trimmed}); // This is a line to test code

        // Skip empty lines and comments
        if (trimmed.len == 0 or trimmed[0] == '#') continue;

        // Validate the line (simple dummy rule for now: must contain ':')
        // if (!std.mem.contains(u8, trimmed, ":")) {
        //     std.debug.print("Validation Error at line {d}: Missing ':'\n", .{line_num});
        //     return error.ValidationFailed;
        // }

        // Additional validation logic can go here...
    }

    // If the file is empty after reading, report it
    if (line_num == 0) {
        std.debug.print("Validation Failed: File is empty.\n", .{});
        return error.ValidationFailed;
    }

    std.debug.print("Validated file '{s}' successfully!\n", .{file_path});
}

fn lint() !void {
    std.debug.print("Linted!!!\n", .{});
}

fn convert() !void {
    std.debug.print("Converted!!!\n", .{});
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    // Get the command-line arguments
    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();

    // Skip the first argument (the program name)
    _ = args.next();

    // Check if we have a command (like "validate", "lint", "convert")
    if (args.next()) |str| {
        const case = std.meta.stringToEnum(Command, str) orelse {
            std.debug.print("Unrecognized Command: {s}\n", .{str});
            return;
        };

        // Ensure we have a file path argument
        if (args.next()) |file_path| {
            switch (case) {
                .validate => try validate(file_path),
                .lint => try lint(),
                .convert => try convert(),
            }
        } else {
            std.debug.print("Error: Missing required file path argument.\n", .{});
        }
    } else {
        std.debug.print("Usage: zson <command> <file_path>\n", .{});
    }
}

// Test with zig build run -- <command>
