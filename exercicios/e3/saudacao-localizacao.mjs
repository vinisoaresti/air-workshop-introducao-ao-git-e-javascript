// Funciona como saudacao-localizacao.mjs, ao lado de saudacao.mjs e localizacao.mjs.
import { saudar } from "./saudacao.mjs";
import { minhaLocalizacao, descrever, distancia } from "./localizacao.mjs";

const ORIGEM = { x: 0, y: 0 };

export function saudarComLocalizacao(nome, ponto = minhaLocalizacao) {
  return `${saudar(nome)} Você está em ${descrever(ponto)}, a ${distancia(ORIGEM, ponto)} unidades da origem.`;
}

console.log(saudarComLocalizacao("Ana"));
