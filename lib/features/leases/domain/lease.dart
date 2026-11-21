import 'package:ejary/core/crud.dart';

class Lease {
  Lease({required this.id, required this.unitId, required this.tenantId, required this.start,
      required this.end, required this.amount});
  final String id, unitId, tenantId, start, end;
  final double amount; // rent + section surcharge + bundled services, snapshot at signing
  bool isActive(DateTime now) =>
      !DateTime.parse(start).isAfter(now) && !DateTime.parse(end).isBefore(now);
  Map<String, dynamic> toJson() => {'id': id, 'unitId': unitId, 'tenantId': tenantId,
        'start': start, 'end': end, 'amount': amount};
  factory Lease.fromJson(Map<String, dynamic> j) => Lease(id: j['id'], unitId: j['unitId'],
      tenantId: j['tenantId'], start: j['start'], end: j['end'], amount: (j['amount'] as num).toDouble());
}

abstract class LeaseRepository extends CrudRepository<Lease> {}
