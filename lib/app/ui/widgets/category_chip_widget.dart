import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class CategoryChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final int? badgeCount;
  final IconData? icon;
  final VoidCallback? onTap;
  const CategoryChipWidget(
      {super.key,
      this.badgeCount,
      required this.label,
      this.isSelected = false,
      this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surface,
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.black12,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Visibility(
              visible: icon != null,
              child: badges.Badge(
                badgeAnimation: badges.BadgeAnimation.scale(),
                showBadge: badgeCount != null && badgeCount! > 0,
                position: badges.BadgePosition.topStart(),
                badgeContent: badgeCount != null
                    ? Text(
                        badgeCount!.toString(),
                        style: TextStyle(
                            color: colorScheme.onPrimary, fontSize: 8),
                      )
                    : null,
                child: Icon(
                  icon,
                  size: 16,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface.withValues(alpha: .6),
                ),
              ),
            ),
            Visibility(
              visible: icon != null,
              child: SizedBox(
                width: 6,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface.withValues(alpha: .6),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
