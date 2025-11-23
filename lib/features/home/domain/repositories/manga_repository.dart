import '../entities/manga_entity.dart';

abstract class MangaRepository {
  Future<List<MangaEntity>> getLatestMangas();
}
