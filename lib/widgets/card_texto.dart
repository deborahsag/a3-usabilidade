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
    required this.onChanged,
    required this.onExcluir,
  });

  final String texto;
  final ValueChanged<String> onChanged;
  final VoidCallback onExcluir;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surface,
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              initialValue: texto,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Digite seu texto...'
              ),
              onChanged: onChanged,
            ),
            Align(
              alignment: Alignment.centerRight, 
              child: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onExcluir,
                tooltip: 'Excluir bloco',
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}