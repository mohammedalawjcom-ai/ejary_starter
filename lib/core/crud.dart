import 'storage_service.dart';

abstract class CrudRepository<T> {
  List<T> all();
  Future<void> save(T e);
  Future<void> delete(String id);
}

/// GetStorage-backed implementation (swap with an API datasource later).
class LocalCrud<T> implements CrudRepository<T> {
  LocalCrud(this._s, this._key, this._from, this._to, this._id);
  final StorageService _s;
  final String _key;
  final T Function(Map<String, dynamic>) _from;
  final Map<String, dynamic> Function(T) _to;
  final String Function(T) _id;

  @override
  List<T> all() => _s.list(_key).map(_from).toList();

  @override
  Future<void> save(T e) async {
    final l = _s.list(_key);
    final i = l.indexWhere((m) => m['id'] == _id(e));
    if (i >= 0) {
      l[i] = _to(e);
    } else {
      l.add(_to(e));
    }
    await _s.saveList(_key, l);
  }

  @override
  Future<void> delete(String id) async {
    final l = _s.list(_key)..removeWhere((m) => m['id'] == id);
    await _s.saveList(_key, l);
  }
}
