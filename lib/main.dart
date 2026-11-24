import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

import 'package:a3_usabilidade/capsula.dart';


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

  List<Ideia> ideias = [];
  List<Projeto> projetos = [];

  bool carregandoIdeias = true;
  String? erroIdeias;

  bool carregandoProjetos = true;
  String? erroProjetos;

  @override
  void initState() {
    super.initState();

    _carregarIdeias();
    _carregarProjetos();
  }

  Future<void> _carregarIdeias() async {
    setState(() {
      carregandoIdeias = true;
      erroIdeias = null;
    });

    try {
      final ideiasCarregadas = await IdeiaService.listarIdeias();

      if (!mounted) return;

      setState(() {
        ideias = ideiasCarregadas;
        carregandoIdeias = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erroIdeias = e.toString();
        carregandoIdeias = false;
      });
    }
  }

  Widget _construirHistoricoIdeias() {
    if (carregandoIdeias) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (erroIdeias != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Não foi possível carregar as ideias.'),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _carregarIdeias,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    return HistoricoIdeias(
      ideias: ideias,
      onIdeiaAtualizada: atualizarIdeia,
      onIdeiaExcluida: excluirIdeia,
    );
  }

  Future<void> _carregarProjetos() async {
    setState(() {
      carregandoProjetos = true;
      erroProjetos = null;
    });

    try {
      final projetosCarregados = await ProjetoService.listarProjetos();

      if (!mounted) return;

      setState(() {
        projetos = projetosCarregados;
        carregandoProjetos = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erroProjetos = e.toString();
        carregandoProjetos = false;
      });
    }
  }

  Widget _construirHistoricoProjetos() {
    if (carregandoProjetos) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (erroProjetos != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Não foi possível carregar os projetos.'),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _carregarProjetos,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    return HistoricoProjetos(
      projetos: projetos,
      onProjetoAtualizado: atualizarProjeto,
      onProjetoExcluido: excluirProjeto,
    );
  }

  List<T> _atualizarRegistro<T>(
    List<T> registros,
    T registroAtualizado,
    String Function(T) obterId,
  ) {
    return registros.map((registro) {
      return obterId(registro) == obterId(registroAtualizado)
          ? registroAtualizado
          : registro;
    }).toList();
  }

  List<T> _excluirRegistro<T>(
    List<T> registros,
    String id,
    String Function(T) obterId,
  ) {
    return registros.where((registro) => obterId(registro) != id).toList();
  }

  void atualizarIdeia(Ideia ideiaAtualizada) {
    setState(() {
      ideias = _atualizarRegistro(
        ideias,
        ideiaAtualizada,
        (ideia) => ideia.id,
      );
    });
  }

  void excluirIdeia(String id) {
    setState(() {
      ideias = _excluirRegistro(
        ideias,
        id,
        (ideia) => ideia.id,
      );
    });
  }

  void atualizarProjeto(Projeto projetoAtualizado) {
    setState(() {
      projetos = _atualizarRegistro(
        projetos,
        projetoAtualizado,
        (projeto) => projeto.id,
      );
    });
  }

  void excluirProjeto(String id) {
    setState(() {
      projetos = _excluirRegistro(
        projetos,
        id,
        (projeto) => projeto.id,
      );
    });
  }

  Future<void> abrirCriarIdeia() async {
    final theme = Theme.of(context);
    
    final novaIdeia = await Navigator.of(context).push<Ideia>(
      MaterialPageRoute(
        builder: (context) => const CriarIdeia(),
      ),
    );

    if (novaIdeia == null || !mounted) return;

    setState(() {
      ideias.add(novaIdeia);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: theme.colorScheme.primary),
              SizedBox(width: 10),
              Text('Ideia criada com sucesso!'),
            ],
          ),
          duration: Duration(seconds: 3),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: SvgPicture.asset(
          'assets/images/logo.svg',
          height: 42,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: theme.colorScheme.primary,
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
        _construirHistoricoIdeias(),
        
        /// Histórico de Projetos
        _construirHistoricoProjetos(),
      ][currentPageIndex],
    );
  }
}
