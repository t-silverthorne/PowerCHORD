function [wa, wb, wc, wd, we] = getSymm4Weights_fixed(n)
    % Number of tuples in each mask (you must have masks computed already)
    % For now, use exact combinatorial formulas:
    Na = n*(n-1)*(n-2)*(n-3);           % Type A
    Nb = 6*n*(n-1)*(n-2);               % Type B
    Nc = 6*nchoosek(n,2);               % Type C
    Nd = 4*n*(n-1);                     % Type D
    Ne = n;                            % Type E

    % Number of distinct permutations in each orbit (from group theory)
    % For 4 elements, the stabilizer sizes correspond to:
    Sa = 1;        % all distinct
    Sb = 2;        % one pair
    Sc = 2*2;      % two pairs (product of 2-cycles)
    Sd = 3;        % triple + single
    Se = 4;        % all equal

    % Total group size = 24 (4!)
    group_size = factorial(4);

    % Orbit sizes = group_size / stabilizer size
    Wa = group_size / Sa;
    Wb = group_size / Sb;
    Wc = group_size / Sc;
    Wd = group_size / Sd;
    We = group_size / Se;

    % Now weights are ratio of orbit size to mask size to correct double counting
    wa = Wa / Na;
    wb = Wb / Nb;
    wc = Wc / Nc;
    wd = Wd / Nd;
    we = We / Ne;
end