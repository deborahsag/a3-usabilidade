import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

class CardIdeia extends StatelessWidget {
  const CardIdeia({
    super.key,
    required this.ideia,
    this.onTap,
  });

  final Ideia ideia;
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
                      NotificacaoHelper.icone(ideia.notificacao),
                      color: NotificacaoHelper.cor(ideia.notificacao, theme),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(NotificacaoHelper.texto(ideia.notificacao)),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ideia.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.displayMedium,
                    ),
                  )
                ),
                Divider(),
                Text(
                  ideia.timestamp,
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
