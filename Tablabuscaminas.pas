program Buscaminas;

const
  tamano_pequeno = 8;
  tamano_mediano = 16;
  tamano_grande = 16;
  ancho_grande = 30;

type
  Tablero = array of array of Char;

var
  TableroBuscaminas: Tablero;
  a, b: Integer;
  tamanoTablero: Integer;

procedure InicializarTablero(var Tablero: Tablero; tamano: Integer);
var
  a, b: Integer;
begin
  SetLength(Tablero, tamano, tamano);
  for a := 0 to tamano - 1 do
    for b := 0 to tamano - 1 do
      Tablero[a, b] := '-';
end;

procedure ImprimirTablero(Tablero: Tablero; tamano: Integer);
var
a, b: Integer;
begin
  for a := 0 to tamano - 1 do
  begin
    for b := 0 to tamano - 1 do
      Write(Tablero[a, b], ' ');
    Writeln;
  end;
end;

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
