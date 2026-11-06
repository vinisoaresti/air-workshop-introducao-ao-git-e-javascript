// TODO: receba um nome (padrão "mundo") e inclua-o na saudação usando template literal.
function saudar() {
  return "Olá!";
}

if (require.main === module) {
  console.log(saudar());
  console.log(saudar("Ana"));
}

module.exports = { saudar };
