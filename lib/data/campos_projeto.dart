sealed class CampoProjeto {}

class CampoTexto extends CampoProjeto {
  CampoTexto({
    required this.texto,
  });

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
  });

  final List<ChecklistItem> checklist;
}
