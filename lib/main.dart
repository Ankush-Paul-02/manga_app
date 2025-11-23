import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:manga_app/core/bloc/nav/bottom_nav_bloc.dart';
import 'package:manga_app/core/routes/app_router_config.dart';
import 'package:manga_app/injection_container.dart';
import 'package:sizer/sizer.dart';

import 'features/home/presentation/bloc/manga_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MangaBloc>()),
        BlocProvider(create: (_) => BottomNavBloc()),
      ],
      child: Sizer(
        builder: (_, _, _) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: "Manga Hut",
          theme: ThemeData.dark(),
          routerConfig: router,
        ),
      ),
    );
  }
}
