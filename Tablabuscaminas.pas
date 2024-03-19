program Buscaminas;

const
  filas_facil = 8;
  columnas_facil = 8;
  minas_facil = 10;
  filas_media = 16;
  columnas_media = 16;
  minas_media = 40;
  filas_dificil = 16;
  columnas_dificil = 30;
  minas_dificil = 99;

type
  Tablero = array[1..30, 1..30] of char;
  Coordenada = record
    x: integer;
    y: integer;
  end;

var
  tableroFacil, tableroMedia, tableroDificil: Tablero;

procedure InicializarTablero(var tablero: Tablero; filas, columnas, minas: integer);
var
  a, b, minasColocadas: integer;
begin
  randomize;
  for a := 1 to filas do
    for b := 1 to columnas do
      tablero[a][b] := ' ';
  minasColocadas := 0;
  while minasColocadas < minas do
  begin
    a := random(filas) + 1;
    b := random(columnas) + 1;
    if tablero[a][b] <> '*' then
    begin
      tablero[a][b] := '*';
      minasColocadas := minasColocadas + 1;
    end;
  end;
end;

procedure MostrarTablero(tablero: Tablero; filas, columnas: integer);
var
  a, b: integer;
begin
  writeln('   1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30');
  writeln(' -----------------------------------------------------------------------------------');
  for a := 1 to filas do
  begin
    if a < 10 then
      write(' ');
    write(a, '|');
    for b := 1 to columnas do
      write(' ', tablero[a][b]);
    writeln;
  end;
end;

function ContarMinasAlrededor(tablero: Tablero; x, y, filas, columnas: integer): integer;
var
  a, b, contador: integer;
begin
  contador := 0;
  for a := -1 to 1 do
    for b := -1 to 1 do
      if (x + a >= 1) and (x + a <= filas) and (y + b >= 1) and (y + b <= columnas) then
        if tablero[x + a][y + b] = '*' then
          contador := contador + 1;
  ContarMinasAlrededor := contador;
end;

procedure RevelarCasilla(var tablero: Tablero; x, y, filas, columnas: integer);
begin
  if (x >= 1) and (x <= filas) and (y >= 1) and (y <= columnas) and (tablero[x][y] = ' ') then
  begin
    tablero[x][y] := chr(48 + ContarMinasAlrededor(tablero, x, y, filas, columnas));
    if tablero[x][y] = '0' then
    begin
      RevelarCasilla(tablero, x - 1, y, filas, columnas);
      RevelarCasilla(tablero, x + 1, y, filas, columnas);
      RevelarCasilla(tablero, x, y - 1, filas, columnas);
      RevelarCasilla(tablero, x, y + 1, filas, columnas);
    end;
  end;
end;

procedure JugarBuscaminas(var tablero: Tablero; filas, columnas, minas: integer);
var
  x, y: integer;
begin
  InicializarTablero(tablero, filas, columnas, minas);
  repeat
    MostrarTablero(tablero, filas, columnas);
    writeln('Ingrese coordenadas (fila columna): ');
    readln(x, y);
    if (x >= 1) and (x <= filas) and (y >= 1) and (y <= columnas) then
    begin
      if tablero[x][y] = '*' then
      begin
        writeln(' ¡Has perdido! Se encontro una mina.');
        tablero[x][y] := 'X';
        MostrarTablero(tablero, filas, columnas);
        exit;
      end
      else
        RevelarCasilla(tablero, x, y, filas, columnas);
    end
    else
      writeln('Coordenadas invalidas. Inténtalo de nuevo.');
  until false;
end;

var
  opcion: integer;
  
begin
  writeln('Bienvenido al juego de Buscaminas');
  writeln('Seleccione la dificultad:');
  writeln('1. Facil (8x8)');
  writeln('2. Medio (16x16)');
  writeln('3. Dificil (16x30)');
  writeln('Ingrese el numero correspondiente a la dificultad:');
  readln(opcion);
  case opcion of
    1: JugarBuscaminas(tableroFacil, filas_facil, columnas_facil, minas_facil);
    2: JugarBuscaminas(tableroMedia, filas_media, columnas_media, minas_media);
    3: JugarBuscaminas(tableroDificil, filas_dificil, columnas_dificil, minas_dificil);
  end;
end.

