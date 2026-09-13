import os
import zipfile

project_root = r"C:\Users\HP\AndroidStudioProjects/MyApplication"
output_zip = os.path.join(project_root, "ZENO_BOS_SOURCE_CODE.zip")

excluded_dirs = ['.git', '.dart_tool', 'build', 'android', 'ios', 'windows', 'macos', 'linux', 'web', '.artifacts', 'scratch']

files_zipped = 0

with zipfile.ZipFile(output_zip, 'w', zipfile.ZIP_DEFLATED) as zipf:
    for root, dirs, files in os.walk(project_root):
        dirs[:] = [d for d in dirs if d not in excluded_dirs]
        for file in files:
            if file.endswith('.dart') or file.endswith('.yaml') or file.endswith('.md'):
                filepath = os.path.join(root, file)
                relpath = os.path.relpath(filepath, project_root)

                if "ZENO_" in file or "repomix" in file:
                    continue

                zipf.write(filepath, relpath)
                files_zipped += 1

print(f"SUCCESS: Zipped {files_zipped} source files into {output_zip}")
