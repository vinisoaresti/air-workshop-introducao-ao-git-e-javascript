export const minhaLocalizacao = { x: 3, y: 4 };

export function descrever(ponto) {
  return `(${ponto.x}, ${ponto.y})`;
}

export function distancia(a, b) {
  return Math.hypot(b.x - a.x, b.y - a.y);
}

export function mover(ponto, dx, dy) {
  return { x: ponto.x + dx, y: ponto.y + dy };
}
