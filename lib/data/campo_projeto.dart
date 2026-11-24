enum TipoCampoProjeto {
  texto,
  lista,
}

sealed class CampoProjeto {
  CampoProjeto({
    required this.tipo,
  });
  
  final TipoCampoProjeto tipo;
}

class CampoTexto extends CampoProjeto {
  CampoTexto({
    required this.texto,
  }) : super(tipo: TipoCampoProjeto.texto);

  final String texto;
}

class ChecklistItem {
  ChecklistItem({
    required this.isChecked,
    required this.texto,
  });

  bool isChecked;
  final String texto;
}

class CampoLista extends CampoProjeto {
  CampoLista({
    required this.checklist,
  }) : super(tipo: TipoCampoProjeto.lista);

  final List<ChecklistItem> checklist;
}
