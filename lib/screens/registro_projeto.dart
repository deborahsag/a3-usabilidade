import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

class ResultadoRegistroProjeto {
  const ResultadoRegistroProjeto.atualizado(this.projeto)
    : excluido = false;

  const ResultadoRegistroProjeto.excluido()
    : projeto = null,
      excluido = true;

  final Projeto? projeto;
  final bool excluido;
}

class RegistroProjeto extends StatefulWidget {
  const RegistroProjeto({
    super.key,
    required this.projeto,
  });

  final Projeto projeto;

  @override
  State<RegistroProjeto> createState() => _RegistroProjetoState();
}

class _RegistroProjetoState extends State<RegistroProjeto> {
  late Projeto projeto;

  @override
  void initState() {
    super.initState();
    projeto = widget.projeto;
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

  @override
  Widget build (BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do projeto'),
        leading: BackButton(
          color: theme.colorScheme.tertiary,
          onPressed: () {
            Navigator.pop(
              context,
              ResultadoRegistroProjeto.atualizado(projeto),
            );
          },
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
                          /*IconButton(
                            onPressed: editarTitulo,
                            icon: const Icon(Icons.edit),
                            tooltip: 'Editar título',
                          ),*/
                        ],
                      ),
                      const SizedBox(height: 50),
                      Card(
                        color: theme.colorScheme.surface,
                        margin: EdgeInsets.all(0),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(projeto.descricao),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        TimestampHelper.formatar(projeto.timestamp),
                        style: theme.textTheme.bodySmall
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
                              onPressed: (){},
                              icon: const Icon(Icons.edit),
                              label: const Text('Editar'),
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

    );
  }
}
