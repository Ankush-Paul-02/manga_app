import 'package:equatable/equatable.dart';

abstract class MangaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMangaEvent extends MangaEvent {
  final int limit;
  LoadMangaEvent(this.limit);
}
