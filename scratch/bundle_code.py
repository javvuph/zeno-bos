import os

project_root = r"C:\Users\HP\AndroidStudioProjects/MyApplication"
output_file = os.path.join(project_root, "ZENO_BOS_FULL_CODEBASE.txt")

extensions_to_include = ['.dart', '.yaml', '.md']
excluded_dirs = ['.git', '.dart_tool', 'build', 'android', 'ios', 'windows', 'macos', 'linux', 'web', '.artifacts', 'scratch']

files_written = 0
total_lines = 0

with open(output_file, 'w', encoding='utf-8') as outfile:
    outfile.write("# ZENO BOS — COMPLETE PROJECT SOURCE CODE BUNDLE FOR GOOGLE AI STUDIO\n")
    outfile.write("# INCLUDES ALL DART SOURCE FILES, CONFIGURATIONS, MANIFESTS, AND REGISTRIES\n\n")

    for root, dirs, files in os.walk(project_root):
        dirs[:] = [d for d in dirs if d not in excluded_dirs]
        for file in files:
            if any(file.endswith(ext) for ext in extensions_to_include):
                filepath = os.path.join(root, file)
                relpath = os.path.relpath(filepath, project_root)

                if file in ["ZENO_BOS_FULL_CODEBASE.txt", "repomix-output.txt"]:
                    continue

                try:
                    with open(filepath, 'r', encoding='utf-8', errors='ignore') as infile:
                        content = infile.read()
                        lines = content.count('\n') + 1
                        total_lines += lines
                        files_written += 1

                        outfile.write(f"\n{'='*80}\n")
                        outfile.write(f"FILE: {relpath}\n")
                        outfile.write(f"{'='*80}\n\n")
                        outfile.write(content)
                        outfile.write("\n")
                except Exception as e:
                    print(f"Error reading {relpath}: {e}")

print(f"SUCCESS: Bundled {files_written} files ({total_lines} lines) into {output_file}")
