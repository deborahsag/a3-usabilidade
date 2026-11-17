class Projeto {
  Projeto({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.notificacao,
    required this.timestamp,
    required this.arquivado,
    required this.ideiaOriginalId,
    required this.ideiaOriginalTitulo,
    required this.ideiaOriginalDescricao,
    required this.ideiaOriginalTimestamp,
  });

  final String id;
  final String titulo;
  final String descricao;
  final int notificacao;
  final String timestamp;
  final bool arquivado;

  // Dados da ideia original
  final String ideiaOriginalId;
  final String ideiaOriginalTitulo;
  final String ideiaOriginalDescricao;
  final String ideiaOriginalTimestamp;

  Projeto copyWith({
    String? titulo,
    String? descricao,
    int? notificacao,
    String? timestamp,
    bool? arquivado,
    String? ideiaOriginalId,
    String? ideiaOriginalTitulo,
    String? ideiaOriginalDescricao,
    String? ideiaOriginalTimestamp,
  }) {
    return Projeto(
      id: id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      notificacao: notificacao ?? this.notificacao,
      timestamp: timestamp ?? this.timestamp,
      arquivado: arquivado ?? this.arquivado,
      ideiaOriginalId: ideiaOriginalId ?? this.ideiaOriginalId,
      ideiaOriginalTitulo: ideiaOriginalTitulo ?? this.ideiaOriginalTitulo,
      ideiaOriginalDescricao: ideiaOriginalDescricao ?? this.ideiaOriginalDescricao,
      ideiaOriginalTimestamp: ideiaOriginalTimestamp ?? this.ideiaOriginalTimestamp,
    );
  }
}
