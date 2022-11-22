import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef CubitProviderCreate<T extends Closable> = T Function(Ref);

/// creates a new cubit-provider using Provider.autoDispose, and closes the cubit when disposing
/// the provider
AutoDisposeProvider<T> cubitAutoDispose<T extends Closable>(
    CubitProviderCreate<T> create) {
  return Provider.autoDispose<T>((ref) {
    final cubit = create(ref);
    ref.onDispose(cubit.close);
    return cubit;
  });
}
