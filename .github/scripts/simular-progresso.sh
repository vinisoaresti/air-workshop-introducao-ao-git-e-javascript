#!/usr/bin/env bash
# Simula o fluxo E2..E6 com um remoto local e roda progresso.mjs em --dry-run a cada etapa.
set -euo pipefail
REPO=$(cd "$(dirname "$0")/../.." && pwd)
E2=exercicios/e2
E3=exercicios/e3
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
export GIT_AUTHOR_NAME=Aluno GIT_AUTHOR_EMAIL=aluno@exemplo.com GIT_COMMITTER_NAME=Aluno GIT_COMMITTER_EMAIL=aluno@exemplo.com
export GIT_CONFIG_GLOBAL=/dev/null
G() { git -c init.defaultBranch=main -c pull.rebase=false -c advice.detachedHead=false "$@"; }

G init -q --bare "$T/origin.git"
G clone -q "$T/origin.git" "$T/aluno" 2>/dev/null
# Sem o .git do repositório: a simulação nunca pode apontar para o remoto real.
tar -C "$REPO" --exclude=.git -cf - . | tar -C "$T/aluno" -xf -
cd "$T/aluno"
[[ $(git remote get-url origin) == "$T/origin.git" ]] || { echo "origin inesperado; abortando" >&2; exit 1; }
rm -f $E2/0[12]-*.js $E3/saudacao.mjs $E3/localizacao.mjs $E3/saudacao-localizacao.mjs
G add -A && G commit -qm "Initial commit" && G push -q origin main
G clone -q "$T/origin.git" "$T/colega"

FIX=$T/fixtures.json
corpo_issue() { # $1 = ids já validados (ex.: "E2,E3"), $2 = reviews do PR em JSON, $3 = comentários extras em JSON
  node -e '
const [ids, reviews, extras] = process.argv.slice(1);
const comentarios = [{ user: { login: "github-actions[bot]" }, body: `<!-- progresso: ${ids} -->\nanterior` }, ...JSON.parse(extras)];
console.log(JSON.stringify({
  "GET /issues?labels=progresso&state=all&per_page=100": [{ number: 1, body: "<!-- progresso-workshop -->" }],
  "GET /issues/1/comments?per_page=100&page=1": comentarios,
  "GET /pulls/7/reviews?per_page=100": JSON.parse(reviews),
}))' "$1" "${2:-[]}" "${3:-[]}" > "$FIX"
}
# Comentário impresso pela última execução, como se a Actions o tivesse publicado.
ultimo_comentario() {
  sed -n 's/^> //p' "$T/saida" | node -e 'console.log(JSON.stringify([{ user: { login: "github-actions[bot]" }, body: require("fs").readFileSync(0, "utf8").replace(/\n$/, "") }]))'
}
rodar() { # $1 = título, $2 = evento, $3 = payload JSON
  echo "### $1"
  printf '%s' "$3" > "$T/evento.json"
  GITHUB_EVENT_NAME=$2 GITHUB_EVENT_PATH=$T/evento.json GITHUB_REF_NAME=$(git branch --show-current) GITHUB_REF_TYPE=branch \
    DRY_RUN_FIXTURES=$FIX node .github/scripts/progresso.mjs --dry-run > "$T/saida"
  grep -E '^(\| E[1-6] |Comentário|> \*\*(Validado|Próximo|Workshop))' "$T/saida"
}
PUSH='{"repository":{"default_branch":"main"}}'

corpo_issue ""
rodar "push na main (nada a verificar)" push "$PUSH"

G switch -qc feature/saudacao-localizacao
cp $E2/exe-2-saudacao.js $E2/01-saudacao.js && G add $E2 && G commit -qm "adiciona esqueleto da saudacao"
cp $E2/exe-2-minha-localizacao.js $E2/02-minha-localizacao.js && G add $E2 && G commit -qm "adiciona esqueleto da localizacao"
G push -qu origin feature/saudacao-localizacao 2>/dev/null
corpo_issue "" "[]" '[{"user":{"login":"aluno"},"body":"<!-- progresso: E2,E3,E4,E5,E6 -->"}]'
rodar "E2 negativo: só os esqueletos (exe-2); comentário do aluno com marcador é ignorado" push "$PUSH"
corpo_issue "" "[]" "$(ultimo_comentario)"
rodar "Repetição sem mudança: não comenta" push "$PUSH"
corpo_issue ""

cp $E2/sol-2-saudacao.js $E2/01-saudacao.js && G commit -qam "implementa saudacao com nome"
cp $E2/sol-2-minha-localizacao.js $E2/02-minha-localizacao.js && G commit -qam "implementa distancia e mover"
G push -q 2>/dev/null
rodar "E2 concluído" push "$PUSH"

G mv $E2/01-saudacao.js $E3/saudacao.mjs
G mv $E2/02-minha-localizacao.js $E3/localizacao.mjs
cp $E3/sol-3-saudacao.mjs $E3/saudacao.mjs && cp $E3/sol-3-localizacao.mjs $E3/localizacao.mjs
cp $E3/exe-3-saudacao-localizacao.mjs $E3/saudacao-localizacao.mjs
G add $E3 && G commit -qm "migra para esm"
G push -q 2>/dev/null
corpo_issue "E2"
rodar "E3 negativo: esqueleto exe-3" push "$PUSH"

cp $E3/sol-3-saudacao-localizacao.mjs $E3/saudacao-localizacao.mjs && G commit -qam "implementa saudacao com localizacao"
G push -q 2>/dev/null
rodar "E3 concluído" push "$PUSH"
rodar "workflow_dispatch na branch verifica E2 a E5" workflow_dispatch "$PUSH"

(cd "$T/colega" && G fetch -q && G switch -q feature/saudacao-localizacao && sed -i 's/Olá/Oi/' $E3/saudacao.mjs && G commit -qam "muda saudacao (web)" && G push -q 2>/dev/null)
sed -i 's/Olá/Bem-vindo/' $E3/saudacao.mjs && G commit -qam "muda saudacao (local)"
G pull -q 2>/dev/null || true
G add $E3 && G commit -qm "merge com conflito nao resolvido" --no-edit
corpo_issue "E2,E3"
rodar "E4 negativo: marcadores esquecidos" push "$PUSH"

G show HEAD^2:$E3/saudacao.mjs > $E3/saudacao.mjs && G commit -qam "resolve conflito"
G push -q 2>/dev/null
rodar "E4 concluído" push "$PUSH"

(cd "$T/colega" && G switch -q main && G pull -q && echo "Editado pela web" >> README.md && G commit -qam "docs: atualiza readme" && G push -q 2>/dev/null)
G fetch -q
G reset -q --soft main && G commit -qm "adiciona saudacao com localizacao"
G rebase -q origin/main
corpo_issue "E2,E3,E4"
rodar "E5 negativo: commit fora do padrão (E4 continua concluído após rebase)" push "$PUSH"

G commit -q --amend -m "feat(exercicios): adiciona saudacao com localizacao"
rodar "E5 concluído" push "$PUSH"
echo "npm test: $(npm test --silent 2>&1 | grep -E '^# (pass|fail) ' | tr '\n' ' ')"

PR='{"repository":{"default_branch":"main"},"action":"closed","pull_request":{"number":7,"title":"feat(exercicios): adiciona saudacao com localizacao","merged":true,"base":{"ref":"main"},"head":{"ref":"feature/saudacao-localizacao"},"user":{"login":"aluno"}}}'
corpo_issue "E2,E3,E4,E5" '[]'
rodar "E6 negativo: merge sem aprovação" pull_request "$PR"
corpo_issue "E2,E3,E4,E5" '[{"state":"APPROVED","user":{"login":"aluno"}}]'
rodar "E6 negativo: aprovação do próprio autor" pull_request "$PR"
corpo_issue "E2,E3,E4,E5" '[{"state":"APPROVED","user":{"login":"dupla"}}]'
rodar "E6 concluído" pull_request "$PR"
