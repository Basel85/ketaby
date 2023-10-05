import 'package:ketaby/core/helpers/cache_helper.dart';

class MakeTheUserAnOldUserRepository {
  static final CacheHelper _cacheHelper = SecureStorageHelper();
  static void makeTheUserAnOldUser() async{
    await _cacheHelper.setData(key: 'old_user', value: "");
  }
}
