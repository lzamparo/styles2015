function [training_set,classes] = extractTraining(L,D)
% L is the labeled examples identified by image number -> L(:3) and object
% number -> L(:,4).
% D is the output from an object table containing at least all the objects
% specified in L.
%
% Extract all the objects in D that appear in L, as well as the
% corresponding class label in L.
[Drow,Dcol] = size(D);
[Lrow,Lcol] = size(L);
training_set = zeros(Lrow,Dcol);
classes = zeros(Lrow,1);
    for j=1:Lrow
        D_row_index = find(D(:,1) == L(j,3) & D(:,2) == L(j,4));
        training_set(j,:) = D(D_row_index,:);
        classes(j) = L(j,1);
    end

end

