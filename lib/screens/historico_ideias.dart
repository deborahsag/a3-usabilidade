import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

class HistoricoIdeias extends StatelessWidget {
  const HistoricoIdeias({
    super.key,
    required this.ideias,
    required this.onIdeiaAtualizada,
    required this.onIdeiaExcluida,
    required this.onProjetoCriado,
  });

  final List<Ideia> ideias;
  final ValueChanged<Ideia> onIdeiaAtualizada;
  final ValueChanged<String> onIdeiaExcluida;
  final ValueChanged<Projeto> onProjetoCriado;

  @override
  Widget build(BuildContext context) {
    return Historico(
      cards: ideias.map((ideia) {
        return CardIdeia(
          ideia: ideia,
          onTap: () async {
            final resultado = await Navigator.of(context)
                .push<ResultadoRegistroIdeia>(
              MaterialPageRoute(
                builder: (context) => RegistroIdeia(ideia: ideia),
              ),
            );

            if (resultado == null) return;

            if (resultado.excluida) {
              onIdeiaExcluida(ideia.id);
            } else if (resultado.ideia != null) {
              onIdeiaAtualizada(resultado.ideia!);
            }

            if (resultado.projetoCriado != null) {
              onProjetoCriado(resultado.projetoCriado!);
            }
          },
        );
      }).toList(),
    );
  }
}
