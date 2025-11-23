import 'package:flutter_bloc/flutter_bloc.dart';
import '../../routes/app_routes.dart';
import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState(0)) {
    on<BottomNavChange>((event, emit) {
      emit(BottomNavState(event.index));
    });

    on<BottomNavSyncWithRoute>((event, emit) {
      int newIndex = 0;

      if (event.location.startsWith(AppRoutes.home)) {
        newIndex = 0;
      } else if (event.location.startsWith(AppRoutes.mangas)) {
        newIndex = 1;
      } else if (event.location.startsWith(AppRoutes.favourite)) {
        newIndex = 2;
      }

      emit(BottomNavState(newIndex));
    });
  }
}
