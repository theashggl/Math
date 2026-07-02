import 'package:flutter/material.dart';

class AppBarOfScaffold extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const AppBarOfScaffold({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20),
      child: AppBar(
        title: Text(title),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
