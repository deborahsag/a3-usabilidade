import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

class ResultadoRegistroIdeia {
  const ResultadoRegistroIdeia.atualizada(this.ideia)
    : excluida = false;

  const ResultadoRegistroIdeia.excluida()
    : ideia = null,
      excluida = true;

  final Ideia? ideia;
  final bool excluida;
}

class RegistroIdeia extends StatefulWidget {
  const RegistroIdeia({
    super.key,
    required this.ideia,
  });

  final Ideia ideia;

  @override
  State<RegistroIdeia> createState() => _RegistroIdeiaState();
}

class _RegistroIdeiaState extends State<RegistroIdeia> {
  late Ideia ideia;
  bool salvando = false;

  @override
  void initState() {
    super.initState();
    ideia = widget.ideia;
  }

  Future<void> editarTitulo() async {
    final controller = TextEditingController(text: ideia.titulo);

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
      ideia = ideia.copyWith(titulo: novoTitulo);
    });
  }

  Future<void> salvarAlteracoes() async {
    setState(() {
      salvando = true;
    });

    try {
      final ideiaAtualizada = await IdeiaService.atualizarIdeia(ideia);

      if (!mounted) return;

      Navigator.pop(
        context,
        ResultadoRegistroIdeia.atualizada(ideiaAtualizada),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível atualizar a ideia: $e'),
        ),
      );

      setState(() {
        salvando = false;
      });
    }
  }

  Future<void> criarProjeto() async {
    final theme = Theme.of(context);

    final controller = TextEditingController();

    final titulo = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Criar projeto'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Título do projeto',
              hintText: 'Digite o nome do projeto',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface,
              ),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text('Criar'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (titulo == null || titulo.isEmpty || !mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: theme.colorScheme.primary),
              SizedBox(width: 10),
              Text('Projeto criado com sucesso!'),
            ],
          ),
          duration: Duration(seconds: 3),
        ),
    );
  }

  Future<void> excluirIdeia() async {
    final theme = Theme.of(context);

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir ideia?'),
          content: const Text(
            'Essa ação é definitiva. Tem certeza de que deseja excluir esta ideia?',
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

    if (confirmar != true || !mounted) return;

    try {
      await IdeiaService.excluirIdeia(ideia.id);

      if (!mounted) return;

      Navigator.pop(
        context,
        const ResultadoRegistroIdeia.excluida(),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível excluir a ideia: $e'),
        ),
      );
    }
  }

  @override
  Widget build (BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da ideia'),
        leading: BackButton(
          color: theme.colorScheme.tertiary,
          onPressed: salvando ? null : salvarAlteracoes,

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
                              ideia.titulo,
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
                      const SizedBox(height: 50),
                      Card(
                        color: theme.colorScheme.surface,
                        margin: EdgeInsets.all(0),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(ideia.descricao),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        TimestampHelper.formatar(ideia.timestamp),
                        style: theme.textTheme.bodySmall
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Icon(
                            NotificacaoHelper.icone(ideia.notificacao),
                            color: NotificacaoHelper.cor(ideia.notificacao, theme),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Notificações',
                            style: theme.textTheme.titleMedium,
                          ),
                          const Spacer(),
                          DropdownButton<int>(
                            value: ideia.notificacao,
                            isDense: true,
                            underline: const SizedBox.shrink(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: NotificacaoHelper.cor(
                                ideia.notificacao,
                                theme,
                              ),
                            ),
                            iconEnabledColor: NotificacaoHelper.cor(
                              ideia.notificacao,
                              theme,
                            ),
                            items: NotificacaoHelper.opcoes(theme),
                            onChanged: (valor) {
                              if (valor == null) return;

                              setState(() {
                                ideia = ideia.copyWith(notificacao: valor);
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
                              onPressed: criarProjeto,
                              icon: const Icon(Icons.add),
                              label: const Text('Criar projeto'),
                            ),
                            const SizedBox(height: 8),
                            TextButton.icon(
                              onPressed: excluirIdeia,
                              icon: const Icon(Icons.delete_outline),
                              label: const Text('Excluir ideia'),
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

    );
  }
}