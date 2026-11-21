import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  late final GetStorage _box;
  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  T? read<T>(String k) => _box.read<T>(k);
  Future<void> write(String k, dynamic v) => _box.write(k, v);
  List<Map<String, dynamic>> list(String k) =>
      (_box.read<List>(k) ?? []).map((e) => Map<String, dynamic>.from(e as Map)).toList();
  Future<void> saveList(String k, List<Map<String, dynamic>> v) => _box.write(k, v);
}
