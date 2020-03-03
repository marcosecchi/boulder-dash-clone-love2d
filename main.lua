-- Importo la libreria di debug
lovebird = require("lovebird")

-- Tabella contenente le informazioni dei macigni "sospesi"
-- che dovranno cadere
FallingBoulders = {}

-- Tabella contenente le informazioni del giocatore
Player = {}

-- Tabella contenente informazioni generali del gioco (es.: stato, etc.)
Game = {}

-- Funzione di callback chiamata dall'engine all'inizio del gioco
function love.load(arg)
  WallSound = love.audio.newSource("assets/audio/wall.wav", "static")
  StepSound = love.audio.newSource("assets/audio/step.wav", "static")
  Font = love.graphics.newFont("assets/fonts/CommodorePixelized.ttf", 24)
  Tileset = love.graphics.newImage("assets/images/spritesheet_32x32.png")

  ResetGame()

  Tiles = {}
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

  Player.quad = love.graphics.newQuad(
                                0,
                                0,
                                MapData.tileSize,
                                MapData.tileSize,
                                Tileset:getDimensions())

  Game.status = "start"
end

-- Funzione di callback chiamata dall'engine ad ogni frame
-- Viene utilizzata per effettuare eventuali calcoli logici
function love.update(dt)
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

  local nextPosX = Player.posX
  local nextPosY = Player.posY

  if(key == "up") then
    nextPosY = nextPosY - 1
  elseif (key == "down") then
    nextPosY = nextPosY + 1
  end

  if(key == "right") then
    nextPosX = nextPosX + 1
  elseif (key == "left") then
    nextPosX = nextPosX - 1
  end

  local nextTile = MapData.map[nextPosY][nextPosX]
--  lovebird.print(nextTile)
  if(Tiles[nextTile].type == "diggable" or Tiles[nextTile].type == "empty") then
    MapData.map[Player.posY][Player.posX] = "E"
    Player.posX = nextPosX
    Player.posY = nextPosY
    StepSound:play()
  else
    WallSound:play()
  end

  UpdateBoulders()
end

-- Funzione di callback chiamata dall'engine ad ogni frame
-- Viene utilizzata per 'disegnare' sullo schermo
function love.draw()
  DrawMap()

  love.graphics.draw(
    Tileset,
    Player.quad,
    MapData.tileSize * Player.posX - MapData.tileSize,
    MapData.tileSize * Player.posY - MapData.tileSize
  )

  if(Game.status == "start") then
    DrawStartScreen()
  elseif(Game.status == "game over") then
    DrawEndScreen()
  end
end

function UpdateBoulders()
  for i, k in pairs(FallingBoulders) do
    MapData.map[k.row][k.column] = "E"
    MapData.map[k.row + 1][k.column] = "B"
    lovebird.print(Player.posY .. " " .. k.row)
    if(Player.posX == k.column and Player.posY == k.row + 1) then
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