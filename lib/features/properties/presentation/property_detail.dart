import 'package:ejary/core/core.dart';
import 'package:ejary/features/domain.dart';

class PropertyDetailController extends GetxController {
  PropertyDetailController(this.secs, this.units, this.services);
  final SectionRepository secs;
  final UnitRepository units;
  final ServiceRepository services;
  final Property property = Get.arguments as Property;
  final sections = <Section>[].obs;
  final unitList = <Unit>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    sections.value = secs.all().where((s) => s.propertyId == property.id).toList();
    final ids = sections.map((s) => s.id).toSet();
    unitList.value = units.all().where((u) => ids.contains(u.sectionId)).toList();
  }

  List<Unit> unitsOf(Section s) => unitList.where((u) => u.sectionId == s.id).toList();

  Future<void> addSection() async {
    final r = await formDialog('add_section',
        const [FieldDef('name', 'name'), FieldDef('surcharge', 'surcharge', number: true)]);
    if (r == null || r['name']!.isEmpty) return;
    final tier = await pickDialog<String>('tier', ['standard', 'vip', 'shop', 'infra'], (t) => t.tr);
    final all = services.all();
    final sel = all.isEmpty
        ? <String>[]
        : await multiPick('services', {for (final s in all) s.id: '${s.name} (${s.price})'}, []);
    await secs.save(Section(
        id: newId(), propertyId: property.id, name: r['name']!, tier: tier ?? 'standard',
        surcharge: double.tryParse(r['surcharge']!) ?? 0, serviceIds: sel ?? []));
    load();
  }

  Future<void> removeSection(Section s) async {
    for (final u in unitsOf(s)) {
      await units.delete(u.id);
    }
    await secs.delete(s.id);
    load();
  }

  Future<void> addUnit(Section s) async {
    final r = await formDialog('add_unit',
        const [FieldDef('name', 'name'), FieldDef('rent', 'rent', number: true)]);
    if (r == null || r['name']!.isEmpty) return;
    await units.save(Unit(id: newId(), sectionId: s.id, name: r['name']!, rent: double.tryParse(r['rent']!) ?? 0));
    load();
  }

  Future<void> removeUnit(Unit u) async {
    await units.delete(u.id);
    load();
  }
}

class PropertyDetailBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => PropertyDetailController(Get.find(), Get.find(), Get.find()));
}

class PropertyDetailView extends GetView<PropertyDetailController> {
  const PropertyDetailView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(controller.property.name)),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: controller.addSection, icon: const Icon(Icons.add), label: Text('add_section'.tr)),
        body: Obx(() => controller.sections.isEmpty
            ? const EmptyState()
            : ListView(children: [
                for (final s in controller.sections)
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(s.name),
                      subtitle: Text('${s.tier.tr}  •  +${s.surcharge.toStringAsFixed(0)}'),
                      trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => controller.removeSection(s)),
                      children: [
                        for (final u in controller.unitsOf(s))
                          ListTile(
                            dense: true,
                            leading: const Icon(Icons.door_front_door),
                            title: Text(u.name),
                            subtitle: Text('${'rent'.tr}: ${u.rent.toStringAsFixed(0)}'),
                            trailing: IconButton(icon: const Icon(Icons.close), onPressed: () => controller.removeUnit(u)),
                          ),
                        TextButton.icon(
                            onPressed: () => controller.addUnit(s), icon: const Icon(Icons.add), label: Text('add_unit'.tr)),
                      ],
                    ),
                  ),
                const SizedBox(height: 80),
              ])),
      );
}
