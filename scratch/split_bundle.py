import os

project_root = r"C:\Users\HP\AndroidStudioProjects/MyApplication"

# Create 3 sub-bundles to avoid Google AI Studio Agent 12MB single file timeout
bundle_1_file = os.path.join(project_root, "ZENO_1_CORE_DOMAIN_SERVICES.txt")
bundle_2_file = os.path.join(project_root, "ZENO_2_PRODUCT_STUDIO_WORKSTATIONS.txt")
bundle_3_file = os.path.join(project_root, "ZENO_3_NAVIGATION_POS_ADMIN.txt")

excluded_dirs = ['.git', '.dart_tool', 'build', 'android', 'ios', 'windows', 'macos', 'linux', 'web', '.artifacts', 'scratch']

f1 = open(bundle_1_file, 'w', encoding='utf-8')
f2 = open(bundle_2_file, 'w', encoding='utf-8')
f3 = open(bundle_3_file, 'w', encoding='utf-8')

f1.write("# ZENO PART 1: CORE ARCHITECTURE, DOMAIN MODELS & SERVICES\n\n")
f2.write("# ZENO PART 2: PRODUCT STUDIO, FASHION WORKSTATION & INGESTION\n\n")
f3.write("# ZENO PART 3: NAVIGATION, POS, ADMIN & FINANCE MODULES\n\n")

count_1, count_2, count_3 = 0, 0, 0

for root, dirs, files in os.walk(project_root):
    dirs[:] = [d for d in dirs if d not in excluded_dirs]
    for file in files:
        if file.endswith('.dart') or file.endswith('.yaml') or file.endswith('.md'):
            filepath = os.path.join(root, file)
            relpath = os.path.relpath(filepath, project_root)

            if "ZENO_" in file or "repomix" in file:
                continue

            try:
                with open(filepath, 'r', encoding='utf-8', errors='ignore') as infile:
                    content = infile.read()
                    entry = f"\n{'='*80}\nFILE: {relpath}\n{'='*80}\n\n{content}\n"

                    if "domain" in relpath or "core" in relpath or "data" in relpath:
                        f1.write(entry)
                        count_1 += 1
                    elif "inventory" in relpath or "product_studio" in relpath or "fashion" in relpath or "ingestion" in relpath:
                        f2.write(entry)
                        count_2 += 1
                    else:
                        f3.write(entry)
                        count_3 += 1
            except Exception as e:
                print(f"Error {relpath}: {e}")

f1.close()
f2.close()
f3.close()

print(f"SUCCESS: Part 1 ({count_1} files), Part 2 ({count_2} files), Part 3 ({count_3} files)")
