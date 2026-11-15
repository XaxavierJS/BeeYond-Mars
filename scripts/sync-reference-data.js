import { writeFile } from 'node:fs/promises';
import {
  CFG,
  ROLES,
  PEOPLE,
  AVATARS,
  ITEMS,
  LAUNCHERS,
  ROUTES,
  GUIDE,
  SOURCES,
} from '../dist/data.js';

const balance = {
  status: 'team_defined_educational_game_model',
  CFG,
  ROLES,
  PEOPLE,
  AVATARS,
  ITEMS,
  LAUNCHERS,
  ROUTES,
  GUIDE,
};

await Promise.all([
  writeFile('dist/game-balance.json', `${JSON.stringify(balance, null, 2)}\n`),
  writeFile('dist/sources.json', `${JSON.stringify(SOURCES, null, 2)}\n`),
]);

console.log('Synchronized dist/game-balance.json and dist/sources.json from dist/data.js.');
