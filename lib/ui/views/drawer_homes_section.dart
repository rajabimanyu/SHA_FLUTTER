import 'package:flutter/material.dart';

class DrawerHomesSection extends StatefulWidget {
  const DrawerHomesSection({
    super.key,
    required this.homesList,
    required this.onHomeClick,
  });

  final List<String> homesList;
  final void Function(String home) onHomeClick;

  @override
  State<DrawerHomesSection> createState() => _DrawerHomesSectionState();
}

class _DrawerHomesSectionState extends State<DrawerHomesSection> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Widget _buildTitleRow(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: _toggleExpansion,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: const Icon(Icons.home),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Homes',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleLarge,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeItem(BuildContext context, String itemName) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: () {
        widget.onHomeClick(itemName);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        width: double.infinity,
        child: Text(
          itemName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget _buildHomesList(BuildContext context) {
    final theme = Theme.of(context);
    return Ink(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.homesList.map((element) {
          return _buildHomeItem(context, element);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: AnimatedCrossFade(
          crossFadeState: !_isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
          firstChild: _buildTitleRow(context),
          secondChild: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleRow(context),
              _buildHomesList(context),
            ],
          ),
        ),
      ),
    );
  }
}
