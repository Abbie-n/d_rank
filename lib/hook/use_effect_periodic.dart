import 'dart:async';
import 'dart:ui';

import 'package:flutter_hooks/flutter_hooks.dart';

void useEffectPeriodic(Duration duration, VoidCallback callback, List<Object>? keys) {
  useEffect(() {
    final timer = Timer.periodic(duration, (_) => callback());
    return timer.cancel;
  }, keys);
}
