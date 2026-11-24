import 'package:a3_usabilidade/data/campo_projeto.dart';
import 'package:a3_usabilidade/data/projeto.dart';

class ProjetoService {
  static Future<Projeto> criarProjeto({
    required String titulo,
    required String ideiaOriginalId,
    required int notificacao,
    required List<CampoProjeto>? camposProjeto,
  }) async {
    return Projeto(
      id: '1',
      titulo: titulo,
      notificacao: notificacao,
      timestamp: 'agora',
      arquivado: false,
      ideiaOriginalId: ideiaOriginalId,
      ideiaOriginalTitulo: 'Titulo ideia',
      ideiaOriginalDescricao: 'Descrição ideia',
      ideiaOriginalTimestamp: 'alguns dias atrás',
      camposProjeto: camposProjeto,
    );
  }
}
