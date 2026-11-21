import 'package:ejary/core/crud.dart';

class ServiceItem {
  ServiceItem({required this.id, required this.name, required this.price});
  final String id, name;
  final double price;
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'price': price};
  factory ServiceItem.fromJson(Map<String, dynamic> j) =>
      ServiceItem(id: j['id'], name: j['name'], price: (j['price'] as num?)?.toDouble() ?? 0);
}

abstract class ServiceRepository extends CrudRepository<ServiceItem> {}
