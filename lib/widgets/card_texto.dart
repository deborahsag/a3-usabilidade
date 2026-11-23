import 'package:material_ui/material_ui.dart';

class CardTexto extends StatelessWidget {
  const CardTexto({
    super.key,
    required this.texto,
  });

  final String texto;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surface,
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(texto),
      ),
    );
  }
}

class CardTextoEditavel extends StatelessWidget {
  const CardTextoEditavel({
    super.key,
    required this.texto,
    required this.onChanged
  });

  final String texto;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surface,
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TextFormField(
          initialValue: texto,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Digite seu texto...'
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}