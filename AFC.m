% TODO : Translate french comments to english
% TODO : Convert to function (arguments (N ?) and results (data to plot ?) to determine)
i = 10;
j = 5;
N = rand(i,j)

n = i*j;

% Creation of frequences matrix (uncorrelated matrix)
npp=sum(sum(N));
U=N./npp;

% Creation of "hand" (i) and "foot" (j) vectors
Ui=sum(U,1);
Uj=sum(U,2);

Uij = (Ui.*Uj)/npp

% J column correlation quantity
Khi2j = (1/n).*(((Uij-Uj).^2)./sqrt(Uij))

Khi2 = sum(sum(Khi2j))

% Dmain = diag(Ui).^(-1)
% Dpied = diag(Uj).^(-1/2)
% E = [cos(theta) sin(theta); -sin(theta) cos(theta)] % E is the rotation matrix ? What is theta ?
% D (or D^1/2) = "the ACP D matrix ??? I^1/2 ?? If weights are equals, D=(1/N).*I (see wiki page) ??"
% L = sqrt(npp).*Dmain.*N.*Dpied.*E
% C = sqrt(n-1).*Dpied.*E.*D
