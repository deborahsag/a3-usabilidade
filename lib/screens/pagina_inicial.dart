import 'package:material_ui/material_ui.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({
    super.key,
    required this.onCriarIdeia,
  });

  final VoidCallback onCriarIdeia;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 240,
            height: 240,
            child: FilledButton(
              onPressed: onCriarIdeia,
              style: FilledButton.styleFrom(
                shape: const CircleBorder(),
              ),
              child: const Icon(
                Icons.add,
                size: 128,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Capturar ideia',
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
