import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:manga_app/injection_container.dart';
import 'package:sizer/sizer.dart';

import 'features/home/presentation/bloc/manga_bloc.dart';
import 'features/home/presentation/bloc/manga_event.dart';
import 'features/home/presentation/pages/home_page.dart';

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
        BlocProvider(create: (_) => sl<MangaBloc>()..add(LoadMangaEvent())),
      ],
      child: Sizer(
        builder: (_, _, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Manga Hut",
          theme: ThemeData.dark(),
          home: const HomePage(),
        ),
      ),
    );
  }
}
