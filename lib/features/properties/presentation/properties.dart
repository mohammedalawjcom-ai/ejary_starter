import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';
import 'package:ejary/routes/app_pages.dart';

/// StateMixin demo: list state (loading/empty/success) handled by `obx`.
class PropertiesController extends GetxController with StateMixin<List<Property>> {
  PropertiesController(this.props, this.secs, this.units);
  final PropertyRepository props;
  final SectionRepository secs;
  final UnitRepository units;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    final l = props.all();
    change(l, status: l.isEmpty ? RxStatus.empty() : RxStatus.success());
  }

  Future<void> add() async {
    final r = await formDialog('add_property', const [FieldDef('name', 'name'), FieldDef('address', 'address')]);
    if (r == null || r['name']!.isEmpty) return;
    await props.save(Property(id: newId(), name: r['name']!, address: r['address']!));
    load();
  }

  Future<void> remove(Property p) async {
    for (final s in secs.all().where((s) => s.propertyId == p.id)) {
      for (final u in units.all().where((u) => u.sectionId == s.id)) {
        await units.delete(u.id);
      }
      await secs.delete(s.id);
    }
    await props.delete(p.id);
    load();
  }
}

class PropertiesBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => PropertiesController(Get.find(), Get.find(), Get.find()));
}

class PropertiesView extends GetView<PropertiesController> {
  const PropertiesView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('properties'.tr)),
        floatingActionButton: FloatingActionButton(onPressed: controller.add, child: const Icon(Icons.add)),
        body: controller.obx(
          (list) => ListView(children: [
            for (final p in list!)
              ListTile(
                leading: const Icon(Icons.apartment),
                title: Text(p.name),
                subtitle: Text(p.address),
                onTap: () => Get.toNamed(Routes.propertyDetail, arguments: p),
                trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => controller.remove(p)),
              ),
          ]),
          onEmpty: const EmptyState(),
        ),
      );
}
