-- Funzione di callback definibile tramite il framework Love
-- Viene eseguito prima che parta il gioco
function love.conf(t)
  t.title = "Boulder Dash" -- Definisce il titolo della finestra
  t.window.width = 576 -- Definisce la larghezza della finestra
  t.window.height = 352 -- Definisce l'altezza della finestra
end
