import 'package:get_storage/get_storage.dart';

class CacheHelper {
  static late GetStorage box;

  static Future<void> init() async {
    await GetStorage.init();
    box = GetStorage();
  }

  static dynamic getData({
    required String key,
  })        {
    return box.read(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    await box.write(key, value);
    return true;
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    await box.remove(key);
    return true;
  }
}
