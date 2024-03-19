import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/ui/config/app_router.dart';
import 'package:flix/ui/features/favorite/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationScreen extends StatefulWidget {
  final StatefulNavigationShell child;

  const BottomNavigationScreen({super.key, required this.child});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _bottomTab(),
    );
  }

  _bottomTab() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: context.loc.home,
          icon: const Icon(Icons.home_outlined),
        ),
        BottomNavigationBarItem(
          label: context.loc.favorite,
          icon: const Icon(Icons.favorite_outline),
        ),
        BottomNavigationBarItem(
          label: context.loc.account,
          icon: const Icon(Icons.account_box_outlined),
        ),
      ],
      currentIndex: widget.child.currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      unselectedItemColor: Theme.of(context).colorScheme.onBackground,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        widget.child.goBranch(
          index,
          initialLocation: index == widget.child.currentIndex,
        );
        setState(() {});
        if (index == 1) {
          BlocProvider.of<FavoriteBloc>(context).add(const LoadFavorites());
        }
      },
    );
  }
}
