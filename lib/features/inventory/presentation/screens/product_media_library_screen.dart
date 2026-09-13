import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';

class ProductMediaLibraryScreen extends StatelessWidget {
  final bool isImages;

  const ProductMediaLibraryScreen({super.key, this.isImages = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZenoHeader(
          title: isImages ? "Product Image Library" : "Product Document Vault",
          subtitle: isImages
              ? "Manage all high-resolution product photography and brand assets."
              : "Centralized repository for technical specifications, manuals, and certifications.",
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload, size: 16),
              label: Text(isImages ? "Upload Images" : "Upload Documents"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: isImages ? _buildImageGrid() : _buildDocumentList(),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: 24,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: ZenoTheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ZenoTheme.border),
          ),
          child: Stack(
            children: [
              const Center(
                  child: Icon(Icons.image,
                      color: ZenoTheme.textSecondary, size: 32)),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  color: Colors.black54,
                  child: Text("img_${index + 1}.jpg",
                      style: const TextStyle(fontSize: 9, color: Colors.white),
                      textAlign: TextAlign.center),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: IconButton(
                  icon: const Icon(Icons.more_vert,
                      size: 14, color: Colors.white),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDocumentList() {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ZenoTheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ZenoTheme.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.picture_as_pdf, color: ZenoTheme.danger),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Technical_Specs_X15.pdf",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    Text("Last modified: Oct 24, 2024 • 2.4 MB",
                        style: TextStyle(
                            fontSize: 11, color: ZenoTheme.textSecondary)),
                  ],
                ),
              ),
              TextButton(onPressed: () {}, child: const Text("View")),
              const SizedBox(width: 8),
              IconButton(
                  icon: const Icon(Icons.download, size: 18), onPressed: () {}),
            ],
          ),
        );
      },
    );
  }
}
