function [prec, eile, UU] = hamiltonianPath(V, U, kelioPradzia, ograf)
% Hamiltono masruto funkcija iesko kelio kuriame apeitu viena karta visas
% skirtingas virsunes nuo virsunes kelioPradzia
%
% Formalus parametrai
% V - grafo virsuniu aibe
% U - grafo briaunu aibe; [u, v] - briauna
% kelioPadzia - pradinis virsunes taskas nuo kurio pradedama
% orgraf - turi dvi reiksmes jei 0 - neorientuotas grafas, jei 1 -
% orientuotas grafas
% prec - is kurios virsunes atejo
% eile - kaip praeinami visos virsunes
% UU - kelio aibe

% Paruosiemieji veiksmai
n = numel(V); % Virsuniu skaicius
prec = zeros(1, n);  % Nustatoma pradines reiksmes i 0
eile = zeros(1, n);
praitKaim = ones(1, n); % Nustatomos pradines reiksmes i 1
eile(1) = kelioPradzia;
prec(kelioPradzia) = kelioPradzia;
current = kelioPradzia;
ind = 2; % indeksas eiles
UU = {};

% Gretimumo strukturos apskaiciavimas
GAM = UtoGAM(V, U, ograf);

previous = -1;

% Pradiniai skaiciavimai
while ind <= n
    foundNext = false;

    % Iteruojame nuo virsuoniu gretimai virsunei
    for j = praitKaim(current):length(GAM{current})
        a = GAM{current}(j); % virsune gretima virsunei
        
        if prec(a) == previous
            prec(a) = 0;
            break;
        end
        % Tikriname ar virsune nauja
        if prec(a) == 0
            eile(ind) = a;
            prec(a) = current;
            current = a;
            ind = ind + 1;
            praitKaim(current) = 1;
            foundNext = true;
            break;
        end % if
    end % for

    % Jei visos virsunes nenaujos gryztame i praeitas virsunes
    if ~foundNext
        praitKaim(current) = 1;
        ind = ind - 1;
        
        % Tikriname ar dar yra virsuniu
        if ind < 1
            disp('Nerastas Hamiltono masrutas');
            return;
        end % if 
        
        previous = current;

        current = eile(ind);
        prec(current) = 0;
        praitKaim(current) = praitKaim(current) + 1;
    end % if

    if ind > n
        foundCycle = false;
        eile
        current = eile(n);
        praitKaim(current) = 1;
        for j = praitKaim(current):length(GAM{current})
            a = GAM{current}(j);
            if prec(a) == kelioPradzia
                foundCycle = true;
                break;
            end
        end
        
        if ~foundCycle
            ind = n - 1;
            current = eile(ind);
            previous = current;
            prec(current) = 0;
            praitKaim(current) = praitKaim(current) + 1;
        end
    end
end % while

% Rasto hamiltono masruto vaizdavimui
if ind > n
    for i = 1: (length(eile) - 1)
        UU{i} = [eile(i), eile(i+1)];
    end % for
end % if

return
