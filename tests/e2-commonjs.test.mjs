import { test } from "node:test";
import assert from "node:assert/strict";
import { existsSync } from "node:fs";
import { createRequire } from "node:module";
import { fileURLToPath } from "node:url";

const require = createRequire(import.meta.url);
const caminho = (nome) =>
  fileURLToPath(new URL(`../exercicios/e2/${nome}`, import.meta.url));

const SAUDACAO = caminho("01-saudacao.js");
const LOCALIZACAO = caminho("02-minha-localizacao.js");

test(
  "E2: saudar()",
  { skip: !existsSync(SAUDACAO) && "exercicios/e2/01-saudacao.js ainda não existe" },
  () => {
    const { saudar } = require(SAUDACAO);
    assert.equal(
      typeof saudar,
      "function",
      "exporte saudar com module.exports",
    );
    assert.match(saudar(), /mundo/, 'sem argumento, deve saudar "mundo"');
    assert.match(saudar("Ana"), /Ana/, "deve incluir o nome recebido");
  },
);

test(
  "E2: minha localização",
  {
    skip:
      !existsSync(LOCALIZACAO) &&
      "exercicios/e2/02-minha-localizacao.js ainda não existe",
  },
  () => {
    const { minhaLocalizacao, descrever, distancia, mover } = require(
      LOCALIZACAO,
    );

    assert.deepEqual(minhaLocalizacao, { x: 3, y: 4 });
    assert.equal(descrever({ x: 3, y: 4 }), "(3, 4)");
    assert.equal(distancia({ x: 0, y: 0 }, { x: 3, y: 4 }), 5);

    const ponto = { x: 1, y: 1 };
    assert.deepEqual(mover(ponto, 2, -3), { x: 3, y: -2 });
    assert.deepEqual(
      ponto,
      { x: 1, y: 1 },
      "mover não deve alterar o ponto original",
    );
  },
);
