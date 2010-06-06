
{ a helper function: quicksort in descending order }
procedure quicksort_descending(N : longint; var a : array of longint);

   procedure sort(l,r: longint);
   var i,j,x,y: longint;
   begin
      i:=l; j:=r; x:=a[(l+r) div 2];
      repeat
         while a[i]>x do inc(i);
         while x>a[j] do dec(j);
         if not(i>j) then begin y:=a[i]; a[i]:=a[j]; a[j]:=y; inc(i); dec(j); end;
      until i>j;
      if l<j then sort(l,j);
      if i<r then sort(i,r);
   end;

begin
   sort(0,N-1);
end;

{ helper functions: maximum and minimum }
function max(a, b : longint) : longint; begin if a>b then max:=a else max:=b; end;
function min(a, b : longint) : longint; begin if a<b then min:=a else min:=b; end;

function Alla (N : longint; cubes : array of longint) : longint;
var first, second, first_tower, second_tower, M, i, res : longint;
    remains : array of longint;

begin
   SetLength(remains,N);
   quicksort_descending(N,cubes);
   { if there are more than 15 cubes, take 15 largest }
   if N > 15 then N := 15;
   res := 0;
   { try all possible sets of cubes in the first tower }
   for first := 0 to ((1 shl N)-1) do begin
      first_tower := 0;
      M := 0;
      for i := 0 to N-1 do 
         if (first and (1 shl i)) <> 0 then inc( first_tower, cubes[i] )
         else begin remains[M]:=cubes[i]; inc(M); end;
      { try all possible sets of cubes in the second tower }
      for second := 0 to ((1 shl M)-1) do begin
         second_tower := 0;
         for i := 0 to N-1 do 
            if (second and (1 shl i)) <> 0 then inc( second_tower, remains[i] );
         if first_tower=second_tower then res := max( res, first_tower );
      end;
   end;
   Alla := res;
end;

function partition (N : longint; cubes : array of longint) : boolean;
var i, j, S : longint;
    possible : array of boolean;
begin
   S := 0;
   for i := 0 to N-1 do inc( S, cubes[i] );
   if S mod 2 <> 0 then begin partition:=false; exit; end;
   SetLength( possible, S+1 );
   for i := 0 to S do possible[i] := (i=0);
   for i := 0 to N-1 do
      for j := S downto cubes[i] do
         if possible[j-cubes[i]] then possible[j] := true;
   partition := possible[ S div 2 ];
end;

function Bob (N : longint; cubes : array of longint) : longint;
var i, j, k, l, S, res : longint;
    tmp : array of longint;
begin
   S := 0;
   for i := 0 to N-1 do inc( S, cubes[i] );
   if partition(N,cubes) then begin Bob:=S div 2; exit; end;
   res := 0;

   { try all possibilities without one cube }
   for i := 0 to N-1 do begin
      SetLength( tmp, N-1 );
      k := 0;
      for l := 0 to N-1 do if l <> i then begin
         tmp[k]:=cubes[l]; inc(k);
      end;
      if partition(N-1,tmp) then res := max( res, (S-cubes[i]) div 2 );
   end;

   { try all possibilities without two cubes }
   for i := 0 to N-1 do for j:=0 to i-1 do begin
      SetLength( tmp, N-2 );
      k := 0;
      for l := 0 to N-1 do if (l <> i) and (l <> j) then begin
         tmp[k]:=cubes[l]; inc(k);
      end;
      if partition(N-2,tmp) then res := max( res, (S-cubes[i]-cubes[j]) div 2 );
   end;

   Bob := res;
end;

function Chermi (N : longint; cubes : array of longint) : longint;
var i, j, S, height, first_tower, second_tower : longint;
begin
   quicksort_descending(N,cubes);
   S := 0;
   for i := 0 to N-1 do inc( S, cubes[i] );
   for height := (S div 2) downto 1 do begin
      first_tower := 0; second_tower := 0;
      for i := 0 to N-1 do begin
         if first_tower + cubes[i] <= height then inc( first_tower, cubes[i] );
         if first_tower > second_tower then begin
            j := first_tower;
            first_tower := second_tower;
            second_tower := j;
         end;
      end;
      if (first_tower = height) and (second_tower = height) then begin
         Chermi := height; exit;
      end;
   end;
   Chermi := 0;
end;

function Dominika (N : longint; cubes : array of longint) : longint;
var i, j, S, height : longint;
    ways : array of longint;
begin
   S := 0;
   for i := 0 to N-1 do inc( S, cubes[i] );
   SetLength( ways, S+1 );
   for i := 0 to S do ways[i] := 0;
   ways[0] := 1;
   for i := 0 to N-1 do
      for j := S downto cubes[i] do
         ways[j] := min( 2, ways[j] + ways[j-cubes[i]] );
   for height := (S div 2) downto 1 do
      if (ways[2*height]>0) and (ways[height]>1) then begin
         Dominika := height; exit;
      end;
   Dominika := 0;
end;

var N, i : longint;
    cubes : array of longint;

begin
   read(N);
   SetLength(cubes, N);
   for i := 0 to N-1 do read(cubes[i]);
   writeln('Alla: ',Alla(N,cubes));
   writeln('Bob: ',Bob(N,cubes));
   writeln('Chermi: ',Chermi(N,cubes));
   writeln('Dominika: ',Dominika(N,cubes));
end.

