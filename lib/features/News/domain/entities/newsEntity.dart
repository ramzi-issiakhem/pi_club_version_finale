class NewsEntity {
  final String coverImage;
  final List<String> images;
  final String title;
  final String description;
  final int likes;
  final DateTime lastModification;

  NewsEntity(
      {required this.coverImage,
      required this.lastModification,
      required this.images,
      required this.title,
      required this.description,
      required this.likes});
}
