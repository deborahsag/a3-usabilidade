import 'package:material_ui/material_ui.dart';
import 'package:a3_usabilidade/capsula.dart';

class CardChecklist extends StatelessWidget {
  const CardChecklist({
    super.key,
    required this.checklist,
    required this.onChanged,
  });

  final List<ChecklistItem> checklist;
  final ValueChanged<List<ChecklistItem>> onChanged;

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
                final novoChecklist = checklist.map((itemAtual) {
                  return ChecklistItem(
                    isChecked: identical(itemAtual, item)
                        ? (value ?? false)
                        : itemAtual.isChecked,
                    texto: itemAtual.texto,
                  );
                }).toList();

                onChanged(novoChecklist);
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
    required this.onChanged,
    required this.onExcluir,
  });

  final List<ChecklistItem> checklist;
  final ValueChanged<List<ChecklistItem>> onChanged;
  final VoidCallback onExcluir;

  @override
  State<CardChecklistEditavel> createState() => _CardChecklistEditavelState();
}

class _CardChecklistEditavelState extends State<CardChecklistEditavel> {
  late List<ChecklistItem> checklist;

  final TextEditingController controlador = TextEditingController();

  void notificarAlteracao() {
    widget.onChanged(
      checklist.map((item) {
        return ChecklistItem(
          isChecked: item.isChecked,
          texto: item.texto,
          );
      }).toList(),
    );
  }

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

    notificarAlteracao();
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
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.all(20),
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
                      item.isChecked = value ?? false;
                    });

                    notificarAlteracao();
                  },
                ),
                title: Text(item.texto),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Excluir item',
                  onPressed: () {
                    setState(() {
                      checklist.remove(item);
                    });

                    notificarAlteracao();
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
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: widget.onExcluir,
                tooltip: 'Excluir bloco inteiro',
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
