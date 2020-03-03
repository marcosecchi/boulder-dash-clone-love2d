-- Tabella di informazioni per il tileset
return {
  -- Definisce le dimensioni (altezza e larghezza) di ogni tile
  tileSize = 32,
  
  -- Definisce le varie informazioni delle tile utilizzate
  -- key : il codice identificativo utilizzabile nella mappa
  -- posX : la posizione (colonna) della tile nello spritesheet utilizzato
  -- posY : la posizione (riga) della tile nello spritesheet utilizzato
  -- type : il tipo di tile, utilizzato per capire se un elemento è accessibile, blocca il movimento, etc.
  tilesData = {
    { key = 'O', posX = 4, posY = 3, type = "diggable" }, -- Può essere scavato
    { key = 'E', posX = 9, posY = 9, type = "empty" },    -- Vuoto
    { key = 'B', posX = 5, posY = 3, type = "boulder" },  -- Masso
    { key = 'I', posX = 2, posY = 3 },                    -- Muro impassabile
    { key = 'W', posX = 0, posY = 3 }                     -- Muro di bordo
  },

  -- Definisce la mappa generata tramite i tileset definiti sopra
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
