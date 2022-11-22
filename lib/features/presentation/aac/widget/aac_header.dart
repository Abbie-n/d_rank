import 'package:d_rank/shared/shared.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AACHeader extends StatelessWidget {
  const AACHeader({super.key, required this.onFilter});

  final Function()? onFilter;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(
              'all about clubs',
              fontSize: 18,
              textColor: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            IconButton(
              onPressed: onFilter,
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
