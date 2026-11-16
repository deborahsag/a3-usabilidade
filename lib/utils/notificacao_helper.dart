import 'package:material_ui/material_ui.dart';

class NotificacaoHelper {
  static String texto(int valor) {
    return switch (valor) {
      0 => 'Nenhuma',
      1 => 'Sem pressa',
      2 => 'Em breve',
      3 => 'Urgente',
      _ => 'Desconhecida',
    };
  }

  static IconData icone(int valor) {
    return switch (valor) {
      0 => Icons.notifications_off,
      1 => Icons.notifications_none,
      2 => Icons.notifications,
      3 => Icons.notification_important,
      _ => Icons.help_outline,
    };
  }

  static Color cor(int valor, ThemeData theme) {
    return switch (valor) {
      0 => theme.colorScheme.onSurfaceVariant,
      1 => theme.colorScheme.primary,
      2 => theme.colorScheme.tertiary,
      3 => theme.colorScheme.error,
      _ => theme.colorScheme.onSurfaceVariant,
    };
  }

  static List<int> get valores => [0, 1, 2, 3];

  static List<DropdownMenuItem<int>> opcoes(ThemeData theme) {
    return valores.map((valor) {
      return DropdownMenuItem<int>(
        value: valor,
        child: Text(
          texto(valor),
          style: TextStyle(
            color: cor(valor, theme),
          ),
        ),
      );
    }).toList();
  }
}
