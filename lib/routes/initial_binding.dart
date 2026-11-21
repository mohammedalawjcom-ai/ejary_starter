import 'package:get/get.dart';
import 'package:ejary/core/storage_service.dart';
import 'package:ejary/features/auth/data/auth_service.dart';
import 'package:ejary/features/data.dart';
import 'package:ejary/features/domain.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final s = Get.find<StorageService>();
    Get.put(AuthService(s), permanent: true);
    Get.lazyPut<PropertyRepository>(() => PropertyRepositoryImpl(s), fenix: true);
    Get.lazyPut<SectionRepository>(() => SectionRepositoryImpl(s), fenix: true);
    Get.lazyPut<UnitRepository>(() => UnitRepositoryImpl(s), fenix: true);
    Get.lazyPut<ServiceRepository>(() => ServiceRepositoryImpl(s), fenix: true);
    Get.lazyPut<TenantRepository>(() => TenantRepositoryImpl(s), fenix: true);
    Get.lazyPut<LeaseRepository>(() => LeaseRepositoryImpl(s), fenix: true);
    Get.lazyPut<PaymentRepository>(() => PaymentRepositoryImpl(s), fenix: true);
    Get.lazyPut(() => CreateLeaseUseCase(Get.find(), Get.find(), Get.find(), Get.find()), fenix: true);
  }
}
