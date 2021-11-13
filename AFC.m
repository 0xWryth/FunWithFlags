function AFC(N) % TODO : (arguments (N ?) and results (data to plot ?) to determine)

    % TODO : Translate (or delete) french comments

    N = [13,2,5;    % Override N for testing purpose
         20,2,8;
         10,5,5;
         7,1,22 ]   % video example Remi Bachelet

    i = size(N,2);
    j = size(N,1);

    n = i*j;

    npp=sum(sum(N));

    % Creation of "hand" (i) and "foot" (j) vectors
    Uj=sum(N,1); % column sum
    Ui=sum(N,2); % line sum

    % Creation of frequences matrix (uncorrelated matrix)
    Uij = (Ui.*Uj)/npp;



    % "Matrice des ecarts à l'indépendance" (diff between original and uncorrelated)
    R = N - Uij



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


    % C est un vecteur colonne ? non, mat col*col
    % L est un vecteur ligne ? non, mat row*col



    % Reporter (2 dimensions de L et C ???) dans un tableau (n,2) :
    % L1i L2i
    % C1j L2j
    % todo: tester si Ck*Lk = R ?
    res_row = [ L(:,1) L(:,2) ];
    res_col = [ C(1,:)' C(2,:)' ];


    plot(res_row(:,1), res_row(:,2), '*b', res_col(:,1), res_col(:,2), '*r', 0, 0, '-k');
end

% http://www.math.u-bordeaux.fr/~mchave100p/wordpress/wp-content/uploads/2013/10/AFC.pdf
% https://youtube.com/playlist?list=PL02D3C245C7AAD789
% http://rb.ec-lille.fr/l/Analyse_de_donnees/Analyse_Factorielle_des_Correspondances-AFC.pdf



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