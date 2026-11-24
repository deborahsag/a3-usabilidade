import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

class RegistroProjetoEditavel extends StatefulWidget {
  const RegistroProjetoEditavel({
    super.key,
    required this.projeto,
  });

  final Projeto projeto;

  @override
  State<RegistroProjetoEditavel> createState() => _RegistroProjetoEditavelState();
}

class _RegistroProjetoEditavelState extends State<RegistroProjetoEditavel> {
  late Projeto projeto;

    @override
    void initState() {
      super.initState();

      projeto = widget.projeto.copyWith(
        camposProjeto: widget.projeto.camposProjeto?.map((campo) {
          return switch (campo) {
            CampoTexto(:final texto) => CampoTexto(texto: texto),

            CampoLista(:final checklist) => CampoLista(
              checklist: checklist.map((item) {
                return ChecklistItem(
                  isChecked: item.isChecked,
                  texto: item.texto,
                );
              }).toList(),
            ),
          };
        }).toList(),
      );
    }

  void adicionarCampoTexto() {
    final campos = List<CampoProjeto>.from(
      projeto.camposProjeto ?? [],
    );

    campos.add(CampoTexto(texto: ''));

    setState(() {
      projeto = projeto.copyWith(camposProjeto: campos);
    });
  }

  void adicionarCampoLista() {
    final campos = List<CampoProjeto>.from(
      projeto.camposProjeto ?? [],
    );

    campos.add(CampoLista(checklist: []));

    setState(() {
      projeto = projeto.copyWith(camposProjeto: campos);
    });
  }

  void atualizarCampo(int indice, CampoProjeto campo) {
    final campos = List<CampoProjeto>.from(
      projeto.camposProjeto ?? [],
    );

    campos[indice] = campo;

    setState(() {
      projeto = projeto.copyWith(
        camposProjeto: campos,
      );
    });
  }

  void excluirCampo(int indice) {
    final campos = List<CampoProjeto>.from(
      projeto.camposProjeto ?? [],
    );

    campos.removeAt(indice);

    setState(() {
      projeto = projeto.copyWith(camposProjeto: campos);
    });
  }

  Future<void> editarTitulo() async {
    final controller = TextEditingController(text: projeto.titulo);

    final novoTitulo = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar título'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Título',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (novoTitulo == null || novoTitulo.isEmpty) return;

    setState(() {
      projeto = projeto.copyWith(titulo: novoTitulo);
    });
  }

  Future<void> excluirProjeto() async {
    final theme = Theme.of(context);

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir projeto?'),
          content: const Text(
            'Essa ação é definitiva. Tem certeza de que deseja excluir este projeto?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface,
              ),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
              ),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmar == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: theme.colorScheme.primary),
              SizedBox(width: 10),
              Text('Projeto excluído com sucesso.'),
            ],
          ),
          duration: Duration(seconds: 3),
        ),
      );
      
      Navigator.pop(
        context,
        const ResultadoRegistroProjeto.excluido(),
      );
    }
  }

  Future<void> cancelarEdicao() async {
    final theme = Theme.of(context);

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Descartar edições?'),
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
        cancelarEdicao();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar projeto'),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                projeto.titulo,
                                style: theme.textTheme.headlineLarge,
                              ),
                            ),
                            IconButton(
                              onPressed: editarTitulo,
                              icon: const Icon(Icons.edit),
                              tooltip: 'Editar título',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Data de criação: '),
                            Text(TimestampHelper.formatar(projeto.timestamp)),
                          ]
                        ),
                        const SizedBox(height: 30),
                        Card(
                          color: theme.colorScheme.surface,
                          margin: EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    /*Text(
                                      'Ideia original: ',
                                      style: theme.textTheme.bodyLarge,
                                    ),*/
                                    Expanded(
                                      child: Text(
                                        projeto.ideiaOriginalTitulo,
                                        style: theme.textTheme.headlineSmall,
                                        softWrap: true,
                                      )
                                    ),
                                  ]
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  projeto.ideiaOriginalDescricao,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  )
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  TimestampHelper.formatar(projeto.timestamp),
                                  style: theme.textTheme.bodySmall
                                ),
                              ]
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CardCampoProjetoEditavel(
                          campos: projeto.camposProjeto,
                          onCampoAlterado: atualizarCampo,
                          onExcluirCampo: excluirCampo,
                        ),
                        const SizedBox(height: 12),
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
                        Row(
                          children: [
                            Icon(
                              NotificacaoHelper.icone(projeto.notificacao),
                              color: NotificacaoHelper.cor(projeto.notificacao, theme),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Notificações',
                              style: theme.textTheme.titleMedium,
                            ),
                            const Spacer(),
                            DropdownButton<int>(
                              value: projeto.notificacao,
                              isDense: true,
                              underline: const SizedBox.shrink(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: NotificacaoHelper.cor(
                                  projeto.notificacao,
                                  theme,
                                ),
                              ),
                              iconEnabledColor: NotificacaoHelper.cor(
                                projeto.notificacao,
                                theme,
                              ),
                              items: NotificacaoHelper.opcoes(theme),
                              onChanged: (valor) {
                                if (valor == null) return;

                                setState(() {
                                  projeto = projeto.copyWith(notificacao: valor);
                                });
                              }
                            ),
                          ]
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: Column(
                            children: [
                              FilledButton.icon(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    ResultadoRegistroProjeto.atualizado(projeto),
                                  );
                                },
                                icon: const Icon(Icons.save),
                                label: const Text('Salvar'),
                              ),
                              const SizedBox(height: 8),
                              TextButton.icon(
                                onPressed: excluirProjeto,
                                icon: const Icon(Icons.delete_outline),
                                label: const Text('Excluir'),
                                style: TextButton.styleFrom(
                                  foregroundColor: theme.colorScheme.error,
                                ),
                              ),
                            ],
                          ),
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
