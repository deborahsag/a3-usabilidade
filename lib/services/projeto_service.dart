import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/campo_projeto.dart';
import '../data/projeto.dart';

class ProjetoService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  // GET listar todos os projetos
  static Future<List<Projeto>> listarProjetos() async {
    final resposta = await http.get(
      Uri.parse('$baseUrl/projetos'),
    );

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao carregar ideias: ${resposta.statusCode}');
    }

    final List<dynamic> dados = jsonDecode(resposta.body);

    return dados.map((item) {
      return Projeto.fromJson(item);
    }).toList();
  }

  //GET buscar projeto por id
    static Future<Projeto> buscarProjetoPorId(String id) async {
    final resposta = await http.get(
      Uri.parse('$baseUrl/projetos/$id'),
    );

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao buscar projeto: ${resposta.body}');
    }

    return Projeto.fromJson(
      jsonDecode(resposta.body) as Map<String, dynamic>,
    );
  }

  // POST criar um novo projeto
  static Future<Projeto> criarProjeto({
    required String titulo,
    required String ideiaOriginalId,
    required int notificacao,
    required List<CampoProjeto>? camposProjeto,
  }) async {
    final resposta = await http.post(
      Uri.parse('$baseUrl/projetos'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'titulo': titulo,
        'ideiaOriginalId': ideiaOriginalId,
        'notificacao': notificacao,
        'camposProjeto': camposProjeto
          ?.map((campo) => campo.toJson())
          .toList(),
      }),
    );

    if (resposta.statusCode != 201) {
      throw Exception('Erro ao criar projeto: ${resposta.body}');
    }

    return Projeto.fromJson(
      jsonDecode(resposta.body) as Map<String, dynamic>,
    );
  }

  //PUT atualizar um projeto
  static Future<Projeto> atualizarProjeto(Projeto projeto) async {
    final resposta = await http.put(
      Uri.parse('$baseUrl/projetos/${projeto.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'titulo': projeto.titulo,
        'notificacao': projeto.notificacao,
        'camposProjeto': projeto.camposProjeto
          ?.map((campo) => campo.toJson())
          .toList(),
      }),
    );

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao atualizar o projeto: ${resposta.body}');
    }

    return Projeto.fromJson(
      jsonDecode(resposta.body) as Map<String, dynamic>,
    );
  }

  //DELETE excluir um projeto
  static Future<void> excluirProjeto(String id) async {
    final resposta = await http.delete(
      Uri.parse('$baseUrl/projetos/$id'),
    );

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao excluir projeto: ${resposta.body}');
    }
  }
}
