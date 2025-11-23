import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/core/helper/ui_helper.dart';
import 'package:manga_app/features/home/presentation/pages/widgets/foryou_card.dart';
import 'package:manga_app/features/home/presentation/pages/widgets/now_card.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/app_utits.dart';
import '../bloc/manga_bloc.dart';
import '../bloc/manga_event.dart';
import '../bloc/manga_state.dart';
import 'widgets/overlap_carousal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MangaBloc>().add(LoadMangaEvent(10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        centerTitle: false,
        elevation: 0,
        title: Text('MANGA HUT', style: kTitleStyle),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 8.w),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: kPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(2),

            /// Carousel
            const OverlapCarousel(),

            UIHelper.verticalSpace(2),

            /// Now Section
            Text('Now', style: kTitleStyle),

            UIHelper.verticalSpace(1),

            const NowCard(),

            UIHelper.verticalSpace(2),

            /// For You Section (Bloc)
            BlocBuilder<MangaBloc, MangaState>(
              builder: (context, state) {
                if (state is MangaLoading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: kPadding.h),
                      child: const CircularProgressIndicator(
                        color: kAccentColor,
                      ),
                    ),
                  );
                }

                if (state is MangaError) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: kPadding.h),
                    child: Text(
                      "Failed: ${state.message}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is MangaLoaded) {
                  final mangas = state.mangaList;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('FOR YOU', style: kTitleStyle),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 8.w,
                          ),
                        ],
                      ),
                      UIHelper.verticalSpace(1),
                      SizedBox(
                        height: 32.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: mangas.length,
                          separatorBuilder: (_, _) =>
                              UIHelper.horizontalSpace(3),
                          itemBuilder: (_, i) {
                            final m = mangas[i];
                            return ForyouCard(
                              image:
                                  m.coverUrl ??
                                  "https://via.placeholder.com/150",
                              title: m.title,
                              chapter: m.year != null
                                  ? "Year: ${m.year}"
                                  : "No year",
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            UIHelper.verticalSpace(2),
          ],
        ),
      ),
    );
  }
}
