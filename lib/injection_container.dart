import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'features/home/data/datasources/manga_remote_datasource.dart';
import 'features/home/data/repositories/manga_repository_impl.dart';
import 'features/home/domain/repositories/manga_repository.dart';
import 'features/home/domain/usecases/get_latest_mangas.dart';
import 'features/home/presentation/bloc/manga_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final apiBase = dotenv.env['MANGA_API_BASE']!;

  sl.registerLazySingleton<MangaRemoteDataSource>(
    () => MangaRemoteDataSourceImpl(apiBase),
  );

  sl.registerLazySingleton<MangaRepository>(() => MangaRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GetLatestManga(sl()));

  sl.registerFactory(() => MangaBloc(getLatestManga: sl()));
}
