import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_latest_mangas.dart';
import 'manga_event.dart';
import 'manga_state.dart';

class MangaBloc extends Bloc<MangaEvent, MangaState> {
  final GetLatestManga getLatestManga;

  MangaBloc({required this.getLatestManga}) : super(MangaInitial()) {
    on<LoadMangaEvent>(_onLoad);
  }

  Future<void> _onLoad(LoadMangaEvent event, Emitter<MangaState> emit) async {
    emit(MangaLoading());
    try {
      final data = await getLatestManga(event.limit);
      emit(MangaLoaded(data));
    } catch (e) {
      emit(MangaError(e.toString()));
    }
  }
}
