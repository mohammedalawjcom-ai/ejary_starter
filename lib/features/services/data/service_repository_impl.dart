import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';

class ServiceRepositoryImpl extends LocalCrud<ServiceItem> implements ServiceRepository {
  ServiceRepositoryImpl(StorageService s)
      : super(s, 'services', ServiceItem.fromJson, (e) => e.toJson(), (e) => e.id);
}
