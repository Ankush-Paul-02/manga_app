// Updated AppPage with optimized GoRouter listener, safe context usage, and cleanup.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import 'core/bloc/nav/bottom_nav_bloc.dart';
import 'core/bloc/nav/bottom_nav_event.dart';
import 'core/bloc/nav/bottom_nav_state.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/app_utits.dart';

class AppPage extends StatefulWidget {
  final Widget child;

  const AppPage({super.key, required this.child});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late final VoidCallback _routerListener;

  @override
  void initState() {
    super.initState();

    /// Router listener handled safely using `mounted` check
    _routerListener = () {
      if (!mounted) return;
      final location = GoRouter.of(context).state.fullPath ?? "/";
      context.read<BottomNavBloc>().add(BottomNavSyncWithRoute(location));
    };

    GoRouter.of(context).routerDelegate.addListener(_routerListener);
  }

  @override
  void dispose() {
    /// Remove listener to avoid memory leaks
    GoRouter.of(context).routerDelegate.removeListener(_routerListener);
    super.dispose();
  }

  void _onTap(int index) {
    context.read<BottomNavBloc>().add(BottomNavChange(index));

    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.mangas);
        break;
      case 2:
        context.go(AppRoutes.favourite);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: AlignmentGeometry.bottomCenter,

            child: BottomBar(
              fit: StackFit.expand,
              width: 90.w,
              barAlignment: Alignment.bottomCenter,
              iconHeight: 8.w,
              iconWidth: 8.w,
              start: 2,
              end: 0,
              offset: 10,
              showIcon: true,
              barColor: Colors.black,
              borderRadius: BorderRadius.circular(5.w),
              curve: Curves.decelerate,
              barDecoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.90),
                borderRadius: BorderRadius.circular(5.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.12),
                    blurRadius: 14,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              iconDecoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(3.w),
              ),
              hideOnScroll: true,
              scrollOpposite: false,
              body: (context, controller) => widget.child,
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(
                      icon: Icons.home,
                      selected: state.index == 0,
                      onTap: () => _onTap(0),
                    ),
                    _navItem(
                      icon: Icons.menu_book,
                      selected: state.index == 1,
                      onTap: () => _onTap(1),
                    ),
                    _navItem(
                      icon: Icons.favorite,
                      selected: state.index == 2,
                      onTap: () => _onTap(2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _navItem({
  required IconData icon,
  required bool selected,
  required VoidCallback onTap,
}) {
  return AnimatedScale(
    duration: const Duration(milliseconds: 200),
    scale: selected ? 1.5 : 1.0,
    curve: Curves.easeOut,
    child: Material(
      color: Colors.transparent,
      child: InkResponse(
        onTap: onTap,
        radius: 25.w,
        containedInkWell: true,
        borderRadius: BorderRadius.circular(25.w),
        child: Icon(
          icon,
          size: 6.w,
          color: selected ? kAccentColor : Colors.white,
        ),
      ),
    ),
  );
}
