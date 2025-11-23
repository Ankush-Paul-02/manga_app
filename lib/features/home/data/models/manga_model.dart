import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/entities/manga_entity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MangaModel extends MangaEntity {
  MangaModel({
    required super.id,
    required super.title,
    super.altTitle,
    required super.description,
    super.year,
    required super.status,
    required super.contentRating,
    required super.tags,
    super.coverArtId,
    super.coverUrl,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final relationships = json['relationships'] as List?;

    String? coverArtId;
    List<String> tags = [];

    if (relationships != null) {
      for (final rel in relationships) {
        if (rel['type'] == 'cover_art') {
          coverArtId = rel['id'];
        }
        if (rel['type'] == 'tag') {
          tags.add(rel['attributes']['name']['en'] ?? "Unknown");
        }
      }
    }

    return MangaModel(
      id: json['id'],
      title:
          attributes['title']?['en'] ??
          attributes['title']?['ja-ro'] ??
          "Unknown Title",
      altTitle: attributes['altTitles']?.isNotEmpty == true
          ? attributes['altTitles'][0].values.first
          : null,
      description: attributes['description']?['en'] ?? "No description",
      year: attributes['year'],
      status: attributes['status'] ?? "",
      contentRating: attributes['contentRating'] ?? "",
      tags: tags,
      coverArtId: coverArtId,
      coverUrl: null, // will be filled later in repository
    );
  }

  /// Fetch cover file name from Mangadex and build full coverUrl
  static Future<String?> buildCoverUrl(
    String mangaId,
    String coverArtId,
  ) async {
    if (coverArtId.isEmpty) return null;

    final apiBase = dotenv.env['MANGA_API_BASE']!;
    final coverBase = dotenv.env['MANGA_COVER_BASE']!;

    final url = "$apiBase/cover/$coverArtId";
    final res = await http.get(Uri.parse(url));

    if (res.statusCode != 200) return null;

    final jsonData = jsonDecode(res.body);
    final fileName = jsonData['data']['attributes']['fileName'];
    return "$coverBase/$mangaId/$fileName.256.jpg";
  }
}
