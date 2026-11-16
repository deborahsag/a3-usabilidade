import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

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

  @override
  Widget build (BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da ideia'),
        leading: BackButton(
          color: theme.colorScheme.tertiary,
          onPressed: () {
            Navigator.pop(context, ideia);
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
                      const SizedBox(height: 24),
                      Card(
                        color: theme.colorScheme.surface,
                        margin: EdgeInsets.all(0),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(ideia.descricao),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Data de criação',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(ideia.timestamp),
                      const SizedBox(height: 24),
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