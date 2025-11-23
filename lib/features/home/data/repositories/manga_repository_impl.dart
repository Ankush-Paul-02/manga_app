import '../../domain/entities/manga_entity.dart';
import '../../domain/repositories/manga_repository.dart';
import '../datasources/manga_remote_datasource.dart';

class MangaRepositoryImpl implements MangaRepository {
  final MangaRemoteDataSource remoteDataSource;

  MangaRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MangaEntity>> getLatestMangas() async {
    final models = await remoteDataSource.fetchLatestMangas();
    return models; // models extend entity
  }
}
