import 'dart:async';

import 'package:logger/logger.dart';

T? safeTry<T>(T? Function() block,
    {T? Function(dynamic, dynamic)? onError, Logger? logger}) {
  logger = logger ?? Logger();
  try {
    final result = block();
    if (result is Future) {
      result.onError((e, stackTrace) {
        logger?.e(e);
      });
    }
    return result;
  } catch (e, stack) {
    logger.e(e);
    return onError != null ? onError(e, stack) : null;
  }
}

Future<T?> safeTryAsync<T>(FutureOr<T> Function() block,
    {FutureOr<T?> Function(dynamic)? onError, Logger? logger}) async {
  logger = logger ?? Logger();
  try {
    final result = await block();
    return result;
  } catch (e) {
    logger.e(e);
    return onError != null ? onError(e) : null;
  }
}

extension FutureExtension<T extends Object> on Future<T> {
  Future<T?> safeTry({FutureOr<T?> Function(dynamic)? onError}) {
    return safeTryAsync(() => this, onError: onError);
  }
}

extension FutureFunctionExtension<T extends Object> on Future<T> Function() {
  Future<T?> safeTry({FutureOr<T?> Function(dynamic)? onError}) {
    return safeTryAsync(this, onError: onError);
  }
}
