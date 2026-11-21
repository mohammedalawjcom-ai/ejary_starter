import 'package:ejary/core/crud.dart';

class Payment {
  Payment({required this.id, required this.leaseId, required this.month, required this.amount, this.paidDate});
  final String id, leaseId, month; // month = yyyy-MM
  final double amount;
  String? paidDate;
  bool get paid => paidDate != null;
  Map<String, dynamic> toJson() => {'id': id, 'leaseId': leaseId, 'month': month, 'amount': amount, 'paidDate': paidDate};
  factory Payment.fromJson(Map<String, dynamic> j) => Payment(id: j['id'], leaseId: j['leaseId'],
      month: j['month'], amount: (j['amount'] as num).toDouble(), paidDate: j['paidDate']);
}

abstract class PaymentRepository extends CrudRepository<Payment> {}
