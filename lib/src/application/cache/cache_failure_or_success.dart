import 'package:flutter/foundation.dart';

import '../errors/exports.dart';

typedef TypeCacheCall<T> = T;

mixin CacheResultHandler {
  (Failure?, T?) handleCacheResult<T>(
    TypeCacheCall<T> call, {
      Function(Object)? onCatch, 
      VoidCallback? onTry,
    }
  ) {
    try {
      if (onTry != null) onTry();

      return (null, call);
    } on BasisCacheException catch (e) {
      return (CacheFailure(message: e.toString()), null);
    } on BasisSocketException catch (e) {
      return (CommonFailure(message: e.formattedMessage), null);
    } catch (e) {
      if (onCatch != null) onCatch(e);

      return (CommonFailure(message: e.toString()), null);
    }
  }
}
