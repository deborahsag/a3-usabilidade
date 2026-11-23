import 'campos_projeto.dart';

class Projeto {
  Projeto({
    required this.id,
    required this.titulo,
    required this.notificacao,
    required this.timestamp,
    required this.arquivado,
    required this.ideiaOriginalId,
    required this.ideiaOriginalTitulo,
    required this.ideiaOriginalDescricao,
    required this.ideiaOriginalTimestamp,
    this.camposProjeto,
  });

  final String id;
  final String titulo;
  final int notificacao;
  final String timestamp;
  final bool arquivado;

  // Dados da ideia original
  final String ideiaOriginalId;
  final String ideiaOriginalTitulo;
  final String ideiaOriginalDescricao;
  final String ideiaOriginalTimestamp;

  // Campos projeto
  final List<CampoProjeto>? camposProjeto;

  Projeto copyWith({
    String? titulo,
    int? notificacao,
    String? timestamp,
    bool? arquivado,
    String? ideiaOriginalId,
    String? ideiaOriginalTitulo,
    String? ideiaOriginalDescricao,
    String? ideiaOriginalTimestamp,
    List<CampoProjeto>? camposProjeto,
  }) {
    return Projeto(
      id: id,
      titulo: titulo ?? this.titulo,
      notificacao: notificacao ?? this.notificacao,
      timestamp: timestamp ?? this.timestamp,
      arquivado: arquivado ?? this.arquivado,
      ideiaOriginalId: ideiaOriginalId ?? this.ideiaOriginalId,
      ideiaOriginalTitulo: ideiaOriginalTitulo ?? this.ideiaOriginalTitulo,
      ideiaOriginalDescricao: ideiaOriginalDescricao ?? this.ideiaOriginalDescricao,
      ideiaOriginalTimestamp: ideiaOriginalTimestamp ?? this.ideiaOriginalTimestamp,
      camposProjeto: camposProjeto ?? this.camposProjeto,
    );
  }
}
