import '../errors/exports.dart';

typedef TypeCacheCall<T> = T;

mixin CacheResultHandler {
  (Failure?, T?) handleCacheResult<T>(
    TypeCacheCall<T> call,
  ) {
    try {
      return (null, call);
    } on CacheException catch (e) {
      return (CacheFailure(message: e.toString()), null);
    } on BasisSocketException catch (e) {
      return (CommonFailure(message: e.formattedMessage), null);
    } catch (e) {
      return (CommonFailure(message: e.toString()), null);
    }
  }
}
