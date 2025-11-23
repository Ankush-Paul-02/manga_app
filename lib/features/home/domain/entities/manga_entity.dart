class MangaEntity {
  final String id;
  final String title;
  final String? altTitle;
  final String description;
  final int? year;
  final String status;
  final String contentRating;
  final List<String> tags;
  final String? coverArtId;

  String? coverUrl;

  MangaEntity({
    required this.id,
    required this.title,
    this.altTitle,
    required this.description,
    this.year,
    required this.status,
    required this.contentRating,
    required this.tags,
    this.coverArtId,
    this.coverUrl,
  });
}
