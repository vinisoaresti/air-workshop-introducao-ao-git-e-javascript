const minhaLocalizacao = { x: 3, y: 4 };

function descrever(ponto) {
  return `(${ponto.x}, ${ponto.y})`;
}

// TODO: calcule a distância entre os pontos a e b (dica: Math.hypot).
function distancia(a, b) {
  return 0;
}

// TODO: devolva um novo ponto deslocado de dx e dy, sem alterar o original.
function mover(ponto, dx, dy) {
  return ponto;
}

if (require.main === module) {
  const origem = { x: 0, y: 0 };
  console.log(`Minha localização: ${descrever(minhaLocalizacao)}`);
  console.log(`Distância até a origem: ${distancia(origem, minhaLocalizacao)}`);
  console.log(`Depois de mover (1, -1): ${descrever(mover(minhaLocalizacao, 1, -1))}`);
}

module.exports = { minhaLocalizacao, descrever, distancia, mover };
