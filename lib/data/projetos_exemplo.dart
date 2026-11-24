import 'projeto.dart';
import 'campo_projeto.dart';

final List<Projeto> projetosExemplo = [
  Projeto(
    id: 'projeto_001',
    titulo: 'Viagem para Ouro Preto',
    notificacao: 1,
    timestamp: '2026-11-23T10:00:00Z',
    arquivado: false,
    ideiaOriginalId: 'ideia_001',
    ideiaOriginalTitulo: 'Conhecer cidades históricas',
    ideiaOriginalDescricao: 'Fazer uma viagem para conhecer cidades históricas de Minas Gerais.',
    ideiaOriginalTimestamp: '2026-11-20T10:00:00Z',
    camposProjeto: [
      CampoTexto(
        texto: 'Viagem de fim de semana para conhecer o centro histórico de Ouro Preto.',
      ),
      CampoLista(
        checklist: [
          ChecklistItem(isChecked: true, texto: 'Reservar hospedagem'),
          ChecklistItem(isChecked: false, texto: 'Comprar passagens'),
          ChecklistItem(isChecked: false, texto: 'Pesquisar restaurantes'),
          ChecklistItem(isChecked: false, texto: 'Preparar a mala'),
        ],
      ),
      CampoTexto(
        texto: 'Lembrar de levar uma câmera fotográfica.',
      ),
    ],
  ),
  Projeto(
    id: 'projeto_002',
    titulo: 'Aplicativo de gerenciamento de tarefas',
    notificacao: 3,
    timestamp: '2026-11-23T11:00:00Z',
    arquivado: false,
    ideiaOriginalId: 'ideia_002',
    ideiaOriginalTitulo: 'Criar um aplicativo de produtividade',
    ideiaOriginalDescricao: 'Desenvolver um aplicativo para organizar tarefas e compromissos.',
    ideiaOriginalTimestamp: '2026-11-18T14:00:00Z',
    camposProjeto: [
      CampoTexto(
        texto: 'Desenvolver um aplicativo Flutter com armazenamento em nuvem.',
      ),
      CampoLista(
        checklist: [
          ChecklistItem(isChecked: true, texto: 'Criar protótipo'),
          ChecklistItem(isChecked: true, texto: 'Implementar autenticação'),
          ChecklistItem(isChecked: false, texto: 'Implementar CRUD de tarefas'),
          ChecklistItem(isChecked: false, texto: 'Implementar notificações'),
          ChecklistItem(isChecked: false, texto: 'Realizar testes'),
        ],
      ),
    ],
  ),
  Projeto(
    id: 'projeto_003',
    titulo: 'Festa de aniversário',
    notificacao: 2,
    timestamp: '2026-11-23T12:00:00Z',
    arquivado: false,
    ideiaOriginalId: 'ideia_003',
    ideiaOriginalTitulo: 'Comemorar meu aniversário',
    ideiaOriginalDescricao: 'Organizar uma comemoração com amigos e familiares.',
    ideiaOriginalTimestamp: '2026-11-15T09:00:00Z',
    camposProjeto: [
      CampoTexto(
        texto: 'Realizar a festa no sábado à noite, com aproximadamente 20 convidados.',
      ),
      CampoLista(
        checklist: [
          ChecklistItem(isChecked: false, texto: 'Escolher o local'),
          ChecklistItem(isChecked: true, texto: 'Definir a data'),
          ChecklistItem(isChecked: false, texto: 'Enviar convites'),
          ChecklistItem(isChecked: false, texto: 'Encomendar o bolo'),
          ChecklistItem(isChecked: false, texto: 'Comprar bebidas'),
        ],
      ),
      CampoTexto(
        texto: 'Tema: festa tropical. Decoração em tons de verde e amarelo.',
      ),
    ],
  ),
  Projeto(
    id: 'projeto_004',
    titulo: 'Preparação para prova de Estrutura de Dados',
    notificacao: 1,
    timestamp: '2026-11-23T13:00:00Z',
    arquivado: false,
    ideiaOriginalId: 'ideia_004',
    ideiaOriginalTitulo: 'Melhorar meu desempenho acadêmico',
    ideiaOriginalDescricao: 'Organizar meus estudos para as avaliações da faculdade.',
    ideiaOriginalTimestamp: '2026-11-10T08:00:00Z',
    camposProjeto: [
      CampoTexto(
        texto: 'Revisar os principais conceitos de estruturas de dados e praticar exercícios.',
      ),
      CampoLista(
        checklist: [
          ChecklistItem(isChecked: true, texto: 'Revisar listas encadeadas'),
          ChecklistItem(isChecked: false, texto: 'Estudar pilhas e filas'),
          ChecklistItem(isChecked: false, texto: 'Revisar árvores binárias'),
          ChecklistItem(isChecked: false, texto: 'Resolver exercícios'),
        ],
      ),
    ],
  ),
  Projeto(
    id: 'projeto_005',
    titulo: 'Portfólio pessoal',
    notificacao: 0,
    timestamp: '2026-11-23T14:00:00Z',
    arquivado: false,
    ideiaOriginalId: 'ideia_005',
    ideiaOriginalTitulo: 'Criar meu portfólio',
    ideiaOriginalDescricao: 'Ter um site para apresentar meus projetos e experiências.',
    ideiaOriginalTimestamp: '2026-11-05T15:00:00Z',
    camposProjeto: [
      CampoTexto(
        texto: 'Criar um site pessoal para apresentar trabalhos acadêmicos e projetos independentes.',
      ),
      CampoTexto(
        texto: 'Tecnologias: HTML, CSS, JavaScript e Flutter Web.',
      ),
      CampoLista(
        checklist: [
          ChecklistItem(isChecked: true, texto: 'Definir identidade visual'),
          ChecklistItem(isChecked: false, texto: 'Desenvolver página inicial'),
          ChecklistItem(isChecked: false, texto: 'Criar seção de projetos'),
          ChecklistItem(isChecked: false, texto: 'Publicar o site'),
        ],
      ),
    ],
  ),
  Projeto(
    id: 'projeto_006',
    titulo: 'Nova iniciativa',
    notificacao: 0,
    timestamp: '2026-11-23T15:00:00Z',
    arquivado: false,
    ideiaOriginalId: 'ideia_006',
    ideiaOriginalTitulo: 'Começar algo novo',
    ideiaOriginalDescricao: 'Explorar uma nova possibilidade.',
    ideiaOriginalTimestamp: '2026-11-22T10:00:00Z',
    camposProjeto: [],
  ),
];
