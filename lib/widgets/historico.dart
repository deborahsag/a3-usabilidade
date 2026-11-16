import 'package:material_ui/material_ui.dart';

class Historico extends StatelessWidget {
  const Historico({
    super.key,
    required this.cards
  });

  final List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return const Center(
        child: Text('Nenhum registro encontrado.'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: cards.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 16),
      itemBuilder: (context, index) => cards[index],
    );
  }
}
