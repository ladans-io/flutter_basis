import '../errors/exports.dart';

typedef TypeCacheCall<T> = T;

mixin CacheFailureOrSuccess {
  (Failure?, T?) getCacheFailureorSuccess<T>(
    TypeCacheCall<T> call,
  ) {
    try {
      final result = call;

      return (null, result);
    } on CacheException catch (e) {
      return (CacheFailure(message: e.toString()), null);
    } on DshSocketException catch (e) {
      return (CommonFailure(message: e.formattedMessage), null);
    } catch (e) {
      return (CommonFailure(message: e.toString()), null);
    }
  }
}
