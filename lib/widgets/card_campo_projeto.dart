
import 'package:material_ui/material_ui.dart';
import 'package:a3_usabilidade/capsula.dart';

class CardCampoProjeto extends StatelessWidget {
  const CardCampoProjeto({
    super.key,
    this.campos,
    required this.onCampoAlterado,
  });

  final List<CampoProjeto>? campos;
  final void Function(int indice, CampoProjeto campo) onCampoAlterado;

  Widget construirCampo(CampoProjeto campo, int indice) {
    return switch (campo) {
      CampoTexto(:final texto) => CardTexto(texto: texto),
      CampoLista(:final checklist) => CardChecklist(
        checklist: checklist,
        onChanged: (novoChecklist) {
          onCampoAlterado(
            indice,
            CampoLista(checklist: novoChecklist),
          );
        },
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final campos = this.campos;

    if (campos == null || campos.isEmpty) {
      return const Text('Você ainda não tem blocos de projeto.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: campos.asMap().entries.map((entrada) {
        return construirCampo(entrada.value, entrada.key);
      }).toList(),
    );
  }
}

class CardCampoProjetoEditavel extends StatelessWidget {
  const CardCampoProjetoEditavel({
    super.key,
    this.campos,
    required this.onCampoAlterado,
    required this.onExcluirCampo,
  });

  final List<CampoProjeto>? campos;
  final void Function(int indice, CampoProjeto campo) onCampoAlterado;
  final ValueChanged<int> onExcluirCampo;

  Widget construirCampo(CampoProjeto campo, int indice) {
    return switch (campo) {
      CampoTexto(:final texto) => CardTextoEditavel(
          texto: texto,
          onChanged: (novoTexto) {
            onCampoAlterado(indice, CampoTexto(texto: novoTexto));
          },
          onExcluir: () => onExcluirCampo(indice),
        ),
      CampoLista(:final checklist) => CardChecklistEditavel(
          checklist: checklist,
          onChanged: (novoChecklist) {
            onCampoAlterado(
              indice,
              CampoLista(checklist: novoChecklist),
            );
          },
          onExcluir: () => onExcluirCampo(indice),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final campos = this.campos;

    if (campos == null || campos.isEmpty) {
      return const Text('Você ainda não tem blocos de projeto.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: campos.asMap().entries.map((entrada) {
        return construirCampo(entrada.value, entrada.key);
      }).toList(),
    );
  }
}
