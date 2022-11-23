% create an interesting surface
[X,Y] = meshgrid(-15:0.5:10,-10:0.5:10);
Z = (X.^2-Y.^2)';
% find saddle points
ind = saddle2(Z);
% plot surface
surf(Z);
hold on
% mark saddle points with red dots in the same figure
for ii = 1:size(ind,1)
    h = scatter3(ind(ii,2),ind(ii,1),Z(ind(ii,1),ind(ii,2)),'red','filled');
    h.SizeData = 120;
end
% adjust viewpoint
view(-115,14);
hold off

%saddle2 function

function indices= saddle2(M)
[row col]=size(M);
ind=0;
%checking when input is a row vector
if row==1
    for c=1:col
    ref=M(c);
        max=ref;
        max_col_ind=c;
        for m=1:col
           if M(1,m)>=max
            max=M(1,m);
            max_col_ind=m;
           end
        end
    end
    ind=ind+1;
    indices(ind,1)=1;
    indices(ind,2)=max_col_ind;
    %checking for more than one saddle points
    for i=1:col
        if M(1,i)==max && i~=max_col_ind
            ind=ind+1;
            indices(ind,1)=1;
            indices(ind,2)=i;
        end
    end           
%checking when input is a column vector
elseif col==1
    for r=1:row
    ref=M(r);
        min=ref;
        min_row_ind=r;
        for n=1:row
           if M(n,1)<=min
            min=M(n,1);
            min_row_ind=n;
           end
        end
    end
    ind=ind+1;
    indices(ind,1)=min_row_ind;
    indices(ind,2)=1;
    %checking for more than one saddle points 
    for i=1:row
        if M(i,1)==min && i~=min_row_ind
            ind=ind+1;
            indices(ind,1)=i;
            indices(ind,2)=1;
        end
    end
%checking when input is zeros or ones
elseif isequal(M,zeros(row,col)) || isequal(M,ones(row,col))
    for i=1:row
        for j=1:col
            ind=ind+1;
            indices(ind,1)=i;
            indices(ind,2)=j;
        end
    end
%checking when input is a matrix
else
for i=1:row
    for j=1:col
        ref=M(i,j);
        %checking through row elements
        max=ref;
        max_row_ind=i;
        max_col_ind=j;
        for l=1:col
            if j==l
                continue;
            elseif M(i,l)>=max
                    max=M(i,l);
                    max_row_ind=i;
                    max_col_ind=l;
            else
            end
        end
        ref_vec_max=[max_row_ind max_col_ind];
        num1=1;
        for p=1:col
            if p==max_col_ind
                continue;
            elseif M(i,p)==max
                num1=num1+1;               
                ref_vec_max(num1,1)=max_row_ind;
                ref_vec_max(num1,2)=p;
            else
            end
        end
  %checking through column elements
        min=ref;
        min_row_ind=i;
        min_col_ind=j;
        for k=1:row
            if i==k
                continue;
            elseif M(k,j)<=min
                    min=M(k,j);
                    min_row_ind=k;
                    min_col_ind=j;
            else
            end
        end
        ref_vec_min=[min_row_ind min_col_ind];
        num2=1;
        for q=1:row
            if q==min_row_ind
                continue;
            elseif M(q,j)==min
                num2=num2+1;
                ref_vec_min(num2,1)=q;
                ref_vec_min(num2,2)=min_col_ind;
            else
            end
        end
        %comparing max and min matrices
        size_max=size(ref_vec_max,1);
        size_min=size(ref_vec_min,1);
        for a=1:size_max
            for b=1:size_min
                if ref_vec_max(a,1)==ref_vec_min(b,1) && ref_vec_max(a,2)==ref_vec_min(b,2)
                ind=ind+1;
                indices(ind,1)=ref_vec_max(a,1);
                indices(ind,2)=ref_vec_max(a,2);
                end
            end
        end
    end
end
end
if ind==0
    indices=[];
end
end