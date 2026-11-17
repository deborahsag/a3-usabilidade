
class TimestampHelper {
  static const List<String> _meses = [
    'janeiro',
    'fevereiro',
    'março',
    'abril',
    'maio',
    'junho',
    'julho',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'dezembro',
  ];

  static String formatar(String timestamp) {
    final data = DateTime.parse(timestamp).toLocal();

    final dia = data.day;
    final mes = _meses[data.month - 1];
    final ano = data.year;

    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');

    return '$dia de $mes de $ano às $hora:$minuto';
  }
}
