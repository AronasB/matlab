clc; close all; clear 

V = [1 2 3 4 5 6]; % grafo virsuniu aibe
% Grafo briaunos
%U = {[1 2],[2 3],[2 4],[3 4]};
U = {[1 2],[2 3],[3 4],[1 4],[4 6], [3 5], [5 6]};
%U = {[1 2],[2 3],[3 4],[4 5], [5 6], [6 1]};
%U = {[1 2],[3 2]};
%U = {[3 2], [2 4], [2 1], [4 1]}; % neorient
%U = {[3 2], [2 4], [2 1], [1 4]}; % neorient
% Grafo virsuniu koordinates nulinamos, pagal nutylejima virsunes bus isdestomos ratu.
Vkor = []; 

disp('Darbo pradzia')
% Pradiniai priskyrimai
kelioPradzia = 1;  
orgraf = 0;  % grafas neorientuotasis
% orgraf = 1;  % grafas orientuotasis
% Pradinio grafo brezimas
arc = 0; poz = 0; Fontsize = 10; lstor = 1; spalva = 'b';
figure(1)
title('Duotasis grafas')
Vkor = plotGraphVU(V,U,orgraf,arc,Vkor,poz,Fontsize,lstor,spalva);
hold on; pause(1)

% Hamiltono masrutas - paieska i gyli su gryzimu
% prec - is kurios virsunes atejo
% UU   - gauto hamiltono marsruto aibe
%[prec, eile, UU] = hamiltonianPath(V, U, kelioPradzia);

disp( ['Kelio pradzia: ',num2str(kelioPradzia), ' virsune']) ;

[prec, eile, UU] = hamiltonianPath(V, U, kelioPradzia, orgraf);

index = "";
for i = 1:length(prec)
    index = index + "     " + i;
end

disp("Eile:"); disp(eile);
disp("V"); disp(index);
disp("prec"); disp(prec);

% Tikrinam ar netuscia aibe
if ~isempty(UU)
    for i = 1:length(UU)
        title(sprintf('Hamiltono marsrutas: zingsnis %d', i));
        V1 = UU{i};
        U1 = {V1};
        V1kor = [Vkor(V1(1),:); Vkor(V1(2),:)];
        plotGraphVU(V1, U1, 0, 0, V1kor, 0, 10, 3, 'r'); 
        pause(1)
    end
end

disp('Darbo pabaiga')
