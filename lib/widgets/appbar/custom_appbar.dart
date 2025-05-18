import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final double height;

  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.height = 80, // default height
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Row(
            children: [
              // Leading widget or default logo
              leading ??
                  Icon(Icons.arrow_back),

              const SizedBox(width: 12),

              // Title or default 'Home'
              Text(
                title ?? 'Home',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const Spacer(),

              // Actions list or default notification icon button
              if (actions != null && actions!.isNotEmpty)
                ...actions!
              else
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications, color: Colors.black),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
