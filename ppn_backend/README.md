# PPn Backend - Pita Perfect Number Server

Um servidor REST desenvolvido em Dart usando o framework [Vaden] que fornece APIs para verificar e encontrar números perfeitos.

##  Características

- **API RESTful** para validação de números perfeitos
- **Busca em ranges** para encontrar múltiplos números perfeitos
- **Arquitetura em camadas** com Clean Architecture
- **Injeção de dependência** automática com Vaden
- **Tratamento de erros** tipado com `result_dart`
- **Documentação OpenAPI** integrada
- **Testes unitários** com 100% de cobertura dos casos principais
- **Build automático** com build_runner

##  Pré-requisitos

- Dart SDK ^3.10.0
- Git

##  Como executar

### 1. Clonar o repositório

```bash
git clone https://github.com/seu-usuario/pita-perfect-number.git
cd pita-perfect-number/ppn_backend
```

### 2. Instalar dependências

```bash
dart pub get
```

### 3. Gerar código (build_runner)

```bash
dart dart run build_runner build
```

### 4. Executar o servidor

```bash
dart dart run bin/server.dart
```

O servidor iniciará na porta **8080** por padrão.

## Estrutura do Projeto

```
lib/
├── config/                          # Configurações da aplicação
│   ├── app_configuration.dart
│   ├── app_controller_advice.dart
│   ├── app_module.dart
│   ├── openapi/                    # Configurações OpenAPI/Swagger
│   ├── resources/
│   └── security/
├── src/
│   ├── api/                        # Controllers (HTTP Layer)
│   │   └── perfetc_numbers/
│   │       └── perfect_number_controller.dart
│   └── domain/                     # Domain Layer (Lógica de Negócio)
│       ├── entities/
│       │   └── perfect_number_entity.dart
│       └── repositories/
│           ├── perfect_number_repository.dart    # Interface
│           └── perfect_number_repository_impl.dart # Implementação
└── vaden_application.dart          # Arquivo gerado automaticamente

test/                               # Testes
├── src/
│   ├── api/
│   │   └── perfect_number_controller_test.dart
│   └── domain/
│       └── repositories/
│           └── perfect_number_repository_impl_test.dart
```

##  API Endpoints

### 1. Verificar se um número é perfeito

**GET** `/perfectnumber/check`

Query Parameters:
- `number` (int, obrigatório): Número a ser verificado

**Exemplo:**
```bash
curl "http://localhost:8080/perfectnumber/check?number=28"
```

**Resposta de sucesso (200):**
```json
{
  "number": 28,
  "isPerfect": true
}
```

**Exemplo com número não-perfeito:**
```bash
curl "http://localhost:8080/perfectnumber/check?number=10"
```

**Resposta:**
```json
{
  "number": 10,
  "isPerfect": false
}
```

---

### 2. Encontrar números perfeitos em um range

**GET** `/perfectnumber/find`

Query Parameters:
- `start` (int, obrigatório): Início do range (inclusive)
- `end` (int, obrigatório): Fim do range (inclusive)

**Exemplo:**
```bash
curl "http://localhost:8080/perfectnumber/find?start=1&end=30"
```

**Resposta (200):**
```json
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

## Números Perfeitos Conhecidos

Um número perfeito é um inteiro positivo que é igual à soma de seus divisores próprios (excluindo ele mesmo).

Exemplos:
- **6** = 1 + 2 + 3
- **28** = 1 + 2 + 4 + 7 + 14
- **496** = 1 + 2 + 4 + 8 + 16 + 31 + 62 + 124 + 248
- **8128** = soma de seus divisores próprios

## 🧪 Testes

### Executar todos os testes

```bash
dart test
```

### Executar com cobertura

```bash
dart pub global activate coverage
dart run coverage:test_with_coverage
```

### Testes inclusos

O projeto inclui testes unitários para:

1. **PerfectNumberRepositoryImpl**
   - Validação de números perfeitos conhecidos (6, 28, 496)
   - Validação de números não-perfeitos
   - Casos extremos (0, 1, negativos)
   - Busca em diferentes ranges

2. **PerfectNumberController**
   - Mock do repositório com Mockito
   - Validação de respostas corretas
   - Tratamento de erros
   - Verificação de chamadas ao repositório

## Arquitetura

O projeto segue os princípios de **Clean Architecture**:

### Domain Layer (Camada de Domínio)
- Contém as entidades e interfaces dos repositórios
- Independente de frameworks e tecnologias
- Define o contrato para a lógica de negócio

### Infrastructure Layer (Camada de Infraestrutura)
- Implementação dos repositórios
- Contém a lógica de cálculo de números perfeitos
- Gerencia dados e operações de negócio

### API Layer (Camada de Apresentação)
- Controllers REST
- Mapeia requisições HTTP para operações de domínio
- Retorna dados em formato JSON

### Configuration Layer
- Setup de dependências
- Configuração de segurança
- Configuração de OpenAPI/Swagger

## 🔧 Dependências Principais

- **vaden**: Framework Web para Dart
- **vaden_security**: Segurança e autenticação
- **result_dart**: Tratamento de erros tipado (Result<Success, Failure>)
- **build_runner**: Geração de código
- **mockito**: Mock objects para testes
- **test**: Framework de testes para Dart

## Documentação OpenAPI

O servidor gera documentação OpenAPI automaticamente. Acesse:

```
http://localhost:8080/docs
```

ou

```
http://localhost:8080/openapi.json
```

## Desenvolvimento

### Adicionar uma nova dependência

```bash
dart pub add package_name
```

### Regenerar código gerado

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Formato de código

```bash
dart format lib test
```

### Análise estática

```bash
dart analyze
```

## Boas Práticas de Desenvolvimento

1. **Sempre usar o padrão Result<Success, Failure>** para operações que podem falhar
2. **Manter a separação de responsabilidades** entre as camadas
3. **Escrever testes** para novas funcionalidades
4. **Documentar comportamentos** específicos com comentários
5. **Usar DTOs e Entities** apropriadamente

## Suporte e Contribuição

Para reportar bugs ou sugerir melhorias, abra uma issue no repositório.

## Licença

Este projeto é parte do Pita Perfect Number.

## Autor

Desenvolvido como parte do projeto Pita Perfect Number.

---

**Última atualização:** Março de 2026
