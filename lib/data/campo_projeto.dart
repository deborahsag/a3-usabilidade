enum TipoCampoProjeto {
  texto,
  lista,
}

sealed class CampoProjeto {
  CampoProjeto({
    required this.tipo,
  });
  
  final TipoCampoProjeto tipo;

  factory CampoProjeto.fromJson(Map<String, dynamic> json) {
    return switch (json['tipo']) {
      'texto' => CampoTexto(
        texto: json['texto'],
      ),
      'lista' => CampoLista(
        checklist: (json['checklist'] as List<dynamic>)
          .map((item) => ChecklistItem.fromJson(item))
          .toList(),
      ),
      _ => throw FormatException('Tipo de campo desconhecido.'),
    };
  }
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

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      isChecked: json['isChecked'] as bool, 
      texto: json['texto'] as String,
    );
  }
}

class CampoLista extends CampoProjeto {
  CampoLista({
    required this.checklist,
  }) : super(tipo: TipoCampoProjeto.lista);

  final List<ChecklistItem> checklist;
}
