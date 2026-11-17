class Ideia {
  Ideia({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.notificacao,
    required this.timestamp,
    required this.arquivada,
    required this.projetoId,
  });

  final String id;
  final String titulo;
  final String descricao;
  final int notificacao;
  final String timestamp;
  final bool arquivada;
  final String? projetoId;

  factory Ideia.fromJson(Map<String, dynamic> json) {
    return Ideia(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      notificacao: json['notificacao'] as int,
      timestamp: json['timestamp'] as String,
      arquivada: json['arquivada'] as bool,
      projetoId: json['projetoId'] as String?,
    );
  }

  Ideia copyWith({
    String? titulo,
    String? descricao,
    int? notificacao,
    String? timestamp,
    bool? arquivada,
    String? projetoId,
  }) {
    return Ideia(
      id: id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      notificacao: notificacao ?? this.notificacao,
      timestamp: timestamp ?? this.timestamp,
      arquivada: arquivada ?? this.arquivada,
      projetoId: projetoId ?? this.projetoId,
    );
  }
}
