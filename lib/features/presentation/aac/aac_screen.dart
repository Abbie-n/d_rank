import 'dart:convert';
import 'package:d_rank/features/presentation/aac/widget/aac_header.dart';
import 'package:d_rank/features/presentation/aac/widget/aac_single_item.dart';
import 'package:d_rank/features/presentation/cubit/get_data_cubit.dart';
import 'package:d_rank/features/presentation/cubit/get_data_state.dart';
import 'package:d_rank/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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
                const AACHeader(),
                state.maybeWhen(
                  finished: (data) => Expanded(
                    child: ListView.separated(
                      itemCount: data.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => context.goNamed(
                          'club-details',
                          params: {
                            'data': jsonEncode(data[index]),
                          },
                        ),
                        child: AACSingleItem(
                          country: '${data[index].country}',
                          image: '${data[index].image}',
                          name: '${data[index].name}',
                          value: '${data[index].value}',
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.black,
                        height: 4,
                      ),
                    ),
                  ),
                  error: (message) => Padding(
                    padding: const EdgeInsets.only(top: 40),
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
