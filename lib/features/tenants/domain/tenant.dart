import 'package:ejary/core/crud.dart';

class Tenant {
  Tenant({required this.id, required this.name, required this.phone});
  final String id, name, phone;
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'phone': phone};
  factory Tenant.fromJson(Map<String, dynamic> j) =>
      Tenant(id: j['id'], name: j['name'], phone: j['phone'] ?? '');
}

abstract class TenantRepository extends CrudRepository<Tenant> {}
