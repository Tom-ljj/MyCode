A = [0.15 0.25 0.10 0.18 0.22 0.1];
[~, q] = size(A);
Cm = cell(1, q);
Cm = fano2(A, Cm, 0);
