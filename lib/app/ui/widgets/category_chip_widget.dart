import 'package:flutter/material.dart';
// import 'package:bad';

class CategoryChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final IconData? icon;
  final VoidCallback? onTap;
  const CategoryChipWidget(
      {super.key,
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
              child: Badge(
                padding: EdgeInsets.all(2),

                label: Text('2', style: TextStyle(fontSize: 8),),
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
