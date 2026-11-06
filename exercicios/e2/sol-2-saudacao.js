function saudar(nome = "mundo") {
  return `Olá, ${nome}!`;
}

// Só imprime quando executado diretamente (node 01-saudacao.js), não quando importado.
if (require.main === module) {
  console.log(saudar());
  console.log(saudar("Ana"));
}

module.exports = { saudar };
