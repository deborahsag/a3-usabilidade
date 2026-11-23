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

  Future<void> editarProjeto() async {
    final resultado = await Navigator.push<ResultadoRegistroProjeto>(
      context,
      MaterialPageRoute(
        builder: (context) => RegistroProjetoEditavel(
          projeto: projeto,
        ),
      ),
    );

    if (!mounted || resultado == null) return;

    if(resultado.excluido) {
      Navigator.pop(
        context,
        const ResultadoRegistroProjeto.excluido(),
      );
      return;
    }

    if (resultado.projeto != null) {
      setState(() {
        projeto = resultado.projeto!;
      });
    }
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
                      Text(
                        projeto.titulo,
                        style: theme.textTheme.headlineLarge,
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
                                  Text(
                                    projeto.ideiaOriginalTitulo,
                                    style: theme.textTheme.headlineSmall,
                                    softWrap: true,
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
                      CardCampoProjeto(
                        campos: projeto.camposProjeto,
                        onCampoAlterado: atualizarCampo,
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
                              onPressed: editarProjeto,
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
