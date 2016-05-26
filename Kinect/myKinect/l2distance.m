function D=l2distance(X,Z)
if (nargin==1) 
    G = X'*X; 
    S = repmat(diag(G),1,size(X,2)); 
    R = transpose(S);
    D = sqrt(S-2*G+R);
else  
	G = X'*Z; 
    S = repmat(diag(X'*X),1,size(Z,2));
    R = transpose(repmat(diag(Z'*Z),1,size(X,2)));
    D = sqrt(S-2*G+R);
end;



