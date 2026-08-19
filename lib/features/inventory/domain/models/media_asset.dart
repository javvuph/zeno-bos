class MediaAsset {
  final String id;
  final String url;
  final String thumbnailUrl;
  final int sortOrder;
  final String altText;
  final bool isPrimary;

  MediaAsset({
    required this.id,
    required this.url,
    required this.thumbnailUrl,
    required this.sortOrder,
    this.altText = "",
    this.isPrimary = false,
  });
}
