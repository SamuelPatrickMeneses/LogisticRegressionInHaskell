# Regressão Logística em Haskell

Este projeto é uma implementação do zero de **Regressão Logística** utilizando a linguagem de programação Haskell. Ele inclui suporte para funções de ativação Sigmóide e Softmax, permitindo a classificação de dados (como o dataset MNIST) com múltiplos outputs.

O projeto também conta com ferramentas de treinamento, avaliação de acurácia e um visualizador gráfico.

## 🚀 Como Começar

### Pré-requisitos

Você precisará do [Stack](https://docs.haskellstack.org/en/stable/README/) instalado em sua máquina.

### Instalação e Build

Para compilar o projeto e baixar as dependências:

```bash
stack build
```

## 🛠️ Executando o Projeto

O projeto está dividido em três componentes principais:

### 1. Treinamento
Para iniciar o processo de treinamento do modelo:

```bash
stack run LogisticRegressionInHaskell-exe
```
*O modelo lerá os dados de `./data/train.csv` e salvará os pesos resultantes em `./data/net.csv`.*

### 2. Verificação de Acurácia
Para testar a precisão do modelo treinado contra um conjunto de testes:

```bash
stack run persent
```
*Este comando exibe a porcentagem de acertos e anexa o resultado em `./data/historic.txt`.*

### 3. Visualizador
Para ver uma representação visual do processo ou dos dados:

```bash
stack run visualiser
```

## 📂 Estrutura do Projeto

- **`library/`**: Contém a lógica central da rede neural (`LogisticRegrecion.hs`) e utilitários de entrada/saída (`LogisticRegrecion/IO.hs`).
- **`executable/`**: Ponto de entrada principal para o treinamento do modelo.
- **`check_persent/`**: Script para calcular a taxa de acerto (acurácia).
- **`visualiser/`**: Interface gráfica para visualização (utiliza a biblioteca `gloss`).
- **`data/`**: Pasta destinada aos arquivos `.csv` de treino, teste e persistência da rede.

## 📝 Avaliação Técnica

### Pontos Positivos
- **Implementação Funcional**: A implementação segue os princípios de programação funcional, facilitando a compreensão da matemática por trás da regressão.
- **Modularização**: O uso de `library` e múltiplos executáveis (`persent`, `visualiser`) demonstra uma boa organização de projeto Haskell.
- **Visualização**: A inclusão de um visualizador com `gloss` é um excelente diferencial para entender os resultados.

### Sugestões de Melhoria
- **Correções Ortográficas**: Existem diversos erros de digitação no código que podem dificultar a manutenção (ex: `Regrecion` em vez de `Regression`, `epohc` em vez de `epoch`, `predic` em vez de `predict`).
- **Performance**: Para datasets maiores, considere o uso de bibliotecas de álgebra linear otimizadas como `hmatrix`, evitando manipulação manual de listas para operações de matrizes.
- **Tratamento de Erros**: O código de IO assume que os arquivos sempre existem e estão no formato correto. Adicionar validação de dados tornaria o projeto mais robusto.

## 📦 Versões das Ferramentas e Dependências

Este projeto utiliza o resolver **Stackage LTS 21.25**. Abaixo estão as versões principais das ferramentas e bibliotecas utilizadas:

| Ferramenta / Biblioteca | Versão |
| :--- | :--- |
| **GHC (Compilador)** | 9.4.7 |
| **Stack** | Snapshot LTS 21.25 |
| `base` | 4.17.2.0 |
| `text` | 2.0.2 |
| `random` | 1.2.1.1 |
| `gloss` (Visualizador) | 1.13.2.2 |
| `criterion` (Benchmark) | 1.6.3.0 |
| `hspec` (Testes) | 2.10.10 |
| `tasty` (Testes) | 1.4.3 |

---
*Desenvolvido como um exercício de aprendizado em Haskell e Inteligência Artificial.*

