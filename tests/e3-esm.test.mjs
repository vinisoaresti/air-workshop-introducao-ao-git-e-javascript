import { test } from "node:test";
import assert from "node:assert/strict";
import { existsSync } from "node:fs";
import { execFileSync } from "node:child_process";
import { fileURLToPath, pathToFileURL } from "node:url";

const caminho = (pasta, nome) =>
  fileURLToPath(new URL(`../exercicios/${pasta}/${nome}`, import.meta.url));

const SAUDACAO = caminho("e3", "saudacao.mjs");
const LOCALIZACAO = caminho("e3", "localizacao.mjs");
const COMPOSTO = caminho("e3", "saudacao-localizacao.mjs");
const ANTIGOS = [
  caminho("e2", "01-saudacao.js"),
  caminho("e2", "02-minha-localizacao.js"),
];

const pular = (arquivo) =>
  !existsSync(arquivo) &&
  `exercicios/e3/${arquivo.split("/").pop()} ainda não existe`;

test("E3: saudacao.mjs exporta saudar", { skip: pular(SAUDACAO) }, async () => {
  const { saudar } = await import(pathToFileURL(SAUDACAO));
  assert.equal(typeof saudar, "function", "use export function saudar");
  assert.match(saudar("Ana"), /Ana/);
});

test(
  "E3: localizacao.mjs exporta as funções",
  { skip: pular(LOCALIZACAO) },
  async () => {
    const mod = await import(pathToFileURL(LOCALIZACAO));
    assert.deepEqual(mod.minhaLocalizacao, { x: 3, y: 4 });
    assert.equal(mod.descrever({ x: 3, y: 4 }), "(3, 4)");
    assert.equal(mod.distancia({ x: 0, y: 0 }, { x: 3, y: 4 }), 5);
    assert.deepEqual(mod.mover({ x: 1, y: 1 }, 2, -3), { x: 3, y: -2 });
  },
);

test(
  "E3: saudacao-localizacao.mjs combina os módulos",
  { skip: pular(COMPOSTO) },
  async () => {
    const { saudar } = await import(pathToFileURL(SAUDACAO));
    const saida = execFileSync(process.execPath, [COMPOSTO], {
      encoding: "utf8",
    });

    // Compara com saudar() em vez de texto fixo: o E4 altera a mensagem da saudação.
    assert.ok(
      saida.includes(saudar("Ana")),
      `a saída deve conter: ${saudar("Ana")}`,
    );
    assert.match(saida, /\(3, 4\)/, "a saída deve conter a localização (3, 4)");
    assert.match(saida, /\b5\b/, "a saída deve conter a distância 5");
  },
);

test(
  "E3: arquivos CommonJS antigos foram removidos",
  { skip: pular(COMPOSTO) },
  () => {
    for (const antigo of ANTIGOS) {
      assert.ok(
        !existsSync(antigo),
        `remova (git mv) ${antigo.split("/").pop()}`,
      );
    }
  },
);
