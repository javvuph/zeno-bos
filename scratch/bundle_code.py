import os

root_dir = r"C:\Users\HP\AndroidStudioProjects\MyApplication\lib"
output_file = r"C:\Users\HP\AndroidStudioProjects\MyApplication\ZENO_FULL_CODEBASE.txt"

with open(output_file, "w", encoding="utf-8") as out:
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file.endswith(".dart"):
                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, os.path.dirname(root_dir))
                out.write(f"\n{'='*80}\n")
                out.write(f"FILE: {rel_path}\n")
                out.write(f"{'='*80}\n\n")
                try:
                    with open(full_path, "r", encoding="utf-8") as f:
                        out.write(f.read())
                except Exception as e:
                    out.write(f"ERROR READING FILE: {e}\n")
                out.write("\n")

print(f"Codebase bundled to {output_file}")
