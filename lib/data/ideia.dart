class Ideia {
  Ideia({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.notificacao,
    required this.timestamp,
    required this.arquivada
  });

  final String id;
  final String titulo;
  final String descricao;
  final int notificacao;
  final String timestamp;
  final bool arquivada;

  Ideia copyWith({
    String? titulo,
    String? descricao,
    int? notificacao,
    String? timestamp,
    bool? arquivada,
  }) {
    return Ideia(
      id: id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      notificacao: notificacao ?? this.notificacao,
      timestamp: timestamp ?? this.timestamp,
      arquivada: arquivada ?? this.arquivada,
    );
  }
}
