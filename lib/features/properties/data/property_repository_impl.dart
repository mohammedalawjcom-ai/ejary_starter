import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';

class PropertyRepositoryImpl extends LocalCrud<Property> implements PropertyRepository {
  PropertyRepositoryImpl(StorageService s)
      : super(s, 'properties', Property.fromJson, (e) => e.toJson(), (e) => e.id);
}

class SectionRepositoryImpl extends LocalCrud<Section> implements SectionRepository {
  SectionRepositoryImpl(StorageService s)
      : super(s, 'sections', Section.fromJson, (e) => e.toJson(), (e) => e.id);
}

class UnitRepositoryImpl extends LocalCrud<Unit> implements UnitRepository {
  UnitRepositoryImpl(StorageService s)
      : super(s, 'units', Unit.fromJson, (e) => e.toJson(), (e) => e.id);
}
