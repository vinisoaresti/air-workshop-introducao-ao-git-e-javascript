# Exercícios

Os exercícios usam dois repositórios:

- **E1:** um repositório local descartável (`git-sandbox`), sem relação com este.
- **E2 a E6:** o seu repositório criado a partir deste template, depois do `git clone`.

A Actions **Progresso do workshop** confere cada `push`, Pull Request e review e comenta na Issue **Progresso do workshop** do seu repositório o que foi validado e o próximo passo. O resumo de cada execução também fica na aba **Actions**, em **Summary**.

> Exercício validado continua valendo, mesmo que um passo seguinte reescreva o histórico. Se nada mudou desde o último comentário, a Actions não comenta de novo.

### Arquivos prontos para copiar

A pasta [`exercicios/`](../exercicios) tem uma subpasta por exercício (`e2/`, `e3/`), com o código em dois estados:

- `exe-N-*`: o **antes**, um esqueleto que roda mas ainda não faz tudo (os testes falham).
- `sol-N-*`: o **depois**, a solução completa (os testes passam).

O foco é o Git: dentro da pasta do exercício, copie o arquivo para o nome final, execute, veja o resultado e versione cada passo. Se quiser, implemente você mesmo a partir do `exe-*` em vez de copiar o `sol-*`.

---

## E1: primeiros comandos em um repositório local

**Objetivo:** praticar `git init`, `git status`, `git add`, `git commit` e `git log` sem se preocupar com código.

1. Configure sua identidade (uma vez por máquina):

   ```bash
   git config --global user.name "Seu Nome"
   git config --global user.email "seu-email@exemplo.com"
   git config --global init.defaultBranch main
   git config --global pull.rebase false
   ```

2. Crie o sandbox **fora** de qualquer outro repositório:

   ```bash
   mkdir ~/git-sandbox && cd ~/git-sandbox
   git init
   git status
   ```

3. Adicione um arquivo de texto simples:

   ```bash
   echo "Olá, Git!" > arquivo.txt
   git add arquivo.txt
   git commit -m "adiciona arquivo de texto"
   git log
   ```

4. Substitua o arquivo e compare:

   ```bash
   echo "Segunda linha" >> arquivo.txt   # acrescenta uma linha
   git diff                              # +Segunda linha
   git commit -am "atualiza arquivo de texto"
   git log --oneline
   ```

**Critério:** não é verificado pela Actions, porque o sandbox é local.

**Se travar:**
- `Author identity unknown`: refaça o passo 1.
- `fatal: not a git repository`: confira se está dentro de `~/git-sandbox`.

---

## Preparação do repositório remoto

1. Neste repositório, clique em **Use this template** > **Create a new repository**, na sua conta.
2. No repositório criado: **Settings** > **Collaborators** > **Add people** e adicione a sua dupla. Aceite o convite que você receber da dupla.
3. Aba **Actions** > **Progresso do workshop** > **Run workflow**. A Issue **Progresso do workshop** é criada. Depois, se quiser validar de novo sem fazer push, use **Run workflow** escolhendo a sua branch.
4. Clone o seu repositório:

   ```bash
   cd ~
   git clone <URL-do-seu-repositorio>
   cd <nome-do-seu-repositorio>
   ```

---

## E2: branch e primeiros arquivos JavaScript

**Objetivo:** criar uma branch, versionar o antes e o depois de cada arquivo em commits separados, comparar com `git diff` e enviar com `git push`.

1. Crie a branch de trabalho e entre na pasta do exercício:

   ```bash
   git switch -c feature/saudacao-localizacao
   cd exercicios/e2
   ```

2. Copie o esqueleto da saudação para o nome final, execute e faça o commit:

   ```bash
   cp exe-2-saudacao.js 01-saudacao.js
   node 01-saudacao.js                 # Olá! / Olá!  (ainda ignora o nome)
   git status
   git add 01-saudacao.js
   git commit -m "adiciona esqueleto da saudacao"
   ```

3. Aplique a solução, veja a diferença e faça o commit:

   ```bash
   cp sol-2-saudacao.js 01-saudacao.js
   git diff
   node 01-saudacao.js                 # Olá, mundo! / Olá, Ana!
   git commit -am "implementa saudacao com nome"
   ```

4. Repita com a localização. O esqueleto calcula a distância como `0` e não move o ponto:

   ```bash
   cp exe-2-minha-localizacao.js 02-minha-localizacao.js
   node 02-minha-localizacao.js
   npm test                            # falha: distancia e mover
   git add 02-minha-localizacao.js
   git commit -m "adiciona esqueleto da localizacao"

   cp sol-2-minha-localizacao.js 02-minha-localizacao.js
   git diff
   node 02-minha-localizacao.js        # distância 5, ponto movido para (4, 3)
   npm test                            # passa
   git commit -am "implementa distancia e mover"
   ```

   `distancia(a, b)` usa $\sqrt{(x_2-x_1)^2 + (y_2-y_1)^2}$ (`Math.hypot`); `mover` devolve um **novo** ponto, sem alterar o original.

5. Veja o histórico e envie:

   ```bash
   git log --oneline
   git push -u origin feature/saudacao-localizacao
   ```

**Critério da Actions:** `push` em uma branch que não é a `main`, `exercicios/e2/01-saudacao.js` e `exercicios/e2/02-minha-localizacao.js` existem e `tests/e2-commonjs.test.mjs` passa. Um push só com os esqueletos fica pendente.

**Se travar:**
- `npm test` mostra testes `skipped`: confira os nomes dos arquivos dentro de `exercicios/e2/`.
- `git commit -am` não pegou o arquivo: o `-a` só inclui arquivos já rastreados; arquivos novos precisam de `git add`.

---

## E3: módulos ESM

**Objetivo:** migrar de CommonJS (`require`/`module.exports`) para ES Modules (`import`/`export`), usando `git mv` para o Git registrar a renomeação.

1. Entre na pasta do E3 e traga os arquivos do E2, já com a extensão `.mjs`:

   ```bash
   cd ../e3
   git mv ../e2/01-saudacao.js saudacao.mjs
   git mv ../e2/02-minha-localizacao.js localizacao.mjs
   git status                          # renamed: ...
   ```

2. Converta os dois arquivos para ESM copiando as soluções por cima, e veja o que mudou (`module.exports` vira `export`; o bloco `require.main` sai):

   ```bash
   cp sol-3-saudacao.mjs saudacao.mjs
   cp sol-3-localizacao.mjs localizacao.mjs
   git diff
   ```

3. Copie o esqueleto do módulo que combina os dois e execute:

   ```bash
   cp exe-3-saudacao-localizacao.mjs saudacao-localizacao.mjs
   node saudacao-localizacao.mjs       # linha vazia: ainda não importa nada
   npm test                            # falha
   ```

4. Aplique a solução e execute:

   ```bash
   cp sol-3-saudacao-localizacao.mjs saudacao-localizacao.mjs
   node saudacao-localizacao.mjs
   ```

   Resultado esperado:

   ```text
   Olá, Ana! Você está em (3, 4), a 5 unidades da origem.
   ```

5. Teste e envie:

   ```bash
   npm test
   git add .
   git status                          # renamed: ... e new file: ...
   git commit -m "migra exercicios para esm"
   git push
   ```

**Critério da Actions:** `saudacao.mjs`, `localizacao.mjs` e `saudacao-localizacao.mjs` existem em `exercicios/e3/`, os `.js` do E2 foram removidos e `tests/e3-esm.test.mjs` passa.

**Se travar:**
- `SyntaxError: Cannot use import statement outside a module`: a extensão precisa ser `.mjs`.
- `ERR_MODULE_NOT_FOUND`: no ESM o caminho do `import` precisa da extensão (`./saudacao.mjs`), e os arquivos `saudacao.mjs` e `localizacao.mjs` precisam estar na mesma pasta.

---

## E4: `pull`, `push` e conflito

**Objetivo:** simular um colega alterando a mesma linha que você e resolver o conflito.

1. No GitHub, abra `exercicios/e3/saudacao.mjs` **na branch `feature/saudacao-localizacao`**, clique no lápis e troque `Olá` por `Oi`. Faça o commit pela web.
2. Localmente, **sem fazer pull antes**, troque `Olá` por `Bem-vindo` na mesma linha e faça o commit:

   ```bash
   git commit -am "muda saudacao"
   git push
   ```

   O push é rejeitado: o remoto tem um commit que você não tem.

3. Traga as mudanças:

   ```bash
   git pull
   ```

   O Git avisa `CONFLICT (content)`. Abra o arquivo: as versões aparecem entre `<<<<<<<`, `=======` e `>>>>>>>`.

4. Escolha o texto final, apague **todos** os marcadores e conclua:

   ```bash
   npm test
   git add saudacao.mjs
   git commit
   git push
   git log --oneline --graph
   ```

**Critério da Actions:** existe um commit de merge na branch e nenhum arquivo de `exercicios/` tem marcadores de conflito.

**Se travar:**
- `git pull` pede para escolher entre merge e rebase: rode `git config --global pull.rebase false` e repita.
- O pull não deu conflito: você fez o pull antes do commit local. Repita com outra palavra.
- Quer desistir no meio do conflito: `git merge --abort`.

---

## E5: `rebase`, `reset` e Conventional Commits

**Objetivo:** reescrever o histórico da branch em um único commit no padrão [Conventional Commits](https://www.conventionalcommits.org/pt-br/) e atualizá-lo sobre a `main` mais recente.

1. No GitHub, na branch **`main`**, edite o `README.md` (qualquer linha) e faça o commit pela web. Isso simula outra pessoa avançando a `main`.
2. Traga as novidades sem alterar sua branch:

   ```bash
   git fetch
   git log --oneline --graph --all
   ```

3. Junte todos os seus commits em um só. A sua `main` local ainda aponta para onde a branch começou:

   ```bash
   git reset --soft main
   git status
   git commit -m "feat(exercicios): adiciona saudacao com localizacao"
   ```

4. Reaplique o commit sobre a `main` atualizada e envie:

   ```bash
   git rebase origin/main
   git log --oneline --graph
   npm test
   git push --force-with-lease
   ```

**Critério da Actions:** E4 concluído, nenhum commit de merge na branch, todos os commits no padrão `tipo(escopo): descrição` e a branch contém `origin/main`.

**Se travar:**
- Errou a mensagem: `git commit --amend -m "feat(exercicios): ..."` e `git push --force-with-lease` de novo.
- Perdeu algo: `git reflog` lista todas as posições anteriores do `HEAD`; `git reset --hard <hash>` volta para uma delas.
- Atualizou a `main` local sem querer: use `git reset --soft $(git merge-base HEAD origin/main)` no passo 3.

> **Regra de ouro:** só reescreva (rebase, reset, amend) commits que ninguém mais usa. Por isso o `--force-with-lease`, que recusa o push se o remoto mudou desde o seu último `fetch`.

---

## E6: Pull Request e review

**Objetivo:** abrir um Pull Request, receber o review da dupla e fazer o merge.

1. No GitHub, abra um Pull Request de `feature/saudacao-localizacao` para `main`, com título no padrão Conventional Commits (por exemplo, `feat(exercicios): adiciona saudacao com localizacao`).
2. Em **Reviewers**, peça o review da sua dupla.
3. Faça o review do PR da sua dupla: aba **Files changed** > **Review changes** > **Approve**.
4. Com o seu PR aprovado, clique em **Merge pull request**.
5. Atualize o clone local:

   ```bash
   git switch main
   git pull
   git log --oneline --graph
   ```

**Critério da Actions:** o PR foi mergeado na `main` com pelo menos uma aprovação de outra pessoa. A Issue é fechada como concluída.

**Se travar:**
- Não dá para aprovar o próprio PR: o GitHub não permite; a aprovação precisa vir da dupla.
- A dupla não aparece em **Reviewers**: o convite de colaborador ainda não foi aceito.
- Fez o merge sem aprovação: crie uma nova branch a partir da `main` atualizada, faça uma pequena alteração com commit no padrão Conventional Commits e abra outro PR.

---

## Bônus

- `git stash` e `git stash pop`: guarde uma alteração pela metade, troque de branch e volte.
- `git commit --amend`: corrija a mensagem do último commit ainda não enviado.
- `git log --oneline --graph --all`: visualize todas as branches.
