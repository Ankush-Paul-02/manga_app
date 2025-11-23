import '../entities/manga_entity.dart';
import '../repositories/manga_repository.dart';

class GetLatestManga {
  final MangaRepository repository;

  GetLatestManga(this.repository);

  Future<List<MangaEntity>> call(int limit) async {
    return await repository.getLatestMangas(limit);
  }
}
