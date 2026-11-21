import 'package:ejary/core/crud.dart';

class Property {
  Property({required this.id, required this.name, required this.address});
  final String id, name, address;
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'address': address};
  factory Property.fromJson(Map<String, dynamic> j) =>
      Property(id: j['id'], name: j['name'], address: j['address'] ?? '');
}

/// A section groups units. tier: standard | vip | shop | infra.
/// surcharge = extra monthly fee for the section's nature (e.g. VIP);
/// serviceIds = services bundled with every unit of this section.
class Section {
  Section({required this.id, required this.propertyId, required this.name, required this.tier,
      required this.surcharge, required this.serviceIds});
  final String id, propertyId, name, tier;
  final double surcharge;
  final List<String> serviceIds;
  Map<String, dynamic> toJson() => {'id': id, 'propertyId': propertyId, 'name': name, 'tier': tier,
        'surcharge': surcharge, 'serviceIds': serviceIds};
  factory Section.fromJson(Map<String, dynamic> j) => Section(
      id: j['id'], propertyId: j['propertyId'], name: j['name'], tier: j['tier'],
      surcharge: (j['surcharge'] as num?)?.toDouble() ?? 0, serviceIds: List<String>.from(j['serviceIds'] ?? []));
}

class Unit {
  Unit({required this.id, required this.sectionId, required this.name, required this.rent});
  final String id, sectionId, name;
  final double rent;
  Map<String, dynamic> toJson() => {'id': id, 'sectionId': sectionId, 'name': name, 'rent': rent};
  factory Unit.fromJson(Map<String, dynamic> j) => Unit(
      id: j['id'], sectionId: j['sectionId'], name: j['name'], rent: (j['rent'] as num?)?.toDouble() ?? 0);
}

abstract class PropertyRepository extends CrudRepository<Property> {}
abstract class SectionRepository extends CrudRepository<Section> {}
abstract class UnitRepository extends CrudRepository<Unit> {}
