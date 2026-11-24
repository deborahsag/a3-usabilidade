import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../data/ideia.dart';

class IdeiaService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  // GET listar todas as ideias
  static Future<List<Ideia>> listarIdeias() async {
    final resposta = await http.get(
      Uri.parse('$baseUrl/ideias'),
    );

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao carregar ideias: ${resposta.statusCode}');
    }

    final List<dynamic> dados = jsonDecode(resposta.body);

    return dados.map((item) {
      return Ideia.fromJson(item);
    }).toList();
  }

  // POST criar uma nova ideia
  static Future<Ideia> criarIdeia({
    required String titulo,
    required String descricao,
    required int notificacao,
  }) async {
    
    debugPrint('Enviando: ${jsonEncode({
      'titulo': titulo,
      'descricao': descricao,
      'notificacao': notificacao,
    })}');
    
    final resposta = await http.post(
      Uri.parse('$baseUrl/ideias'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'titulo': titulo,
        'descricao': descricao,
        'notificacao': notificacao,
      }),
    );

    debugPrint('Status: ${resposta.statusCode}');
    debugPrint('Resposta: ${resposta.body}');

    if (resposta.statusCode != 201) {
      throw Exception('Erro ao criar ideia: ${resposta.body}');
    }

    return Ideia.fromJson(
      jsonDecode(resposta.body) as Map<String, dynamic>,
    );
  }

  //PUT atualizar uma ideia
  static Future<Ideia> atualizarIdeia(Ideia ideia) async {
    final resposta = await http.put(
      Uri.parse('$baseUrl/ideias/${ideia.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'titulo': ideia.titulo,
        'notificacao': ideia.notificacao,
      }),
    );

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao atualizar ideia: ${resposta.body}');
    }

    return Ideia.fromJson(
      jsonDecode(resposta.body) as Map<String, dynamic>,
    );
  }

  //DELETE excluir uma ideia
  static Future<void> excluirIdeia(String id) async {
    final resposta = await http.delete(
      Uri.parse('$baseUrl/ideias/$id'),
    );

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao excluir ideia: ${resposta.body}');
    }
  }

}
