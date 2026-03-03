# MathPerfect - Arquitetura do Projeto

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2.svg)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Documentação completa da arquitetura do projeto **MathPerfect**, uma aplicação educacional para estudo de números perfeitos com frontend mobile e backend REST.

---

## Índice

- [Visão Geral](#visão-geral)
- [Arquitetura Geral](#arquitetura-geral)
- [Frontend (PPn App)](#frontend-ppn-app)
- [Backend (PPn Backend)](#backend-ppn-backend)
- [Fluxo de Dados](#fluxo-de-dados)
- [Padrões de Projeto](#padrões-de-projeto)
- [Stack Tecnológico](#stack-tecnológico)
- [Estrutura de Pastas](#estrutura-de-pastas)
- [Deployment](#deployment)

---

## Visão Geral

**MathPerfect** é uma aplicação full-stack que permite usuários explorarem números perfeitos através de:

```
┌─────────────────────────────────────┐
│   Usuário Final                     │
│  (Mobile/Web/Desktop)               │
└────────────────┬────────────────────┘
                 │ HTTP/REST
                 ↓
┌─────────────────────────────────────┐
│   PPn App (Frontend)                │
│   • Flutter                         │
│   • Provider State Management       │
│   • Clean Architecture              │
└────────────────┬────────────────────┘
                 │ HTTP (Dio)
                 ↓
┌─────────────────────────────────────┐
│   PPn Backend (Server)              │
│   • Dart + Vaden Framework          │
│   • REST API                        │
│   • Clean Architecture              │
└────────────────┬────────────────────┘
                 │ Algoritmo de Cálculo
                 ↓
┌─────────────────────────────────────┐
│   Resultado de Números Perfeitos    │
└─────────────────────────────────────┘
```

---

## Arquitetura Geral

### Padrão de Arquitetura: Clean Architecture

O projeto é organizado em **camadas** tanto no frontend quanto no backend:

```
┌────────────────────────────────────────────────────┐
│                Camada de Apresentação              │
│        (UI Widgets, ViewModels, States)            │
├────────────────────────────────────────────────────┤
│            Camada de Domínio (Común)               │
│     (Entidades, Repositórios Abstratos)            │
├────────────────────────────────────────────────────┤
│             Camada de Dados/Infraestrutura         │
│     (APIs HTTP, Implementações, Cache)             │
├────────────────────────────────────────────────────┤
│                Camada de Backend                   │
│        (Controllers, Repositórios, Negócio)        │
└────────────────────────────────────────────────────┘
```

### Princípios

- ✅ **Separação de Responsabilidades** - Cada camada tem uma função clara
- ✅ **Independência de Frameworks** - Lógica não depende de UI ou HTTP
- ✅ **Testabilidade** - Fácil de testar cada camada isoladamente
- ✅ **Escalabilidade** - Fácil adicionar nuevas features
- ✅ **Maintainability** - Código organizado e bem documentado

---

## Frontend (PPn App)

### Camadas do Frontend

```
┌─────────────────────────────────────────┐
│     Presentation Layer (UI)             │
│  ├── home.dart (BottomNavigation)       │
│  ├── info_page.dart (Educativo)         │
│  ├── single_check_page.dart (Verificar) │
│  └── range_check_page.dart (Buscar)     │
├─────────────────────────────────────────┤
│     ViewModels + States                 │
│  ├── HomeViewmodel                      │
│  ├── PerfectNumberViewmodel             │
│  └── RangePerfectNumberViewmodel        │
├─────────────────────────────────────────┤
│     Domain Layer                        │
│  ├── Entities (PerfectNumberEntity)     │
│  ├── Repositories (Abstract)            │
│  └── Exceptions                         │
├─────────────────────────────────────────┤
│     Data Layer                          │
│  ├── APIs (HTTP via Dio)                │
│  ├── Repositories (Impl)                │
│  └── Cache Local                        │
└─────────────────────────────────────────┘
```

### Componentes Principais

#### 1. **Presentation Layer (UI)**
```dart
// Estrutura de Widgets
Home (Stateful)
  ├── InfoPage (Página educativa)
  ├── SingleCheckPage (Verificar um número)
  └── RangeCheckPage (Buscar intervalo)
```

- **Home**: Tela principal com BottomNavigationBar
- **InfoPage**: Cards educativos sobre números perfeitos
- **SingleCheckPage**: Input para verificar um número
- **RangeCheckPage**: Inputs para buscar intervalo

#### 2. **State Management (ViewModels + States)**

```dart
// ViewModel Base
abstract class ViewModel<T> extends ChangeNotifier {
  T _state;
  get state => _state;
  void emit(T newState) { ... }
}

// Estados Tipados (Sealed Classes)
sealed class PerfectNumberState {}
  - PerfectNumberInitialState
  - PerfectNumberLoadingState
  - PerfectNumberSuccessState
  - PerfectNumberSuccessOfflineState
  - PerfectNumberErrorState

sealed class RangePerfectNumberState {}
  - RangeInitialState
  - RangeLoadingState
  - RangeSuccessState
  - RangeSuccessOfflineState
  - RangeErrorState
```

#### 3. **Dependency Injection**

```dart
// Setup automático via CustomInjector
setupDependencies() {
  addLazySingleton<Dio>()
  addLazySingleton<PerfectNumberApi>()
  addRepository<PerfectNumberRepository>()
  addViewModel<PerfectNumberViewmodel>()
  addViewModel<RangePerfectNumberViewmodel>()
  commit()
}
```

#### 4. **Offline Support**

Quando a API falha, uma implementação local entra em ação:

```dart
// PerfectNumberRepositoryImpl
- Mantém lista de números perfeitos conhecidos (6, 28, 496, 8128, 33550336)
- Fallback automático quando API não responde
- Cache local retorna resultados offline
```

---

## Backend (PPn Backend)

### Camadas do Backend

```
┌─────────────────────────────────────────┐
│     API/Controller Layer                │
│  └── PerfectNumberController            │
├─────────────────────────────────────────┤
│     Domain Layer                        │
│  ├── Entidades                          │
│  └── Repositórios (Abstract)            │
├─────────────────────────────────────────┤
│     Infrastructure/Data Layer           │
│  ├── RepositóriosImpl (Implementações)   │
│  └── Cálculos de Números Perfeitos      │
└─────────────────────────────────────────┘
```

### API Endpoints

#### GET `/perfectnumber/check`
Verifica se um número é perfeito

```bash
curl "http://localhost:8080/perfectnumber/check?number=28"
```

**Resposta:**
```json
{
  "number": 28,
  "isPerfect": true
}
```

#### GET `/perfectnumber/find`
Encontra todos os números perfeitos em um intervalo

```bash
curl "http://localhost:8080/perfectnumber/find?start=1&end=500"
```

**Resposta:**
```json
[
  { "number": 6, "isPerfect": true },
  { "number": 28, "isPerfect": true },
  { "number": 496, "isPerfect": true }
]
```

### Lógica de Negócio

#### Algoritmo de Verificação
```
Para verificar se N é perfeito:
1. Encontrar todos os divisores de N
2. Somar os divisores (excluindo N mesmo)
3. Se soma == N → É perfeito ✓
4. Senão → Não é perfeito ✗
```

#### Performance
- Números conhecidos: 6, 28, 496, 8128, 33550336 (até 32 bits)
- Busca otimizada em intervalos
- Cache de resultados quando aplicável

---

## Fluxo de Dados

### Fluxo 1: Verificar um Número (Single Check)

```
┌──────────────────────────────────────────────────────┐
│ USER INTERACTION                                     │
└────────┬─────────────────────────────────────────────┘
         │ Digita número e clica "Verificar"
         ↓
┌──────────────────────────────────────────────────────┐
│ FRONTEND - PRESENTATION                              │
│ SingleCheckPage.onPressed()                          │
└────────┬─────────────────────────────────────────────┘
         │ vm.checkNumber(number)
         ↓
┌──────────────────────────────────────────────────────┐
│ FRONTEND - VIEWMODEL                                 │
│ PerfectNumberViewmodel.checkNumber()                 │
│ emit(PerfectNumberLoadingState)                      │
└────────┬─────────────────────────────────────────────┘
         │ repository.isPerfectNumber(number)
         ↓
┌──────────────────────────────────────────────────────┐
│ FRONTEND - DATA LAYER                                │
│ PerfectNumberRepositoryImpl                           │
│ _api.checkPerfectNumber()                            │
└────────┬─────────────────────────────────────────────┘
         │ HTTP GET /perfectnumber/check?number=28
         ↓
┌──────────────────────────────────────────────────────┐
│ BACKEND - API LAYER                                  │
│ PerfectNumberController.checkPerfectNumber()         │
└────────┬─────────────────────────────────────────────┘
         │ repository.isPerfect(number)
         ↓
┌──────────────────────────────────────────────────────┐
│ BACKEND - DOMAIN LAYER                               │
│ PerfectNumberRepositoryImpl                           │
│ Calcula e retorna resultado                          │
└────────┬─────────────────────────────────────────────┘
         │ { "number": 28, "isPerfect": true }
         ↓
┌──────────────────────────────────────────────────────┐
│ FRONTEND - DATA LAYER (Parse)                        │
│ Response → PerfectNumberEntity                       │
└────────┬─────────────────────────────────────────────┘
         │ entity
         ↓
┌──────────────────────────────────────────────────────┐
│ FRONTEND - VIEWMODEL                                 │
│ emit(PerfectNumberSuccessState(entity))              │
└────────┬─────────────────────────────────────────────┘
         │ rebuilds widget
         ↓
┌──────────────────────────────────────────────────────┐
│ FRONTEND - PRESENTATION                              │
│ SingleCheckPage rebuilds com resultado               │
│ Mostra Card com cor verde (sucesso)                  │
└──────────────────────────────────────────────────────┘
```

### Fluxo 2: Buscar em Intervalo (Range Check)

```
USER INPUT (Intervalo: 1-100)
    ↓
RangeCheckPage.onPressed()
    ↓
RangePerfectNumberViewmodel.searchRange(1, 100)
    ↓
emit(RangeLoadingState)
    ↓
PerfectNumberRepository.findPerfectNumbers(1, 100)
    ↓
PerfectNumberApi.findPerfectNumber(1, 100)
    ↓
HTTP GET /perfectnumber/find?start=1&end=100
    ↓
Backend processa e retorna lista
    ↓
Parse response → List<PerfectNumberEntity>
    ↓
emit(RangeSuccessState(results))
    ↓
RangeCheckPage rebuilds
    ↓
ListView mostra resultados com cards
```

### Fallback Offline

```
Sem conexão de rede
    ↓
HTTP Request falha
    ↓
PerfectNumberRepositoryImpl captura erro
    ↓
Busca em _listPerfectNumbersMaxInt (cache local)
    ↓
Retorna resultados offline
    ↓
emit(PerfectNumberSuccessOfflineState) ← Cor laranja!
    ↓
UI mostra resultado com indicador offline
```

---

## Padrões de Projeto

### 1. **Clean Architecture**
- Separação clara entre UI, Domínio e Dados
- Independência de frameworks
- Fácil de testar

### 2. **Repository Pattern**
```dart
// Abstração do repository
abstract class PerfectNumberRepository {
  Future<PerfectNumberEntity> isPerfectNumber(int number);
  Future<List<PerfectNumberEntity>> findPerfectNumbers(int start, int end);
}

// Implementação
class PerfectNumberRepositoryImpl extends PerfectNumberRepository {
  // Implementa métodos com lógica de fallback offline
}
```

### 3. **ViewModel Pattern**
```dart
// Cada feature tem seu próprio ViewModel
abstract class ViewModel<T> extends ChangeNotifier {
  T _state;
  void emit(T newState) { ... }
}
```

### 4. **Result Pattern** (Result<Success, Failure>)
```dart
// Tratamento funcional de erros
AsyncResult<PerfectNumberEntity> checkPerfectNumber(int number) async {
  try {
    return Success(entity);
  } catch (e) {
    return Failure(AppException(...));
  }
}
```

### 5. **Dependency Injection**
```dart
// AutoInjector via CustomInjector
setupDependencies() {
  _injector.addRepository<T>(constructor)
  _injector.addViewModel<T>(constructor)
  _injector.commit()
}
```

### 6. **State Management com Sealed Classes**
```dart
sealed class MyState {}
class InitialState extends MyState {}
class LoadingState extends MyState {}
class SuccessState extends MyState { final data; }
class ErrorState extends MyState { final String message; }
```

---

## Stack Tecnológico

### Frontend (PPn App)
```
Flutter & Dart
  ├── UI Framework: Flutter ^3.0.0
  ├── Language: Dart ^3.0.0
  ├── State Management: Provider ^6.0.0
  ├── HTTP Client: Dio ^5.0.0
  ├── Dependency Injection: AutoInjector ^1.0.0
  ├── Error Handling: result_dart ^4.0.0
  └── Testing: flutter_test, mockito ^5.0.0
```

### Backend (PPn Backend)
```
Dart Web Server
  ├── Framework: Vaden (Custom Dart Web Framework)
  ├── Language: Dart ^3.0.0
  ├── Router: Vaden Router
  ├── Error Handling: result_dart ^4.0.0
  ├── Security: Vaden Security
  ├── OpenAPI: Vaden OpenAPI
  └── Testing: dart:test, mockito ^5.0.0
```

### Compartilhado
```
Common
  ├── Entities: PerfectNumberEntity
  ├── Contracts: Repository, Service, ViewModelBase
  ├── Exceptions: AppException (sealed)
  └── Concepts: Números Perfeitos (Matemática)
```

---

## Estrutura de Pastas

```
pita-perfect-number/
├── docs/
│   └── ARCHITECTURE.md              # Este arquivo
│
├── ppn_app/                         # Frontend
│   ├── lib/
│   │   ├── main.dart
│   │   ├── config/
│   │   │   ├── dependencies.dart    # Setup DI
│   │   │   └── dio/
│   │   ├── domain/                  # Domain Layer
│   │   ├── data/                    # Data Layer
│   │   ├── ui/                      # Presentation Layer
│   │   │   ├── home/
│   │   │   │   ├── home.dart
│   │   │   │   ├── viewmodels/
│   │   │   │   ├── states/
│   │   │   │   └── widgets/
│   │   │   └── core/
│   │   └── routing/
│   ├── test/
│   ├── pubspec.yaml
│   └── README.md
│
├── ppn_backend/                     # Backend
│   ├── lib/
│   │   ├── config/                  # Configurações
│   │   │   └── app_module.dart
│   │   ├── src/
│   │   │   ├── api/                 # Controllers
│   │   │   │   └── perfetc_numbers/
│   │   │   └── domain/              # Domain Logic
│   │   └── vaden_application.dart
│   ├── bin/
│   │   └── server.dart              # Entry point
│   ├── test/
│   ├── pubspec.yaml
│   └── README.md
│
├── README.md                        # Documentação Geral
└── LICENSE
```

---

## Deployment

### Frontend (PPn App)

#### Android
```bash
cd ppn_app
flutter run -d android
# ou
flutter build apk --release
```

#### iOS
```bash
cd ppn_app
flutter run -d ios
# ou
flutter build ios --release
```

#### Web
```bash
cd ppn_app
flutter run -d web --release
# ou
flutter build web
```

#### Desktop
```bash
cd ppn_app
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

### Backend (PPn Backend)

#### Desenvolvimento
```bash
cd ppn_backend
dart run bin/server.dart
```

#### Produção
```bash
cd ppn_backend
dart compile exe bin/server.dart -o bin/server
./bin/server
```

#### Docker (Opcional)
```dockerfile
FROM google/dart:latest
WORKDIR /app
COPY ppn_backend .
RUN dart pub get
EXPOSE 8080
CMD ["dart", "run", "bin/server.dart"]
```

---

## Comunicação Entre Camadas

### Frontend para Backend

```
JSON (HTTP)
  ↑
  ├── PerfectNumberApi (DTO)
  │   ├── checkPerfectNumber(int) → PerfectNumberDTO
  │   └── findPerfectNumber(int, int) → List<PerfectNumberDTO>
  │
  └── Dio (HTTP Client)
      └── GET /perfectnumber/check?number=X
```

### Formato de Dados (JSON)

```json
// Single Number Response
{
  "number": 28,
  "isPerfect": true
}

// Range Response
[
  {
    "number": 6,
    "isPerfect": true
  },
  {
    "number": 28,
    "isPerfect": true
  }
]
```

---

## Tratamento de Erros

### Exceções (AppException)

```dart
sealed class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  final Exception? originalException;
}

// Subtipos
class CreateException extends AppException {}      // Erro padrão
class SilentException extends AppException {}      // Não mostrar ao usuário
class FatalException extends AppException {}       // Erro crítico
```

### Estados de Erro no Frontend

```dart
PerfectNumberErrorState(message) → Mostra em Card Vermelho
RangeErrorState(message) → Mostra em Card Vermelho
```

### Respostas de Erro no Backend

```json
{
  "error": "Invalid number",
  "message": "Number must be greater than 0"
}
```

---

## Performance e Otimizações

### Frontend
- ✅ Provider para rebuild seletivo
- ✅ Estado imutável para comparações seguras
- ✅ Cache offline automático
- ✅ Lazy loading de widgets

### Backend
- ✅ Algoritmo eficiente de cálculo
- ✅ Cache de números perfeitos conhecidos
- ✅ Validação rápida de entrada

---

## Segurança

### Frontend
- ✅ Validação de entrada (números inteiros)
- ✅ Tratamento seguro de exceções
- ✅ Sem armazenamento de dados sensíveis

### Backend
- ✅ Validação de parâmetros
- ✅ Tratamento de erros tipado
- ✅ CORS configurado (se necessário)

---

## Testes

### Frontend
```bash
cd ppn_app
flutter test                    # Todos os testes
flutter test --coverage         # Com cobertura
```

### Backend
```bash
cd ppn_backend
dart test                       # Todos os testes
dart run coverage:test_with_coverage  # Com cobertura
```

---

## Próximos Passos

1. **Adicionar autenticação** (JWT tokens)
2. **Persistência de dados** (Hive/SQLite)
3. **Histórico de buscas**
4. **Estatísticas de uso**
5. **Modo escuro**
6. **Internacionalização (i18n)**
7. **PWA para web**
8. **Testes E2E**

---

## Referências

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Architecture](https://flutter.dev/docs/development/architecture)
- [Flutter State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/)
- [Dart Lang](https://dart.dev/)

---

## Suporte

Para dúvidas sobre a arquitetura, abra uma issue ou entre em contato com os desenvolvedores.

