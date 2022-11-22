import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_rank/shared/extensions/build_context_extension.dart';
import 'package:d_rank/shared/shared.dart';
import 'package:flutter/material.dart';

class AACSingleItem extends StatelessWidget {
  const AACSingleItem({
    super.key,
    required this.name,
    required this.image,
    required this.country,
    required this.value,
    required this.onTap,
  });

  final String name;
  final String image;
  final String country;
  final String value;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              placeholder: (context, url) => const Center(
                child: CircularLoadingWidget(height: 50),
              ),
              errorWidget: (context, url, _) => const SizedBox.shrink(),
              imageUrl: image,
              imageBuilder: (context, imageProvider) => Container(
                height: 100,
                width: 100,
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Image.network(
                  image,
                ),
              ),
            ),
            const XMargin(5),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    name,
                    fontSize: 20,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  const YMargin(5),
                  TextWidget(
                    country,
                    fontSize: 14,
                    textColor: AppColors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  const YMargin(5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextWidget(
                      '$value ${context.l10n.millions}',
                      fontSize: 18,
                      textColor: AppColors.darkText.withOpacity(.8),
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
