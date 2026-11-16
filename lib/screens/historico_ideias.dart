import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

class HistoricoIdeias extends StatelessWidget {
  const HistoricoIdeias({
    super.key,
    required this.ideias,
    required this.onIdeiaAtualizada,
  });

  final List<Ideia> ideias;
  final ValueChanged<Ideia> onIdeiaAtualizada;

  @override
  Widget build(BuildContext context) {
    return Historico(
      cards: ideias.map((ideia) {
        return CardIdeia(
          ideia: ideia,
          onTap: () async {
            final ideiaAtualizada = await Navigator.of(context).push<Ideia>(
              MaterialPageRoute(
                builder: (context) => RegistroIdeia(ideia: ideia),
              ),
            );

            if (ideiaAtualizada != null) {
              onIdeiaAtualizada(ideiaAtualizada);
            }
          }
        );
      }).toList(),
    );
  }
}
