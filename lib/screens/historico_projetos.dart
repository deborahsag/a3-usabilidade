import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

class HistoricoProjetos extends StatelessWidget {
  const HistoricoProjetos({
    super.key,
    required this.projetos,
    required this.onProjetoAtualizado,
    required this.onProjetoExcluido,
  });

  final List<Projeto> projetos;
  final ValueChanged<Projeto> onProjetoAtualizado;
  final ValueChanged<String> onProjetoExcluido;

  @override
  Widget build(BuildContext context) {
    return Historico(
      cards: projetos.map((projeto) {
        return CardProjeto(
          projeto: projeto,
          onTap: () async {
            final resultado = await Navigator.of(context)
                .push<ResultadoRegistroProjeto>(
              MaterialPageRoute(
                builder: (context) => RegistroProjeto(projeto: projeto),
              ),
            );

            if (resultado == null) return;

            if (resultado.excluido) {
              onProjetoExcluido(projeto.id);
            } else if (resultado.projeto != null) {
              onProjetoAtualizado(resultado.projeto!);
            }
          },
        );
      }).toList(),
    );
  }
}
