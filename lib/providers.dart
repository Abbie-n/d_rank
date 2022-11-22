import 'package:d_rank/core/config/injection.dart';
import 'package:d_rank/core/services/api/api_service.dart';
import 'package:d_rank/core/services/storage/offline_client.dart';
import 'package:d_rank/features/repository/data_repository.dart';
import 'package:d_rank/features/repository/data_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dataRepositoryProvider = Provider<DataRepository>(
  (ref) => DataRepositoryImpl(
    offlineClient: getIt<OfflineClient>(),
    apiService: getIt<ApiService>(),
  ),
);
