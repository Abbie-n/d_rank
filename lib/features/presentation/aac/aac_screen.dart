import 'dart:convert';
import 'package:d_rank/core/services/api/api_exception.dart';
import 'package:d_rank/features/model/data_model.dart';
import 'package:d_rank/features/presentation/aac/widget/aac_header.dart';
import 'package:d_rank/features/presentation/aac/widget/aac_single_item.dart';
import 'package:d_rank/features/presentation/cubit/get_data_cubit.dart';
import 'package:d_rank/features/presentation/cubit/get_data_state.dart';
import 'package:d_rank/hook/use_data_sync_hook.dart';
import 'package:d_rank/shared/extensions/build_context_extension.dart';
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
    final shouldAscend = useState(true);
    final dataState = useState(<DataModel>[]);

    useDataSync(
      dataSyncCallback: () async {
        cubit.call(shouldReload: true);
      },
      pollSchedule: const Duration(hours: 24),
      keys: [cubit],
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: BlocConsumer<GetDataCubit, GetDataState>(
        bloc: cubit,
        listener: (context, state) {
          state.maybeWhen(
            finished: (data) => WidgetsBinding.instance
                .addPostFrameCallback((_) => dataState.value = data),
            orElse: () => null,
          );
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                AACHeader(onFilter: () async {
                  shouldAscend.value = !shouldAscend.value;
                  await cubit.filterList(
                      list: dataState.value, shouldAscend: shouldAscend.value);
                }),
                state.maybeWhen(
                  loading: () => const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: CircularLoadingWidget(
                      height: 200,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  finished: (data) => Expanded(
                    child: RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: () async {
                        cubit.call(shouldReload: true);
                      },
                      child: ListView.separated(
                        itemCount: dataState.value.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => AACSingleItem(
                          country: '${data[index].country}',
                          image: '${data[index].image}',
                          name: '${data[index].name}',
                          value: '${data[index].value}',
                          onTap: () => context.goNamed(
                            'club-details',
                            params: {
                              'data': jsonEncode(data[index]),
                            },
                          ),
                        ),
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.black,
                          height: 4,
                        ),
                      ),
                    ),
                  ),
                  error: (e) {
                    final message = e == NetworkException()
                        ? context.l10n.no_internet
                        : e == NullException()
                            ? context.l10n.no_data
                            : context.l10n.an_error_occured;

                    return Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextWidget(
                        message,
                        textColor: Colors.red,
                      ),
                    );
                  },
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
