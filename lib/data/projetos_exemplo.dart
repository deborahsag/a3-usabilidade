import 'projeto.dart';

final List<Projeto> projetosExemplo = [
  Projeto(
    id: '1',
    titulo: 'Desenvolvimento do Cápsula',
    descricao: 'Desenvolver o aplicativo para registrar, organizar '
        'e transformar ideias em projetos.',
    notificacao: 3,
    timestamp: '2026-11-17T08:00:00-03:00',
    arquivado: false,

    ideiaOriginalId: '1',
    ideiaOriginalTitulo: 'Aplicativo de organização pessoal',
    ideiaOriginalDescricao: 'Criar um aplicativo para registrar ideias, '
        'acompanhar seu desenvolvimento e organizar projetos derivados.',
    ideiaOriginalTimestamp: '2026-11-10T09:30:00-03:00',
  ),
  Projeto(
    id: '2',
    titulo: 'Organizador acadêmico',
    descricao: 'Criar uma aplicação para gerenciar disciplinas, '
        'atividades, prazos e compromissos acadêmicos.',
    notificacao: 2,
    timestamp: '2026-11-16T13:30:00-03:00',
    arquivado: false,

    ideiaOriginalId: '2',
    ideiaOriginalTitulo: 'Facilitar a organização dos estudos',
    ideiaOriginalDescricao: 'Uma ferramenta que ajude estudantes a '
        'acompanhar suas tarefas e organizar a rotina universitária.',
    ideiaOriginalTimestamp: '2026-11-12T14:15:00-03:00',
  ),
  Projeto(
    id: '3',
    titulo: 'Portfólio pessoal',
    descricao: 'Desenvolver um site para apresentar projetos, '
        'experiências e habilidades profissionais.',
    notificacao: 1,
    timestamp: '2026-11-14T10:15:00-03:00',
    arquivado: false,

    ideiaOriginalId: '3',
    ideiaOriginalTitulo: 'Criar um portfólio online',
    ideiaOriginalDescricao: 'Montar uma página pessoal para reunir '
        'trabalhos e facilitar sua divulgação.',
    ideiaOriginalTimestamp: '2026-11-08T11:00:00-03:00',
  ),
  Projeto(
    id: '4',
    titulo: 'Reformulação do blog',
    descricao: 'Atualizar o visual do blog, melhorar a navegação '
        'e reorganizar as categorias de conteúdo.',
    notificacao: 0,
    timestamp: '2026-11-05T17:00:00-03:00',
    arquivado: true,

    ideiaOriginalId: '4',
    ideiaOriginalTitulo: 'Melhorar meu blog pessoal',
    ideiaOriginalDescricao: 'Revisar a identidade visual e a estrutura '
        'de navegação do blog.',
    ideiaOriginalTimestamp: '2026-10-28T16:45:00-03:00',
  ),
];
