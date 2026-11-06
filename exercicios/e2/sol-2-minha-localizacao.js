const minhaLocalizacao = { x: 3, y: 4 };

function descrever(ponto) {
  return `(${ponto.x}, ${ponto.y})`;
}

function distancia(a, b) {
  return Math.hypot(b.x - a.x, b.y - a.y);
}

function mover(ponto, dx, dy) {
  return { x: ponto.x + dx, y: ponto.y + dy };
}

if (require.main === module) {
  const origem = { x: 0, y: 0 };
  console.log(`Minha localização: ${descrever(minhaLocalizacao)}`);
  console.log(`Distância até a origem: ${distancia(origem, minhaLocalizacao)}`);
  console.log(`Depois de mover (1, -1): ${descrever(mover(minhaLocalizacao, 1, -1))}`);
}

module.exports = { minhaLocalizacao, descrever, distancia, mover };
