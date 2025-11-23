import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/manga_model.dart';

abstract class MangaRemoteDataSource {
  Future<List<MangaModel>> fetchLatestMangas(int limit);
}

class MangaRemoteDataSourceImpl implements MangaRemoteDataSource {
  final String baseUrl;

  MangaRemoteDataSourceImpl(this.baseUrl);

  @override
  Future<List<MangaModel>> fetchLatestMangas(int limit) async {
    final uri = Uri.parse(
      "$baseUrl?limit=$limit"
      "&includedTagsMode=AND"
      "&excludedTagsMode=OR"
      "&contentRating[]=safe"
      "&contentRating[]=suggestive"
      "&contentRating[]=erotica"
      "&order[latestUploadedChapter]=desc",
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Failed to load manga");
    }

    final data = jsonDecode(response.body);
    final list = data['data'] as List;

    // Convert to MangaModel
    final mangas = list.map((e) => MangaModel.fromJson(e)).toList();

    // Fetch cover URLs for each manga
    for (var manga in mangas) {
      if (manga.coverArtId != null) {
        manga.coverUrl = await MangaModel.buildCoverUrl(
          manga.id,
          manga.coverArtId!,
        );
      }
    }

    return mangas;
  }
}
