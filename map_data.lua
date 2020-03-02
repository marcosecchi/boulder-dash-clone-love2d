return {
  tileSize = 32,
  tilesData = {
    { key = 'O', posX = 4, posY = 3, type = "diggable" }, -- diggable
    { key = 'I', posX = 2, posY = 3 },                    -- impassable wall
    { key = 'E', posX = 9, posY = 9, type = "empty" },    -- empty
    { key = 'B', posX = 5, posY = 3, type = "boulder" },  -- boulder
    { key = 'W', posX = 0, posY = 3 }                     -- border
  },
  map = {
    { 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W'},
    { 'W', 'E', 'O', 'O', 'O', 'O', 'O', 'I', 'O', 'O', 'B', 'B', 'B', 'O', 'O', 'O', 'O', 'W'},
    { 'W', 'O', 'O', 'O', 'O', 'O', 'O', 'I', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'W'},
    { 'W', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'W'},
    { 'W', 'O', 'O', 'I', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'W'},
    { 'W', 'O', 'O', 'I', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'W'},
    { 'W', 'O', 'O', 'I', 'I', 'I', 'I', 'I', 'O', 'O', 'O', 'B', 'O', 'O', 'O', 'O', 'O', 'W'},
    { 'W', 'O', 'O', 'B', 'B', 'B', 'B', 'B', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'W'},
    { 'W', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'W'},
    { 'W', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'B', 'W'},
    { 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W'}
  }
}
