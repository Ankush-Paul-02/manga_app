import '../entities/manga_entity.dart';
import '../repositories/manga_repository.dart';

class GetLatestManga {
  final MangaRepository repository;

  GetLatestManga(this.repository);

  Future<List<MangaEntity>> call() async {
    return await repository.getLatestMangas();
  }
}
