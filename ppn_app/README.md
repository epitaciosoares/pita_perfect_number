# PPn App - Frontend da Aplicação MathPerfect

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2.svg)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Aplicação mobile multiplataforma desenvolvida com **Flutter** para calcular e explorar **números perfeitos**. Interface intuiva com suporte a três features principais: informação educativa, verificação de números individuais e busca em intervalos.

---

## Índice

- [Sobre](#sobre)
- [Features](#features)
- [Arquitetura](#arquitetura)
- [Dependências](#dependências)
- [Estrutura de Diretórios](#estrutura-de-diretórios)
- [Como Começar](#como-começar)
- [Como Usar](#como-usar)
- [Testes](#testes)
- [Contribuindo](#contribuindo)

---

## Sobre

**PPn App** é a camada de apresentação (frontend) da aplicação MathPerfect. Oferece uma experiência visual moderna e intuitiva para usuários explorarem números perfeitos através de:

- Interface responsiva e moderna
- Design com feedback visual imediato
- Arquitetura Clean com separação clara
- Gerenciamento de estado com Provider
- Integração com API backend
- Suporte offline com cache local

---

## Features

### 1. **Página Info** 
- Definição clara de números perfeitos
- Exemplos práticos ilustrados (6, 28, etc)
- Cards coloridos com informações estruturadas
- Curiosidades matemáticas
- Guia de como usar o app

### 2. **Verificador de Números** 
- Interface limpa para digitar números
- Validação em tempo real
- Feedback visual com cores:
  - Verde: número é perfeito
  - Laranja: resultado offline
  - Vermelho: não é perfeito ou erro
- Suporte para números até 2.147.483.647

### 3. **Busca em Intervalo** 
- Campos para número inicial e final
- Procura eficiente em intervalos
- Lista de resultados com cards
- Indicadores de performance offline
- Contagem e detalhes dos números encontrados

---

## Arquitetura

O projeto segue **Clean Architecture** com três camadas principais:

```
┌─────────────────────────────────────────┐
│     Camada de Apresentação (UI)         │
│  • Widgets • ViewModels • States        │
├─────────────────────────────────────────┤
│       Camada de Domínio                 │
│  • Entidades • Repositórios (Abstratos) │
├─────────────────────────────────────────┤
│        Camada de Dados                  │
│  • APIs • Repositórios (Concretos)      │
└─────────────────────────────────────────┘
```

### Camadas Detalhadas:

#### 1. **Apresentação** (`lib/ui/`)
```
ui/
├── home/
│   ├── home.dart                    # Tela principal com BottomNavigationBar
│   ├── viewmodels/
│   │   ├── home_viewmodel.dart
│   │   ├── perfect_number_viewmodel.dart
│   │   └── range_perfect_number_viewmodel.dart
│   ├── states/
│   │   ├── home_state.dart
│   │   ├── perfect_number_state.dart
│   │   └── range_perfect_number_state.dart
│   └── widgets/
│       ├── info_page.dart
│       ├── single_check_page.dart
│       └── range_check_page.dart
└── core/
    └── viewmodels/
        └── view_model.dart          # ViewModel base
```

#### 2. **Domínio** (`lib/domain/`)
```
domain/
├── entities/
│   └── perfect_number_entity.dart
├── repositories/
│   └── perfect_number_repository.dart
├── contracts/
│   ├── repository.dart
│   ├── service.dart
│   └── view_model_base.dart
└── exceptions/
    └── app_esception.dart
```

#### 3. **Dados** (`lib/data/`)
```
data/
├── api/
│   └── perfect_number_api.dart
└── repositories/
    └── perfect_number_repository_impl.dart
```

### Padrões Utilizados:

- **ViewModel Pattern**: Cada feature tem seu próprio ViewModel
- **State Management**: Estados tipados para cada operação
- **Repository Pattern**: Abstração de fontes de dados
- **Dependency Injection**: CustomInjector com AutoInjector
- **Provider**: Para notificação e observação de mudanças

---

## Dependências

### Core Framework
- **flutter**: ^3.0.0 - Framework UI multiplataforma
- **flutter_localizations**: Suporte a localização

### State Management
- **provider**: ^6.0.0 - Gerenciamento de estado

### Networking
- **dio**: ^5.0.0 - Cliente HTTP com interceptadores

### Injeção de Dependências
- **auto_injector**: ^1.0.0 - Container de DI tipo Arduino

### Tratamento de Erros
- **result_dart**: ^4.0.0 - Tratamento funcional de resultados (Result<T, Error>)

### Desenvolvimento
- **flutter_test**: Testes unitários e de widget
- **mockito**: ^5.0.0 - Mocks para testes

---

## Estrutura de Diretórios

```
lib/
├── main.dart                    # Entrada da aplicação
├── main_viewmodel.dart          # ViewModel principal
├── config/
│   ├── dependencies.dart        # Setup de injeção de dependências
│   ├── dio/
│   │   └── dio_factory.dart    # Configuração do cliente HTTP
│   └── openapi/
├── domain/                      # Camada de domínio
│   ├── domain.dart             # Exports
│   ├── contracts/
│   │   ├── repository.dart
│   │   ├── service.dart
│   │   └── view_model_base.dart
│   ├── entities/
│   │   └── perfect_number_entity.dart
│   ├── exceptions/
│   │   └── app_esception.dart
│   └── repositories/
│       └── perfect_number_repository.dart
├── data/                        # Camada de dados
│   ├── api/
│   │   └── perfect_number_api.dart
│   └── repositories/
│       └── perfect_number_repository_impl.dart
├── ui/                          # Camada de apresentação
│   ├── core/
│   │   └── viewmodels/
│   │       └── view_model.dart
│   └── home/
│       ├── home.dart
│       ├── viewmodels/
│       │   ├── home_viewmodel.dart
│       │   ├── perfect_number_viewmodel.dart
│       │   └── range_perfect_number_viewmodel.dart
│       ├── states/
│       │   ├── home_state.dart
│       │   ├── perfect_number_state.dart
│       │   └── range_perfect_number_state.dart
│       └── widgets/
│           ├── info_page.dart
│           ├── single_check_page.dart
│           └── range_check_page.dart
├── routing/
│   ├── router.dart
│   └── routes.dart
└── utils/
    └── custom_injector.dart

test/
├── widget_test.dart
└── data/
```

---

## Como Começar

### Pré-requisitos
- Flutter ^3.0.0 instalado ([Download](https://flutter.dev/docs/get-started/install))
- Dart ^3.0.0
- Um emulador/dispositivo físico ou simulador

### Instalação

1. **Navegue para o diretório do app**
```bash
cd ppn_app
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute a aplicação**

```bash
# iOS (macOS apenas)
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d chrome

# Desktop (Windows, macOS ou Linux)
flutter run -d windows
# flutter run -d macos
# flutter run -d linux
```

### Conectar ao Backend

Por padrão, a aplicação tenta conectar ao backend em `http://localhost:8080`. 

Para mudar a URL:
1. Abra `lib/config/dio/dio_factory.dart`
2. Altere a baseUrl no Dio:

```dart
dio.options.baseUrl = 'sua-url-aqui';
```

---

## Como Usar

### Primeira Vez
1. Inicie o app - você verá a aba "Info"
2. Leia a definição de números perfeitos
3. Navegue até "Verificar" para testar um número
4. Use "Buscar" para explorar intervalos

### Aba Info
- Veja a teoria completa
- Estude exemplos práticos interativos
- Conheça curiosidades

### Aba Verificar
1. Digite um número (ex: 6, 28, 100)
2. Toque "Verificar Perfeição"
3. Veja o resultado com feedback visual

### Aba Buscar
1. Digite número inicial (ex: 1)
2. Digite número final (ex: 1000)
3. Toque "Procurar Números Perfeitos"
4. Explore a lista de resultados

---

## Testes

### Rodar Testes
```bash
flutter test
```

### Testes com Cobertura
```bash
flutter test --coverage
```

### Visualizar Cobertura (macOS/Linux)
```bash
lcov --list coverage/lcov.info
```

### Estrutura de Testes
```
test/
├── widget_test.dart           # Testes de widgets
├── data/
│   ├── api/                   # Testes de API
│   └── repositories/          # Testes de repositórios
```

---

## Fluxo de Dados

### Verificação de Número Único

```
User Input (UI)
    ↓
PerfectNumberViewmodel.checkNumber()
    ↓
PerfectNumberRepository.isPerfectNumber()
    ↓
PerfectNumberApi.checkPerfectNumber()
    ↓
Backend API
    ↓
Response → Parse → Entity
    ↓
Emit State (Success/Offline/Error)
    ↓
Widget Rebuild com Resultado
```

### Busca em Intervalo

```
User Input (UI)
    ↓
RangePerfectNumberViewmodel.searchRange()
    ↓
PerfectNumberRepository.findPerfectNumbers()
    ↓
PerfectNumberApi.findPerfectNumber()
    ↓
Backend API / Cache Local (offline)
    ↓
Response → Parse → List<Entity>
    ↓
Emit State (Success/Offline/Error)
    ↓
ListView com Resultados
```

---

## States (Estados)

### PerfectNumberState
```dart
sealed class PerfectNumberState {}

class PerfectNumberInitialState extends PerfectNumberState {}
class PerfectNumberLoadingState extends PerfectNumberState {}
class PerfectNumberSuccessState extends PerfectNumberState {
  final PerfectNumberEntity result;
}
class PerfectNumberSuccessOfflineState extends PerfectNumberState {
  final PerfectNumberEntity result;
}
class PerfectNumberErrorState extends PerfectNumberState {
  final String message;
}
```

### RangePerfectNumberState
```dart
sealed class RangePerfectNumberState {}

class RangeInitialState extends RangePerfectNumberState {}
class RangeLoadingState extends RangePerfectNumberState {}
class RangeSuccessState extends RangePerfectNumberState {
  final List<PerfectNumberEntity> results;
}
class RangeSuccessOfflineState extends RangePerfectNumberState {
  final List<PerfectNumberEntity> results;
}
class RangeErrorState extends RangePerfectNumberState {
  final String message;
}
```

---

## Boas Práticas

1. **Sempre use ViewModels** - Lógica sempre no ViewModel, nunca no Widget
2. **Estados Tipados** - Use sealed classes para type-safety
3. **Injeção de Dependências** - Use CustomInjector, nunca instanciar diretamente
4. **Tratamento de Erros** - Use AppException e Result<T>
5. **Offline First** - APIs têm fallback offline automático
6. **Widgets Pequenos** - Decomponha em widgets menores para melhor reusabilidade

---

## Troubleshooting

### Erro: "Failed to connect to backend"
```
✓ Verifique se o backend está rodando em http://localhost:8080
✓ Verifique a URL em dio_factory.dart
✓ Cheque a conexão de rede
✓ O app usa cache local automaticamente se falhar
```

### Texto Cortado em Cards
```
✓ Aumentar altura do card
✓ Usar SingleChildScrollView
✓ Reduzir tamanho da fonte
```

### Performance Lenta em Grandes Intervalos
```
✓ Restrinja a busca a intervalos menores
✓ Use ListView.separated com separador
✓ Cache é atualizado automaticamente
```

---

## Contribuindo

1. Crie uma branch (`git checkout -b feature/AmazingFeature`)
2. Commit suas mudanças (`git commit -m 'Add AmazingFeature'`)
3. Push para a branch (`git push origin feature/AmazingFeature`)
4. Abra um Pull Request

---

## Recursos

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Provider State Management](https://pub.dev/packages/provider)
- [Dio HTTP Client](https://pub.dev/packages/dio)

---

## Autor

**Epitacio Soares Junior**

- GitHub: [@epitaciosoares](https://github.com/epitaciosoares/)
- Email: epitacio.junior@gmail.com

---

## Licença

Este projeto está licenciado sob a Licença MIT - veja [LICENSE](../LICENSE) para detalhes.

---


