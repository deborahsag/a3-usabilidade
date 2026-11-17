
import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

class CriarIdeia extends StatefulWidget {
  const CriarIdeia({super.key});

  @override
  State<CriarIdeia> createState() => _CriarIdeiaState();
}

class _CriarIdeiaState extends State<CriarIdeia> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();

  int notificacao = 0;
  bool salvando = false;

  @override
  void dispose() {
    tituloController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  Future<void> salvarIdeia() async {
    if (descricaoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A descrição é obrigatória.'),
        ),
      );
      return;
    }

    setState(() {
      salvando = true;
    });

    try {
      final ideiaCriada = await IdeiaService.criarIdeia(
        titulo: tituloController.text.trim().isEmpty
            ? 'Nova Ideia'
            : tituloController.text.trim(),
        descricao: descricaoController.text.trim(),
        notificacao: notificacao,
      );

      if (!mounted) return;

      Navigator.pop(context, ideiaCriada);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível salvar a ideia: $e'),
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
          title: const Text('Descartar ideia?'),
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        cancelarCriacao();
      },
      child: Scaffold(
        appBar: AppBar(
        leading: BackButton(
          color: theme.colorScheme.tertiary,
        ),
        title: const Text('Nova ideia'),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Título
                        TextField(
                          controller: tituloController,
                          decoration: const InputDecoration(
                            hintText: 'Nova Ideia',
                            labelText: 'Título (opcional)',
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Descrição
                        TextField(
                          controller: descricaoController,
                          maxLines: 8,
                          maxLength: 1000,
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            alignLabelWithHint: true,
                          ),
                        ),

                        const SizedBox(height: 24),

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

                        const SizedBox(height: 40),

                        // Ações
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton.icon(
                              onPressed: salvando ? null : salvarIdeia,
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
      ),
    );
  }
}
