import 'package:material_ui/material_ui.dart';
import 'package:a3_usabilidade/capsula.dart';

class CardChecklist extends StatefulWidget {
  const CardChecklist({
    super.key,
    required this.checklist,
  });

  final List<ChecklistItem> checklist;

  @override
  State<CardChecklist> createState() => _CardChecklistState();
}

class _CardChecklistState extends State<CardChecklist> {
  late List<ChecklistItem> checklist;

  @override
  void initState() {
    super.initState();

    checklist = widget.checklist.map((item) {
      return ChecklistItem(
        isChecked: item.isChecked,
        texto: item.texto,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surface,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: checklist.map((item) {
            return ListTile(
              leading: Checkbox(
                value: item.isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    item.isChecked = value!;
                  });
                },
              ),
              title: Text(item.texto),
            );
          }).toList(),
      ),
    );
  }
}

class CardChecklistEditavel extends StatefulWidget {
  const CardChecklistEditavel({
    super.key,
    required this.checklist,
  });

  final List<ChecklistItem> checklist;

  @override
  State<CardChecklistEditavel> createState() => _CardChecklistEditavelState();
}

class _CardChecklistEditavelState extends State<CardChecklistEditavel> {
  late List<ChecklistItem> checklist;

  final TextEditingController controlador = TextEditingController();

  void adicionarItem() {
    final texto = controlador.text.trim();

    if (texto.isEmpty) return;

    setState(() {
      checklist.add(
        ChecklistItem(
          isChecked: false,
          texto: texto,
        ),
      );
    });

    controlador.clear();
  }

  @override
  void initState() {
    super.initState();

    checklist = widget.checklist.map((item) {
      return ChecklistItem(
        isChecked: item.isChecked,
        texto: item.texto,
      );
    }).toList();
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surface,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ...checklist.map((item) {
            return ListTile(
              leading: Checkbox(
                value: item.isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    item.isChecked = value!;
                  });
                },
              ),
              title: Text(item.texto),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  setState(() {
                    checklist.remove(item);
                  });
                },
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controlador,
                    decoration: const InputDecoration(
                      hintText: 'Adicionar item',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => adicionarItem(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: adicionarItem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
