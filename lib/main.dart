import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';

import 'data/ideias_exemplo.dart';

void main() {
  runApp(const CapsulaApp());
}


class CapsulaApp extends StatelessWidget {
  const CapsulaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cápsula',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        colorScheme: const ColorScheme.dark(
          // Cores principais
          primary: Color(0xFF2978FF),
          onPrimary: Color(0xFFFFFFFF),

          secondary: Color(0xFFFF1744),
          onSecondary: Color(0xFFFFFFFF),

          tertiary: Color(0xFFFFE900),
          onTertiary: Color(0xFF171A21),

          // Superfícies
          surface: Color(0xFF171A21),
          onSurface: Color(0xFFF5F7FA),
          onSurfaceVariant: Color(0xFFB0B7C3),
          surfaceContainerHighest: Color(0xFF222630),

          // Erros
          error: Color(0xFFFF1744),
          onError: Color(0xFFFFFFFF),

          // Bordas
          outline: Color(0xFF3B4352),
          outlineVariant: Color(0xFF3B4352),
        ),

        // Fundo das páginas
        scaffoldBackgroundColor: const Color(0xFF0D0F14),

        // Divisórias
        dividerColor: const Color(0xFF3B4352),

        // Campos de texto
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF171A21),
          hintStyle: const TextStyle(
            color: Color(0xFF737D8C),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF3B4352),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF2978FF),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Janelas modais
        dialogTheme: const DialogThemeData(
          backgroundColor: Color(0xFF222630),
        ),

        // Menus
        popupMenuTheme: const PopupMenuThemeData(
          color: Color(0xFF222630),
        ),

        // Toasts / SnackBars
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFF171A21),
          contentTextStyle: TextStyle(
            color: Color(0xFFF5F7FA),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: const LayoutPrincipal(),
    );
  }
}


class LayoutPrincipal extends StatefulWidget {
  const LayoutPrincipal({super.key});

  @override
  State<LayoutPrincipal> createState() => _LayoutPrincipalState();
}

class _LayoutPrincipalState extends State<LayoutPrincipal> {
  int currentPageIndex = 0;

  late List<Ideia> ideias;

  @override
  void initState() {
    super.initState();
    ideias = List<Ideia>.of(ideiasExemplo);
  }

  void abrirCriarIdeia() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CriarIdeia(),
      ),
    );
  }

  void atualizarIdeia(Ideia ideiaAtualizada) {
    setState(() {
      ideias = ideias.map((ideia) {
        return ideia.id == ideiaAtualizada.id
        ? ideiaAtualizada
        : ideia;
      }).toList();
    });
  }

  void excluirIdeia(String id) {
    setState(() {
      ideias.removeWhere((ideia) => ideia.id == id);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(child: Text('Cápsula', style: TextStyle(color: theme.colorScheme.primary))),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.primary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Página Inicial',
          ),
          NavigationDestination(
            icon: Icon(Icons.tips_and_updates),
            label: 'Ideias',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_special),
            label: 'Projetos',
          ),
        ],
      ),
      body: <Widget>[

        /// Página Inicial
        PaginaInicial(onCriarIdeia: abrirCriarIdeia),

        /// Histórico de Ideias
        HistoricoIdeias(
          ideias: ideias,
          onIdeiaAtualizada: atualizarIdeia,
          onIdeiaExcluida: excluirIdeia,
        ),
        
        /// Histórico de Projetos
        HistoricoIdeias(
        ideias: [
          Ideia(
            id: '1',
            titulo: 'Projeto 4',
            descricao: 'Descrição do projeto',
            notificacao: 1,
            timestamp: '16/11/2026',
            arquivada: false,
          ),
          Ideia(
            id: '3',
            titulo: 'Um projeto um pouco mais longo para testar',
            descricao: 'Mais uma descrição',
            notificacao: 1,
            timestamp: '14/11/2026',
            arquivada: true,
          ),
        ],
        onIdeiaAtualizada: atualizarIdeia,
        onIdeiaExcluida: excluirIdeia,
      ),
      ][currentPageIndex],
    );
  }
}
