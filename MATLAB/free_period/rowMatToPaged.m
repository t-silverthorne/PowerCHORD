function Apaged = rowMatToPaged(A,pdim)
%ROWMATTOPAGED convert an m x n matrix into a n x 1 x ... x m paged array
%       (i.e. store one row of A per page) 
sz     = [1,size(A,2),ones(1,pdim-3),size(A,1)];
Apaged = reshape(A',sz);
end

