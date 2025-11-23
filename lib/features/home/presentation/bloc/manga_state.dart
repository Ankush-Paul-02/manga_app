import 'package:equatable/equatable.dart';
import '../../domain/entities/manga_entity.dart';

abstract class MangaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MangaInitial extends MangaState {}

class MangaLoading extends MangaState {}

class MangaLoaded extends MangaState {
  final List<MangaEntity> mangaList;

  MangaLoaded(this.mangaList);

  @override
  List<Object?> get props => [mangaList];
}

class MangaError extends MangaState {
  final String message;

  MangaError(this.message);

  @override
  List<Object?> get props => [message];
}
