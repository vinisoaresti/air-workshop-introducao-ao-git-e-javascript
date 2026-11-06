# air-workshop-introducao-ao-git-e-javascript

Workshop prático de introdução ao Git, usando pequenos exemplos em JavaScript como material para versionar. Você vai do `git init` até um Pull Request aprovado, com uma Actions acompanhando o seu progresso.

## Pré-requisitos

- Git 2.23 ou mais recente (`git --version`)
- Node.js 22 LTS ou mais recente (`node -v`)
- VS code ou Linha de Comando com suporte a terminal Bash (Git Bash ou Linux nativo)
- Conta no GitHub com autenticação HTTPS (token) ou SSH configurada

## Como começar

1. Faça o **E1** em um repositório local, fora deste: [exercicios/exercicios.md](exercicios/exercicios.md#e1-primeiros-comandos-em-um-repositório-local).
2. Clique em **Use this template** > **Create a new repository** e crie o seu repositório.
3. No seu repositório, em **Settings** > **Collaborators**, adicione a sua dupla.
4. Na aba **Actions**, abra **Progresso do workshop** e clique em **Run workflow**. A Issue **Progresso do workshop** é criada.
5. Clone o seu repositório e siga os exercícios **E2 a E6**.

## Estrutura

| Caminho | Conteúdo |
|---|---|
| [exercicios/exercicios.md](exercicios/exercicios.md) | Exercícios E1 a E6 e bônus |
| [slides/slides.md](slides/slides.md) | Slides (Marp) |
| `exercicios/` | Uma pasta por exercício, com o esqueleto (`exe-*`) e a solução (`sol-*`); é nela que você cria e versiona os arquivos |
| `tests/` | Testes usados por `npm test` e pela Actions |
| `.github/` | Automação de progresso |

## Progresso

A cada `push`, Pull Request e review, a Actions **Progresso do workshop** confere os exercícios E2 a E6 e comenta na Issue o que foi validado e o próximo passo. O resumo completo fica em **Actions** > execução > **Summary**. O E1 é local e não é verificado.
