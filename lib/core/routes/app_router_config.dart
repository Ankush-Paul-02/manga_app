import 'package:go_router/go_router.dart';
import 'package:manga_app/core/routes/app_routes.dart';
import 'package:manga_app/features/favourite/pages/manga_favourites_page.dart';
import 'package:manga_app/features/mangas/pages/mangas_page.dart';

import '../../app_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

final router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppPage(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.mangas,
          builder: (context, state) => const MangasPage(),
        ),
        GoRoute(
          path: AppRoutes.favourite,
          builder: (context, state) => const MangaFavouritesPage(),
        ),
      ],
    ),
  ],
);
