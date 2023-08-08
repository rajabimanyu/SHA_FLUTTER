import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final String? navigateToRoute;
  final VoidCallback? onClick;

  const DrawerItem({
    required this.title,
    this.iconData,
    this.navigateToRoute,
    this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: InkWell(
          onTap: () {
            if (navigateToRoute != null) {
              Navigator.of(context).pushNamed(navigateToRoute!);
              Scaffold.of(context).closeDrawer();
            } else {
              onClick?.call();
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (iconData != null)
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Icon(iconData),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleLarge,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
