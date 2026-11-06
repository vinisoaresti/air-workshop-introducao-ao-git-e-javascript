#!/usr/bin/env bash
# Confere os testes contra os arquivos exe-* e sol-* de exercicios/e2 e exercicios/e3, numa cópia temporária.
REPO=$(cd "$(dirname "$0")/../.." && pwd)
E2=exercicios/e2
E3=exercicios/e3
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
tar -C "$REPO" --exclude=.git -cf - . | tar -C "$T" -xf -
cd "$T" || exit 1
rm -f $E2/0[12]-*.js $E3/saudacao.mjs $E3/localizacao.mjs $E3/saudacao-localizacao.mjs
contar() { npm test 2>&1 | grep -E "^# (pass|fail|skipped) " | tr '\n' ' '; echo; }
echo "== vazio (esperado: só skipped)"; contar
echo "== exe-2 (esperado: fail)"; cp $E2/exe-2-saudacao.js $E2/01-saudacao.js; cp $E2/exe-2-minha-localizacao.js $E2/02-minha-localizacao.js; contar
echo "== sol-2 (esperado: pass 2)"; cp $E2/sol-2-saudacao.js $E2/01-saudacao.js; cp $E2/sol-2-minha-localizacao.js $E2/02-minha-localizacao.js; contar
echo "== exe-3 (esperado: fail)"; mv $E2/01-saudacao.js $E3/saudacao.mjs; mv $E2/02-minha-localizacao.js $E3/localizacao.mjs; cp $E3/sol-3-saudacao.mjs $E3/saudacao.mjs; cp $E3/sol-3-localizacao.mjs $E3/localizacao.mjs; cp $E3/exe-3-saudacao-localizacao.mjs $E3/saudacao-localizacao.mjs; contar
echo "== sol-3 (esperado: pass 4)"; cp $E3/sol-3-saudacao-localizacao.mjs $E3/saudacao-localizacao.mjs; contar
echo "== js antigo presente (esperado: fail 1)"; cp $E2/sol-2-saudacao.js $E2/01-saudacao.js; contar
echo "== saudação alterada no E4 (esperado: pass 4)"; rm $E2/01-saudacao.js; sed -i 's/Olá/Oi/' $E3/saudacao.mjs; contar
