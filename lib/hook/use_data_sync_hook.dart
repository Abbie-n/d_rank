import 'dart:ui';

import './use_effect_periodic.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// a hooks that is used for syncing data from the backend.
/// it will run dataSyncCallback immediately,
/// and then run it periodically every [pollSchedule],
/// and every time the app is brought to the foreground.
void useDataSync(
    {Duration pollSchedule = const Duration(minutes: 1),
    required VoidCallback dataSyncCallback,
    Future<void> Function()? cancelDataSync,
    List<Object>? keys = const []}) {
  useEffect(() {
    dataSyncCallback();

    return cancelDataSync;
  }, keys);

  useOnAppLifecycleStateChange((from, to) {
    if (to == AppLifecycleState.resumed) {
      dataSyncCallback();
    } else {
      cancelDataSync?.call();
    }
  });

  useEffectPeriodic(pollSchedule, dataSyncCallback, const []);
}
