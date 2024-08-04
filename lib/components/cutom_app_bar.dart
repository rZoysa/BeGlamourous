import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? icon;
  final Function()? onIconPressed;
  const CustomAppBar({
    super.key,
    this.icon,
    this.onIconPressed,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 14, bottom: 12),
      color: const Color.fromARGB(60, 0, 0, 0),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Be Glamourous',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Jura',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.icon != null)
              IconButton(
                onPressed: widget.onIconPressed!,
                icon: widget.icon!,
              ),
          ],
        ),
      ),
    );
  }

  Size get preferredSize => const Size.fromHeight(60);
}
