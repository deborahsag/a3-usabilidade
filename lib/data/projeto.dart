class Projeto {
  Projeto({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.notificacao,
    required this.timestamp,
    required this.arquivado,
  });

  final String id;
  final String titulo;
  final String descricao;
  final int notificacao;
  final String timestamp;
  final bool arquivado;

  Projeto copyWith({
    String? titulo,
    String? descricao,
    int? notificacao,
    String? timestamp,
    bool? arquivado,
  }) {
    return Projeto(
      id: id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      notificacao: notificacao ?? this.notificacao,
      timestamp: timestamp ?? this.timestamp,
      arquivado: arquivado ?? this.arquivado,
    );
  }
}
