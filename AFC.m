% TODO : Translate french comments to english
% TODO : Convert to function (arguments (N ?) and results (data to plot ?) to determine)
i = 10;
j = 5;
N = rand(i,j)

n = i*j;

% Creation of frequences matrix (uncorrelated matrix)
npp=sum(sum(N));

% Creation of "hand" (i) and "foot" (j) vectors
Uj=sum(N,1); % column sum
Ui=sum(N,2); % line sum

Uij = (Ui.*Uj)/npp;

% J column correlation quantity
Khi2 = getKi2vec(Uij, N);

Dmain = diag(Ui)
Dpied = diag(Uj)

V = cov(N); % or cov(X) ?
[E, D] = eig(V);
d=diag(D);
[d, I] = sort(d, 'descend');
D = diag(d);

L = sqrt(npp) * Dmain^(-1) * N * Dpied^(-1/2) * E
C = sqrt(n-1) * Dpied^(-1/2) * E * D^(1/2)

% http://www.math.u-bordeaux.fr/~mchave100p/wordpress/wp-content/uploads/2013/10/AFC.pdf

function Khi2test = getKi2J(j, U, N)
    Khi2test = 0;
   
    n = size(N, 1);
    for i=1:n
        uij = U(i, j);
        nij = N(i, j);
        Khi2test = Khi2test + ((uij - nij) ./ (sqrt(uij))).^2;
    end
    
    Khi2test = Khi2test .* (1 ./ n);
end

function Khi2vec = getKi2vec(U, N)
    vec_size = size(N, 2);
    Khi2vec = zeros(vec_size, 1);

    for j=1:vec_size
        Khi2vec(j) = getKi2J(j, U, N);
    end
end
