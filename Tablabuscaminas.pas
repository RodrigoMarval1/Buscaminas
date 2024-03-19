program Buscaminas;

const
  tamano_pequeno = 8;
  tamano_mediano = 16;
  tamano_grande = 16;
  ancho_grande = 30;

type
  Tablero = array of array of Char;
  coordenada = record
    x: integer;
    y: integer;
end;

var
  Tablerofacil, tableromedia, talberodificil: tablero;
  
procedure InicializarTablero(var Tablero: Tablero; filas, columnas, minas: Integer);
var
  a, b: minascolocadas: interger;
begin
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
  writeln('Elige el tamano del tablero de Buscaminas:');
  writeln('1. 8x8');
  writeln('2. 16x16');
  writeln('3. 16x30');
  readln(tamanoTablero);

  case tamanoTablero of
    1: begin
         InicializarTablero(TableroBuscaminas, tamano_pequeno);
         ImprimirTablero(TableroBuscaminas, tamano_pequeno);
       end;
    2: begin
         InicializarTablero(TableroBuscaminas, tamano_mediano);
         ImprimirTablero(TableroBuscaminas, tamano_mediano);
       end;
    3: begin
         InicializarTablero(TableroBuscaminas, tamano_grande);
         SetLength(TableroBuscaminas, tamano_grande, ancho_grande);
         ImprimirTablero(TableroBuscaminas, tamano_grande);
       end;
  end;
end.
