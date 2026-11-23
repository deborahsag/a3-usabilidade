import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

class CriarProjeto extends StatefulWidget {
  const CriarProjeto({
    super.key,
    required this.ideiaOriginal,
  });

  final Ideia ideiaOriginal;

  @override
  State<CriarProjeto> createState () => _CriarProjetoState();
}

class _CriarProjetoState extends State<CriarProjeto> {
  final tituloController = TextEditingController();

  final List<CampoProjeto> camposProjeto = [];

  late int notificacao;
  bool salvando = false;

  @override
  void initState() {
    super.initState();

    notificacao = widget.ideiaOriginal.notificacao;
  }

  @override
  void dispose() {
    tituloController.dispose();
    super.dispose();
  }

  void adicionarCampoTexto() {
    setState(() {
      camposProjeto.add(CampoTexto(texto: ''));
    });
  }

  void adicionarCampoLista() {
    setState(() {
      camposProjeto.add(CampoLista(checklist: []));
    });
  }

  void atualizarCampo(int indice, CampoProjeto campo) {
    setState(() {
        camposProjeto[indice] = campo;
    });
  }

  void excluirCampo(int indice) {
    setState(() {
      camposProjeto.removeAt(indice);
    });
  }

  Future<void> salvarProjeto() async {
    final theme = Theme.of(context);

    setState(() {
      salvando = true;
    });

    try {
      final projetoCriado = await ProjetoService.criarProjeto(
        titulo: tituloController.text.trim().isEmpty
            ? 'Novo Projeto'
            : tituloController.text.trim(),
        notificacao: notificacao,
        ideiaOriginalId: widget.ideiaOriginal.id,
        camposProjeto: camposProjeto,
      );

      if (!mounted) return;

      Navigator.pop(context, projetoCriado);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: theme.colorScheme.error),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Não foi possível salvar o projeto: $e',
                ),
              ),
            ],
          ),
        ),
      );

      setState(() {
        salvando = false;
      });
    }
  }

  Future<void> cancelarCriacao() async {
    final theme = Theme.of(context);

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Descartar projeto?'),
          content: const Text(
            'Tem certeza de que deseja cancelar? '
            'Os dados preenchidos serão perdidos.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface,
              ),
              child: const Text('Continuar editando'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
              ),
              child: const Text('Descartar'),
            ),
          ],
        );
      },
    );

    if (confirmar == true && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build (BuildContext context) {
    final theme = Theme.of(context);
    
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        cancelarCriacao();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Criar projeto'),
          leading: BackButton(
            color: theme.colorScheme.tertiary,
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                       // Título
                        TextField(
                          controller: tituloController,
                          decoration: const InputDecoration(
                            hintText: 'Novo Projeto',
                            labelText: 'Título (opcional)',
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Ideia original
                        Card(
                          color: theme.colorScheme.surface,
                          margin: EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.ideiaOriginal.titulo,
                                  style: theme.textTheme.headlineSmall,
                                  softWrap: true,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.ideiaOriginal.descricao,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  )
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  TimestampHelper.formatar(widget.ideiaOriginal.timestamp),
                                  style: theme.textTheme.bodySmall
                                ),
                              ]
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        // Campos projeto
                        CardCampoProjetoEditavel(
                          campos: camposProjeto,
                          onCampoAlterado: atualizarCampo,
                          onExcluirCampo: excluirCampo,
                        ),
                        const SizedBox(height: 12),
                        
                        // Adicionar Campos
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: adicionarCampoTexto,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.add),
                                  const Icon(Icons.text_fields),
                                  const SizedBox(width: 8),
                                  const Text('Texto'),
                                ],
                              )
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: adicionarCampoLista,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.add),
                                  const Icon(Icons.checklist),
                                  const SizedBox(width: 8),
                                  const Text('Checklist'),
                                ],
                              )
                            ),
                          ],
                        ),
                                                
                        const SizedBox(height: 50),

                        // Notificações
                        Row(
                          children: [
                            Icon(
                              NotificacaoHelper.icone(notificacao),
                              color: NotificacaoHelper.cor(
                                notificacao,
                                theme,
                              ),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Notificações',
                              style: theme.textTheme.titleMedium,
                            ),
                            const Spacer(),
                            DropdownButton<int>(
                              value: notificacao,
                              isDense: true,
                              underline: const SizedBox.shrink(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: NotificacaoHelper.cor(
                                  notificacao,
                                  theme,
                                ),
                              ),
                              iconEnabledColor: NotificacaoHelper.cor(
                                notificacao,
                                theme,
                              ),
                              items: NotificacaoHelper.opcoes(theme),
                              onChanged: (valor) {
                                if (valor == null) return;

                                setState(() {
                                  notificacao = valor;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        // Ações
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton.icon(
                              onPressed: salvando ? null : salvarProjeto,
                              icon: salvando
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.save_outlined),
                              label: Text(salvando ? 'Salvando...' : 'Salvar'),
        
                            ),
                            const SizedBox(height: 8),
                            TextButton.icon(
                              onPressed: cancelarCriacao,
                              icon: const Icon(Icons.close),
                              label: const Text('Cancelar'),
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    theme.colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

      )
    );
  }
}
