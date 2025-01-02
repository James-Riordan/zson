// const std = @import("std");

// pub const Command = enum {
//     Validate,
//     Convert,

//     pub fn fromString(s: []const u8) ?Command {
//         const commands = [_][]const u8{
//             "validate",
//             "convert",
//         };

//         var idx: usize = 0;
//         inline for (commands) |command| {
//             if (std.mem.eql(u8, s, command)) {
//                 return @enumFromInt(idx);
//             }
//             idx += 1;
//         }
//         return null;
//     }
// };

// pub fn main() !void {
//     const allocator = std.heap.page_allocator;

//     const args = try std.process.argsAlloc(allocator);
//     defer std.process.argsFree(allocator, args);

//     if (args.len <= 1) {
//         std.debug.print("Usage: zson <command> [file path]\n", .{});
//         return;
//     }

//     const command_str = args[1];
//     const command = try Command.fromString(command_str);

//     switch (command) {
//         .Validate => {
//             if (args.len != 3) {
//                 std.debug.print("Usage: zson validate <file path>\n", .{});
//                 return;
//             }
//             const file_path = args[2];
//             try validateZson(file_path);
//         },
//         .Convert => {
//             if (args.len != 3) {
//                 std.debug.print("Usage: zson convert <file path>\n", .{});
//                 return;
//             }
//             const file_path = args[2];
//             try convertZsonToJson(file_path);
//         },
//         else => {
//             std.debug.print("Unknown command: {s}\n", .{command_str});
//             std.debug.print("Available commands: validate, convert\n", .{});
//         },
//     }
// }

// fn validateZson(file_path: []const u8) !void {
//     const fs = std.fs.cwd();
//     const file = try fs.openFile(file_path, .{ .read = true });
//     defer file.close();

//     const file_content = try file.readToEndAlloc(std.heap.page_allocator, 1024 * 1024);
//     defer std.heap.page_allocator.free(file_content);

//     // Placeholder validation logic: Check if the file starts with a '{'
//     if (file_content.len == 0 or file_content[0] != '{') {
//         std.debug.print("Validation failed for: {s}\n", .{file_path});
//         return error.InvalidData;
//     }
//     std.debug.print("Validation successful for: {s}\n", .{file_path});
// }

// fn convertZsonToJson(file_path: []const u8) !void {
//     const fs = std.fs.cwd();
//     const file = try fs.openFile(file_path, .{ .read = true });
//     defer file.close();

//     const file_content = try file.readToEndAlloc(std.heap.page_allocator, 1024 * 1024);
//     defer std.heap.page_allocator.free(file_content);

//     // Placeholder: Just outputs the same file content as JSON
//     const output_path = "output.json";
//     const output_file = try fs.createFile(output_path, .{});
//     defer output_file.close();

//     try output_file.writeAll(file_content);
//     std.debug.print("Converted {s} to JSON and saved as {s}\n", .{ file_path, output_path });
// }

// test "validate dummy zson file" {
//     const allocator = std.testing.allocator;

//     const dummy_content = "{ \"key\": \"value\" }";
//     const fs = std.fs.testing;

//     // Create a temporary file
//     const temp_file = try fs.createTempFile("dummy.zson");
//     defer temp_file.delete() catch |err| {
//         std.debug.print("Error cleaning up temp file: {s}\n", .{err});
//     };

//     // Write dummy content to the file
//     try temp_file.writeAll(dummy_content);

//     // Rewind the file to the beginning
//     try temp_file.seek(0, .Start);

//     // Validate the file
//     const file_content = try temp_file.readToEndAlloc(allocator, 1024 * 1024);
//     defer allocator.free(file_content);

//     if (file_content.len == 0 or file_content[0] != '{') {
//         std.debug.print("Validation failed for dummy file\n", .{});
//         return error.InvalidData;
//     }
//     try std.testing.expectEqualStrings(dummy_content, file_content);
// }
