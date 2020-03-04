-- Importo la libreria di debug
lovebird = require("lovebird")

-- Tabella contenente le informazioni dei macigni "sospesi"
-- che dovranno cadere
FallingBoulders = {}

-- Tabella contenente le informazioni del giocatore
Player = {}

-- Tabella contenente informazioni generali del gioco (es.: stato, etc.)
Game = {}

-- Tabella contenente le informazioni delle tile che andranno a comporre la mappa
Tiles = {}

-- Funzione di callback chiamata dall'engine all'inizio del gioco
function love.load(arg)
  -- carica gli asset allinterno di variabili globali
  StepSound = love.audio.newSource("assets/audio/step.wav", "static")
  DeadSound = love.audio.newSource("assets/audio/dead.wav", "static")
  Font = love.graphics.newFont("assets/fonts/CommodorePixelized.ttf", 24)
  Tileset = love.graphics.newImage("assets/images/spritesheet_32x32.png")

  -- Inizializza tutte le informazioni del gioco
  ResetGame()
  InitTiles()
  InitPlayer()

  -- Definisce lo stato del gioco, in modo tale che
  -- al prossimo redraw venga visualizzata la schermata
  -- di inizio gioco
  Game.status = "start"
end

-- Funzione di callback chiamata dall'engine ad ogni frame
-- Viene utilizzata per effettuare eventuali calcoli logici
function love.update(dt)
  -- Aggiorna la finestra di debug con i nuovi messaggi racciati
  require("lovebird").update()
end

-- Funzione di callback chiamata dall'engine ogni volta che l'utente preme un tasto
function love.keypressed(key, scancode, isrepeat)

  -- Nel caso mi trovi nelle schermate di Start o Game Over
  -- cambio lo stato se la barra spaziatrice è premuta
  if(Game.status ~= "play") then
    if(Game.status == "start" and key == "space") then
      ResetGame()
      Game.status = "play"
    elseif (Game.status == "game over" and key == "space") then
      Game.status = "start"
    else
      return
    end
  end

  -- Calcolo la posizione dove andrà a trovarsi il giocatore

  -- Definisco le variabili per la nuova posizione del giocatore
  local nextPosX = Player.posX
  local nextPosY = Player.posY

  -- Calcolo il possibile movimento verticale del giocatore
  if(key == "up") then
    nextPosY = nextPosY - 1
  elseif (key == "down") then
    nextPosY = nextPosY + 1
  end

  -- Calcolo il possibile movimento orizzontale del giocatore
  if(key == "right") then
    nextPosX = nextPosX + 1
  elseif (key == "left") then
    nextPosX = nextPosX - 1
  end

  -- Trovo il tipo di tile dove andrà a posizionarsi il giocatore
  local nextTile = MapData.map[nextPosY][nextPosX]

  -- Se è possibile muoversi (terreno vuoto o scavabile) aggiorno la posizione
  -- del giocatore, emettendo i suoni corrispondenti
  if(Tiles[nextTile].type == "diggable" or Tiles[nextTile].type == "empty") then
    MapData.map[Player.posY][Player.posX] = "E"
    Player.posX = nextPosX
    Player.posY = nextPosY
    StepSound:play()
  else
    -- Fermo, ha colpito il muro
  end

  -- Aggiorno la posizione dei massi che devono cadere
  -- Essendo messo in questa posizione, la logica è "turn-based",
  -- cioè aggiorno i massi solo quando il giocatore muove
  UpdateBoulders()
end

-- Funzione di callback chiamata dall'engine ad ogni frame
-- Viene utilizzata per 'disegnare' sullo schermo
function love.draw()
  if(Game.status == "start") then
    DrawStartScreen()
  elseif(Game.status == "game over") then
    DrawEndScreen()
  else
  -- Ridisegno la mappa
    DrawMap()
    DrawPlayer()
  end
end

function UpdateBoulders()
  for i, k in pairs(FallingBoulders) do
    MapData.map[k.row][k.column] = "E"
    MapData.map[k.row + 1][k.column] = "B"
    if(Player.posX == k.column and Player.posY == k.row + 1) then
      DeadSound:play()
      Game.status = "game over"
    end
  end

  FallingBoulders = {}

  local map = MapData.map
  for row=1,table.getn(map) do
    for column=1,table.getn(map[row]) do
    if(map[row][column] == "B" and map[row + 1][column] == "E") then
        local b = {}
        b.column = column
        b.row = row
        table.insert(FallingBoulders, b)
      end
    end
  end
end

function DrawPlayer()
  love.graphics.draw(
    Tileset,
    Player.quad,
    MapData.tileSize * Player.posX - MapData.tileSize,
    MapData.tileSize * Player.posY - MapData.tileSize
  )
end

function DrawMap()
  local map = MapData.map
  for row=1,table.getn(map) do
    for column=1,table.getn(map[row]) do
      love.graphics.draw(
          Tileset,
          Tiles[map[row][column]].image,
          MapData.tileSize * (column - 1),
          MapData.tileSize * (row - 1)
      )
    end
  end
end

function ResetGame()
  MapData = assert(love.filesystem.load( "map_data.lua"))()
  Player.posX = 2
  Player.posY = 2
end

-- Inizializza le informazioni di ogni tile che andrà a comporre la mappa
function InitTiles()
  for i=1,table.getn(MapData.tilesData) do
    local tileData = MapData.tilesData[i]
    Tiles[tileData.key] = {}
    Tiles[tileData.key].image = love.graphics.newQuad(
                              tileData.posX * MapData.tileSize,
                              tileData.posY * MapData.tileSize,
                              MapData.tileSize,
                              MapData.tileSize,
                              Tileset:getDimensions())
    Tiles[tileData.key].type = tileData.type
  end
end

-- Inizializza le informazioni del giocatore
function InitPlayer()
  -- crea l'area da ritagliare dallo spritesheet
  Player.quad = love.graphics.newQuad(
                                0,
                                0,
                                MapData.tileSize,
                                MapData.tileSize,
                                Tileset:getDimensions())
end

function DrawStartScreen()
  love.graphics.setColor(0.09, 0.11, 0.09, 1)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  love.graphics.setColor(0.84, 0.61, 0.22, 1)
  love.graphics.setFont(Font)
  love.graphics.printf("Press SPACEBAR to Start", 20, 130, love.graphics.getWidth() - 20, "center")
  love.graphics.setColor(255, 255, 255, 255)
end

function DrawEndScreen()
  love.graphics.setColor(0.09, 0.11, 0.09, 1)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  love.graphics.setColor(162, 203, 57, 255)
  love.graphics.setFont(Font)
  love.graphics.printf("Crushed by a Boulder!\n\nPress 'SPACEBAR' to Replay", 20, 100, love.graphics.getWidth() - 20, "center")
  love.graphics.setColor(255, 255, 255, 255)
end