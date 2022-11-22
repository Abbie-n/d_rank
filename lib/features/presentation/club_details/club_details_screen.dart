import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_rank/features/model/data_model.dart';
import 'package:d_rank/features/presentation/club_details/widget/details_header.dart';
import 'package:d_rank/features/presentation/cubit/get_data_cubit.dart';
import 'package:d_rank/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClubDetailsScreen extends HookConsumerWidget {
  const ClubDetailsScreen({super.key, required this.data});
  final DataModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getDataCubitProvider);

    useEffect(() {
      cubit.call();
      return null;
    }, []);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            DetailsHeader(name: data.name!),
            Container(
              color: Colors.black87,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 15),
              child: Column(
                children: [
                  CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                      child: CircularLoadingWidget(height: 50),
                    ),
                    errorWidget: (context, url, _) => const SizedBox.shrink(),
                    imageUrl: data.image!,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 180,
                      width: 180,
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: Image.network(
                        data.image!,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      data.country,
                      textColor: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const YMargin(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                text: TextSpan(
                  text: 'The club ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: '${data.name} ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          'of ${data.country} has a value of ${data.value} Euro',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
