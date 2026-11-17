import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

class CardProjeto extends StatelessWidget {
  const CardProjeto({
    super.key,
    required this.projeto,
    this.onTap,
  });

  final Projeto projeto;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      color: theme.colorScheme.surface,
      child: InkWell(
        splashColor: theme.colorScheme.tertiary,
        onTap: onTap,
        child: SizedBox(
          height: 214,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      NotificacaoHelper.icone(projeto.notificacao),
                      color: NotificacaoHelper.cor(projeto.notificacao, theme),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(NotificacaoHelper.texto(projeto.notificacao)),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      projeto.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.displaySmall,
                    ),
                  )
                ),
                const Divider(),
                Text(
                  TimestampHelper.formatar(projeto.timestamp),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
