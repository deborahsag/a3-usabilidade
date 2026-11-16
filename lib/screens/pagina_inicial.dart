import 'package:material_ui/material_ui.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
          shadowColor: theme.colorScheme.outline,
          margin: const .all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text('Home page', style: theme.textTheme.titleLarge),
            ),
          ),
        );
  }
}