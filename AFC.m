%% AFC.m 
% Use factorial analysis (ACF) "through multiple correspondence analysis (ACM)" (?)
% And plot ACF results to determine correlations that may exist between the characteristics of a country and the colours of its flag
% 
% TODO : Translate (or delete) french comments
function AFC(N, row_labels, col_labels) % TODO : (arguments (N ?) and results (data to plot ?) to determine)
    
    % Testing/Debug examples
%     col_labels = {'1', '2', '3'}; 
%     row_labels = {'A', 'B', 'C'};
%     N = [1,3,5;    % Override N for testing purpose
%          1,8,6;
%          4,1,1 ]   % video example of J.Dabounou
    
%     row_labels = {'A', 'B', 'C', 'D'};
%     col_labels = {'1', '2', '3'};
%     N = [13,2,5;    % Override N for testing purpose
%          20,2,8;
%          10,5,5;
%          7,1,22 ];   % from Remi Bachelet video example

    [j, i] = size(N);
    
    n = i*j;

    npp=sum(sum(N));

    % Creation of "hand" (i) and "foot" (j) vectors
    Nj=sum(N,1); % column sum
    Ni=sum(N,2); % line sum

    % Creation of frequences matrix (uncorrelated matrix)
    Uij = (Ni.*Nj)/npp;
    
    % Probability matrix (idem to frequence mat)
    P = N/npp

    
    % Creation of row and colums profiles
    Uj=sum(P,1) % column sum
    Ui=sum(P,2) % line sum

    % Row/Colums profiles diagonalization
    Dmain = diag(Ui);
    Dpied = diag(Uj);
    
    
    % "Matrice des ecarts à l'indépendance" (diff between original and uncorrelated)
    R = N - Uij;


    disp("Mesure du Khi² : ");
    % J column correlation quantity
    Khi2 = getKi2vec(Uij, N)
    

    % X_ ("X barre") = "weighed khi²-distance"
    X_ = (Dmain^(-1/2)) * (P-(Ui.*Uj)) * (Dpied^(-1/2))
    % S_  ("S barre" : "correspondrait à la matrice de var-cov ou de correlation")
    S_ = X_' * X_
    
    
    % Eigval and Eigvect of S_
    [EVec, EVal] = eig(S_);
    EVec
    e=diag(EVal);
    [EVal, I] = sort(e, 'descend')
    % EVal = diag(e)
    
    disp(EVec*I)
    
    % Compute principal line components
    F_ = X_ * EVec                      % TO DEBUG: F(:,1) seems to always be a 0 vec !!!!
    
    
    % Compute principal row components
    for s=1:rank(S_)+1                  % not sure if +1 is a good idea...
        G_(:,s) = sqrt(EVal(s)) * EVec(:,s);
    end
    
    G_  % debug display

    
    %% From "Cours"
%     V = cov(N); % or cov(X) ?
%     [E, D] = eig(V);
%     d=diag(D);
%     [d, I] = sort(d, 'descend');
%     D = diag(d);

    % "Ces formules proviennent du cours mais nous n'avons pas su les exploiter..."
%     L = sqrt(npp) * Dmain^(-1) * N * Dpied^(-1/2) * E     % mat col*col correspondant à ???
%     C = sqrt(n-1) * Dpied^(-1/2) * E * D^(1/2)            % mat row*col correspondant à ???

    
    %% "Affichage final"
    res_row = [ F_(:,1) F_(:,2) ];
    res_col = [ G_(1,:)' G_(2,:)' ];

    % TODO : display saved/total information on axes !!! (the distribution of
    % information along the different axes (represented by eigenvalues ? inertia ?)
    plot(res_row(:,1), res_row(:,2), '*b', res_col(:,1), res_col(:,2), '+r', 0, 0, '-k');
    
    % Display labels
    text(res_row(:,1)+.002, res_row(:,2)+.002, row_labels, 'Color', [0 0 1]);
    text(res_col(:,1)+.002, res_col(:,2)+.002, col_labels, 'Color', [1 0 0]);
end



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