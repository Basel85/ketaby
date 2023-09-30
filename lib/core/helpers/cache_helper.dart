import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class CacheHelper {
  Future<bool> setData({
    required String key,
    required dynamic value,
  });

   getData({
    required String key,
  });

  Future<bool> deleteData({
    required String key,
  });
}

class SecureStorageHelper extends CacheHelper {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Future<bool> deleteData({required String key}) async {
    await storage.delete(key: key);
    return true;
  }

  @override
   getData({required String key}) {
    return storage.read(key: key);
  }

  @override
  Future<bool> setData({required String key, required value}) async {
    await storage.write(key: key, value: value);
    return true;
  }
}
