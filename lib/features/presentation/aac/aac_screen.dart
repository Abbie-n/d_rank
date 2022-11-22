import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_rank/features/presentation/cubit/get_data_cubit.dart';
import 'package:d_rank/features/presentation/cubit/get_data_state.dart';
import 'package:d_rank/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AACScreen extends HookConsumerWidget {
  const AACScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cubit = ref.watch(getDataCubitProvider);

    useEffect(() {
      cubit.call();
      return null;
    }, []);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: BlocBuilder<GetDataCubit, GetDataState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                Material(
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
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                state.maybeWhen(
                  finished: (data) => Expanded(
                    child: ListView.separated(
                      itemCount: data.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => Container(
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
                              errorWidget: (context, url, _) =>
                                  const SizedBox.shrink(),
                              imageUrl: data[index].image ?? '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 100,
                                width: 120,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 9),
                                child: Image.network(
                                  data[index].image!,
                                ),
                              ),
                            ),
                            const XMargin(15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.75,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    data[index].name,
                                    fontSize: 20,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const YMargin(5),
                                  TextWidget(
                                    data[index].country,
                                    fontSize: 14,
                                    textColor: AppColors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const YMargin(5),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextWidget(
                                      '${data[index].value} millions',
                                      fontSize: 18,
                                      textColor:
                                          AppColors.darkText.withOpacity(.8),
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
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.black,
                        height: 4,
                      ),
                    ),
                  ),
                  error: (message) => Center(
                    child: TextWidget(
                      message,
                      textColor: Colors.red,
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
