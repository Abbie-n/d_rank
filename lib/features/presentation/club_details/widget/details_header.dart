import 'package:d_rank/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            const XMargin(32),
            TextWidget(
              name,
              fontSize: 18,
              textColor: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
