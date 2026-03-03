# Calculadora de Números Perfeitos

Olá, amigos.

Segue minha visão sobre o problema proposto.

Embora números perfeitos pareçam simples no enunciado, trata-se de um desafio matemático considerável quando levado para o contexto computacional. Apesar de já conhecermos mais de 50 números perfeitos, calculá-los, especialmente encontrar novos, envolve operações com números extremamente grandes, o que pode demandar alto poder de processamento e tempo significativo de execução. Em um ambiente digital, principalmente mobile, isso se tornar uma armadilha de performance.

Diante disso, optei por seguir uma abordagem mais segura e pragmática. Considerei que o cálculo para validação e geração de números perfeitos pode ser oneroso para um dispositivo móvel, mesmo sendo um aparelho de alto desempenho. Além disso, qualquer evolução ou melhoria no algoritmo exigiria atualização do aplicativo, passando pelo processo de publicação nas lojas da Google e da Apple.

Por esse motivo, decidi implementar um serviço responsável pelos cálculos no backend. Essa estratégia permite utilizar o maior poder computacional de um servidor e possibilita atualizações imediatas do algoritmo, sem depender de novas versões do aplicativo. Também considerei essa abordagem interessante por se tratar de um desafio com proposta FullStack.

Para o backend, escolhi trabalhar com o framework Vaden. Apesar de ser uma tecnologia mais recente e ainda pouco comum no mercado, enxerguei como uma ótima oportunidade para estudá-la e validá-la em um cenário real. Ainda assim, tenho plena capacidade de reproduzir essa mesma API utilizando frameworks mais consolidados como Spring Boot ou Django, caso necessário.

No aplicativo Flutter, busquei seguir as recomendações oficiais de arquitetura sugeridas pela equipe do Flutter. Optei por uma implementação reativa sem utilizar bibliotecas de gerenciamento de estado mais complexas, mantendo uma solução enxuta com Provider, Auto Injector, Go Router e Dio. Essa combinação me permitiu manter um controle claro das camadas da aplicação, organizando contratos entre ViewModels, Repositories e Services, e utilizando a própria árvore de widgets do Flutter para sustentar a reatividade da aplicação.

Em relação à interface, utilizei ferramentas de IA para auxiliar na geração de ideias visuais, sempre ajustando o resultado para manter coerência com boas práticas de usabilidade e organização de layout.

Quanto ao tratamento dos números perfeitos, mantive uma abordagem conservadora no aplicativo, limitando o processamento ao intervalo suportado por inteiros. Embora a API não possua limitação explícita além do tamanho do número e do tempo de processamento necessário para encontrá-lo, implementei no app um mecanismo de fallback com uma lista local contendo os primeiros números perfeitos. Dessa forma, em caso de falha de comunicação ou latência elevada da API, o aplicativo consulta essa lista local para garantir resposta rápida e melhor experiência ao usuário.

Em relação aos testes, vale observar que o servidor ainda não está configurado para publicação externa, portanto a URL base está apontando para localhost. Dependendo do ambiente utilizado para avaliação, isso pode exigir configuração adicional. Em especial, no Android Emulator é necessário ajustar corretamente o mapeamento de rede (por exemplo, utilizando o IP específico do host), enquanto no simulador iOS o funcionamento tende a ocorrer sem necessidade de ajustes adicionais.

No mais, fico totalmente à disposição para conversar sobre as decisões técnicas adotadas, possíveis melhorias, alternativas arquiteturais e demais soluções que possamos explorar para este problema ou outros desafios da Rock.

Grato pela atenção.

Epitácio Soares
