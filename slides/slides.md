---
marp: true
theme: default
paginate: true
lang: pt-BR
title: Introdução ao Git (com JavaScript)
---

<!-- _class: lead -->

# Introdução ao Git 🧭 🌱

### com uma pitada de JavaScript

`air-workshop-introducao-ao-git-e-javascript`

---

## Equipe de Instrução 🤓🤓

---

### Oi, eu sou o Osman! 👋😁

- Desenvolvedor Sr na AIR/Compass 💻
- 6 anos de carreira em tech, 2 anos nessa casa 👣
- Coisas que amo:
  - clima friozim ❄️
  - atividade física 🏋️
  - boas comidas e boas conversas 🍔😋
  - mundos de fantasia 🧙‍♂️
- Linkedin: https://www.linkedin.com/in/osman-rodrigues/
  
---

### Oi, eu sou o Tales! 👋😁

- Desenvolvedor Mid na AIR/Compass 💻
- 5 anos de carreira em tech, alguns meses nessa casa 👣
- Trabalhei em instituições financeiras e em empresas do ramo logístico 👔
- Coisas que amo:
  - Música 🎶
  - Livros 📚
  - Filmes 🎥
  - Harry Potter 🪄⚡
  - Atividade física 🏋️
Linkedin: https://br.linkedin.com/in/tales-dias-de-aguiar-274b56233

---

## Objetivo de hoje 🎯 🤝

Sair daqui com um **Pull Request aprovado** no seu próprio repositório.

```text
git init → commit → clone → branch → push → conflito → rebase → Pull Request
```

Checagem rápida:

```bash
git --version   # 2.23 ou mais recente
node -v         # 22 ou mais recente
```

---

<!-- _class: lead -->

# 1. História e funcionamento do Git 📜 ⚙️

---

<!-- _footer: 'Fontes: [README do Git](https://github.com/git/git/blob/master/README.md) · [About](https://git-scm.com/about) · [gitglossary](https://git-scm.com/docs/gitglossary) · [Pro Git, 1.2](https://git-scm.com/book/pt-br/v2/Primeiros-Passos-Uma-Breve-Hist%c3%b3ria-do-Git) · [Torvalds, 2005](https://marc.info/?l=git&m=112243466603239)' -->

## Git em 4 perguntas 💡 🐧

- **O que é:** um sistema de controle de versão **distribuído**, rápido e escalável.
- **Por que:** o kernel Linux perdeu o uso gratuito do **BitKeeper** e precisava de uma ferramenta rápida e distribuída.
- **Como:** **Linus Torvalds** o desenhou como um sistema de arquivos em que tudo é identificado por um hash do conteúdo: velocidade e integridade.
- **Quando:** abril de 2005. Em julho, **Junio Hamano** assumiu a manutenção.

---

<!-- _footer: 'Fontes: [README do Git](https://github.com/git/git/blob/master/README.md) · [Pro Git, 1.1](https://git-scm.com/book/pt-br/v2/Primeiros-Passos-Sobre-Controle-de-Vers%c3%a3o) · [Pro Git, 1.3](https://git-scm.com/book/pt-br/v2/Primeiros-Passos-O-que-%c3%a9-Git%3F)' -->

## Centralizado vs. distribuído 🖥️ 🌐

```text
 Centralizado (CVS, SVN)            Distribuído (Git)

        [servidor]                [remoto]   [remoto]
       /    |     \                   \       /
     dev   dev    dev            [clone]---[clone]
  (só a cópia atual)            (histórico completo em cada um)
```

Com o Git você faz commit, consulta o histórico e cria branches **sem rede**.

---

<!-- _footer: 'Fontes: [gitdatamodel](https://git-scm.com/docs/gitdatamodel) · [gitglossary](https://git-scm.com/docs/gitglossary)' -->

## Fotos, não diferenças 📸 🧩

Cada commit guarda uma **foto** do projeto e aponta para o commit anterior.

```text
 a1b2c3 ←── d4e5f6 ←── 9f8e7d
                          ↑
                         main ←── HEAD
```

- O identificador (`9f8e7d...`) é um hash criptográfico do conteúdo (SHA-1 por padrão).
- **Branch** é só um ponteiro para um commit.
- **HEAD** aponta para onde você está.

---

<!-- _footer: 'Fontes: [gitdatamodel, THE INDEX](https://git-scm.com/docs/gitdatamodel#index) · [gitglossary](https://git-scm.com/docs/gitglossary)' -->

## As três áreas 📂 📦

```text
 diretório de trabalho ──git add──▶ staging ──git commit──▶ repositório (.git)
        ▲                                                         │
        └──────────────────── git switch / git restore ───────────┘
```

`git status` diz em qual área cada arquivo está.

---

<!-- _class: lead -->

# 2. Repositório local 💻 🏠

### E1: `git config` `git init`, `status`, `add`, `commit`, `log`

---

## E1: identidade e sandbox ⌨️ 🧰

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu-email@exemplo.com"
git config --global init.defaultBranch main
git config --global pull.rebase false

mkdir ~/git-sandbox && cd ~/git-sandbox
git init
git status
```

Rode `git status` depois de cada passo: ele mostra em que área está cada arquivo.

---

## E1: commit e `git diff` de um arquivo de texto ⌨️ ✅

```bash
echo "Olá, Git!" > arquivo.txt
git add arquivo.txt
git commit -m "adiciona arquivo de texto"
git log

echo "Segunda linha" >> arquivo.txt   # acrescenta uma linha
git diff                              # +Segunda linha
git commit -am "atualiza arquivo de texto"
git log --oneline
```

O Git compara texto linha a linha: o `git diff` mostra o que entrou (`+`) e o que saiu (`-`).
O E1 é local: a Actions não o verifica.

---

<!-- _class: lead -->

# 3. Repositório remoto ☁️ 🔗

---

## Do template ao clone 🧰 📥

1. **Use this template** > crie o repositório na sua conta.
2. **Settings** > **Collaborators**: adicione a sua dupla e aceite o convite que ela enviar.
3. **Actions** > **Progresso do workshop** > **Run workflow**. Para validar de novo sem push, execute escolhendo a sua branch.
4. Clone:

```bash
git clone <URL-do-seu-repositorio>
cd <nome-do-seu-repositorio>
git remote -v   # origin = apelido do remoto
```

A cada push e PR, a Actions comenta na Issue **Progresso do workshop** o que foi validado e o próximo passo.

---

<!-- _class: lead -->

# 4. História e funcionamento do JavaScript 📜 ⚙️

---

<!-- _footer: 'Fontes: [ECMA-262](https://ecma-international.org/publications-and-standards/standards/ecma-262/) · [ES2015](https://262.ecma-international.org/6.0/) · [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript) · [Netscape, 1995](https://web.archive.org/web/20070916144913/http://wp.netscape.com/newsref/pr/newsrelease67.html) · [Wirfs-Brock e Eich, 2020](https://doi.org/10.1145/3386327) · [Node.js](https://github.com/nodejs/node/blob/main/doc/changelogs/CHANGELOG_ARCHIVE.md)' -->

## JavaScript em 4 perguntas 🟨 💡

- **O que é:** uma linguagem leve, interpretada ou compilada na hora (JIT), padronizada como **ECMAScript**. Apesar do nome, não é Java.
- **Por que:** a Netscape queria uma linguagem de script para as páginas, que "parecesse Java" e complementasse o Java no navegador.
- **Como:** **Brendan Eich** criou o protótipo **Mocha** em 10 dias, em maio de 1995. Virou **LiveScript** e, em dezembro, **JavaScript**.
- **Quando:** 1995. Marcos: **1997** ECMAScript · **2009** Node.js · **2015** ES2015, com `let`/`const`, arrow functions, classes e **módulos**.

---

<!-- _footer: 'Fontes: [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript) · [V8](https://v8.dev/) · [MDN, tipos](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript/Guide/Data_structures) · [MDN, modelo de execução](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Execution_model) · [Node.js](https://nodejs.org/en/learn/getting-started/introduction-to-nodejs)' -->

## Como o JavaScript funciona ⚙️ 🧠

- Interpretado, com compilação **JIT** no motor (ex.: **V8**, do Chrome e do Node.js).
- **Tipagem dinâmica**: o tipo é do valor, não da variável.
- **Uma thread** com **event loop**: E/S assíncrona não bloqueia, mas código longo bloqueia.

```js
const minhaLocalizacao = { x: 3, y: 4 };
let nome = "Ana";

function saudar(nome = "mundo") {
  return `Olá, ${nome}!`;
}

const dobro = (n) => n * 2;
```

---

## E2: branch e saudação 🌿 ✍️

```bash
git switch -c feature/saudacao-localizacao
cd exercicios/e2
cp exe-2-saudacao.js 01-saudacao.js   # antes
node 01-saudacao.js                   # Olá! / Olá!
git status
git add 01-saudacao.js
git commit -m "adiciona esqueleto da saudacao"
cp sol-2-saudacao.js 01-saudacao.js   # depois
git diff
node 01-saudacao.js                   # Olá, mundo! / Olá, Ana!
git commit -am "implementa saudacao com nome"
```

---

## E2: localização e `push` 🌿 🚀

```bash
cp exe-2-minha-localizacao.js 02-minha-localizacao.js
node 02-minha-localizacao.js
npm test                              # falha: distancia e mover
git add 02-minha-localizacao.js
git commit -m "adiciona esqueleto da localizacao"
cp sol-2-minha-localizacao.js 02-minha-localizacao.js
git diff
node 02-minha-localizacao.js         # distância 5, ponto movido para (4, 3)
npm test                              # passa
git commit -am "implementa distancia e mover"
git log --oneline
git push -u origin feature/saudacao-localizacao
```

**A Actions confere:** `01-saudacao.js` e `02-minha-localizacao.js` existem e `tests/e2-commonjs.test.mjs` passa. Veja o comentário na Issue.

---

<!-- _class: lead -->

# 5. Módulos ESM 📦 🔀

---

## CommonJS vs. ES Modules ⚖️ 🧩

| CommonJS (histórico do Node) | ESM (padrão da linguagem) |
|---|---|
| `const { saudar } = require("./saudacao.js")` | `import { saudar } from "./saudacao.mjs"` |
| `module.exports = { saudar }` | `export function saudar() {}` |
| carregamento síncrono | carregamento assíncrono, análise estática |

No ESM o `import` precisa da extensão do arquivo, e `.mjs` força o modo ESM.

---

## E3: `git mv` e conversão 📦 🔀

```bash
cd ../e3
git mv ../e2/01-saudacao.js saudacao.mjs
git mv ../e2/02-minha-localizacao.js localizacao.mjs
git status                          # renamed: ...
cp sol-3-saudacao.mjs saudacao.mjs
cp sol-3-localizacao.mjs localizacao.mjs
git diff                            # module.exports vira export
```

---

## E3: módulo combinado e `push` 📦 🚀

```bash
cp exe-3-saudacao-localizacao.mjs saudacao-localizacao.mjs
node saudacao-localizacao.mjs       # linha vazia
npm test                            # falha
cp sol-3-saudacao-localizacao.mjs saudacao-localizacao.mjs
node saudacao-localizacao.mjs
npm test
git add .
git commit -m "migra exercicios para esm"
git push
```

Saída esperada: `Olá, Ana! Você está em (3, 4), a 5 unidades da origem.`
**A Actions confere:** os 3 `.mjs` existem em `exercicios/e3/`, os `.js` do E2 saíram e `tests/e3-esm.test.mjs` passa.

---

<!-- _class: lead -->

# 6. Pull, push e conflito 🔄 ⚔️

---

## `git pull` = `git fetch` + `git merge` ⬇️ 🔀

```text
<<<<<<< HEAD
  return `Bem-vindo, ${nome}!`;      ← sua versão
=======
  return `Oi, ${nome}!`;             ← versão do remoto
>>>>>>> 3c4d5e6...
```

1. Escolha o texto final.
2. Apague **todos** os marcadores.
3. `git add` + `git commit` + `git push`.

Conflito não é erro: é o Git pedindo uma decisão.

---

## E4 passo a passo ⚔️ ✅

1. No GitHub, **na branch `feature/saudacao-localizacao`**, edite `exercicios/e3/saudacao.mjs`: troque `Olá` por `Oi` e faça o commit pela web.
2. Localmente, **sem `git pull`**, troque `Olá` por `Bem-vindo` na mesma linha:

```bash
git commit -am "muda saudacao"
git push                     # rejeitado: o remoto tem um commit novo
git pull                     # CONFLICT (content): resolva e apague os marcadores
npm test
git add saudacao.mjs
git commit
git push
git log --oneline --graph
```

**A Actions confere:** há um commit de merge na branch e nenhum marcador de conflito.

---

<!-- _class: lead -->

# 7. Rebase, reset e Conventional Commits 🧹 📝

---

## Merge vs. rebase 🔀 📏

```text
 merge:                          rebase:
 A──B──C──────M  feature         A──B──E──C'──D'  feature
     \       /                   (C e D reaplicados sobre E:
      E─────┘    main             histórico linear, novos hashes)
```

**Regra de ouro:** não reescreva commits que outras pessoas já usam.
Por isso `git push --force-with-lease`, e não `--force`.

---

## `git reset` ↩️ 🛟

| Modo | HEAD | Staging | Arquivos |
|---|---|---|---|
| `--soft` | move | mantém | mantém |
| `--mixed` (padrão) | move | limpa | mantém |
| `--hard` | move | limpa | **descarta** |

Rede de segurança: `git reflog` lista todas as posições anteriores do `HEAD`.

---

## Conventional Commits 🏷️ 📦

```text
tipo(escopo): descrição

feat(exercicios): adiciona saudacao com localizacao
fix(localizacao): corrige calculo da distancia
docs: atualiza readme
feat(api)!: remove endpoint antigo     ← mudança incompatível
```

Tipos comuns: `feat`, `fix`, `docs`, `refactor`, `test`, `ci`, `chore`.
Permite gerar **changelog** e **versão** (SemVer) automaticamente.

---

## E5 passo a passo 🛠️ ✅

1. No GitHub, **na branch `main`**, edite o `README.md` e faça o commit pela web.
2. Localmente:

Mantenha a `main` local no ponto em que a branch começou: o `reset --soft main` usa esse ponto como base. As novidades remotas entram no rebase.

```bash
git fetch
git log --oneline --graph --all
git reset --soft main            # junta seus commits no staging
git status
git commit -m "feat(exercicios): adiciona saudacao com localizacao"
git rebase origin/main           # reaplica sobre a main atualizada
npm test
git push --force-with-lease
```

**A Actions confere:** E4 concluído, nenhum merge, commits `tipo(escopo): descrição` e a branch contém `origin/main`.

---

<!-- _class: lead -->

# 8. Pull Request, Gitflow e CI/CD 🔍 🚀

---

## E6: Pull Request 🤝 ✅

1. Abra o PR `feature/saudacao-localizacao` → `main`, com título Conventional.
2. Peça o review da dupla.
3. Aprove o PR da dupla.
4. Com aprovação, **Merge pull request**.
5. Atualize o clone local:

```bash
git switch main
git pull
git log --oneline --graph
```

O GitHub não deixa o autor aprovar o próprio PR.
**A Actions confere:** PR mergeado na `main` com aprovação de outra pessoa. A Issue é fechada.

---

## Gitflow vs. trunk-based 🌳 🛣️

```text
 Gitflow
 main     ──●────────────────●──────────●──      (versões publicadas)
 hotfix/*    \              / \        /
 release/*    \        ●───●   ●──────●
 develop  ─────●──●──●───────────●──
 feature/*      \__/ \__/
```

**Trunk-based:** branches curtas, integradas na `main` várias vezes ao dia. Comum com CI/CD maduro.

---

## CI/CD: a Actions deste workshop ⚙️ 🤖

```yaml
on: [push, pull_request, pull_request_review, workflow_dispatch]
permissions: { contents: read, issues: write }
jobs:
  progresso:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: node .github/scripts/progresso.mjs
```

Eventos do Git (push, PR, review) **disparam** pipelines versionados junto com o código.
Mesma ideia em outras forges: **Azure DevOps** (Azure Pipelines) e **GitLab** (GitLab CI).

---

<!-- _class: lead -->

# Encerramento 🎉 👋

---

## O que vimos 📚 ✅

`init` · `status` · `add` · `commit` · `log` · `diff` · `clone` · `switch` · `push` · `pull` · `merge` · `rebase` · `reset` · `reflog` · Pull Request

**Próximos passos:** rebase interativo, `cherry-pick`, `git bisect`, hooks, proteção de branch.

Obrigado!
