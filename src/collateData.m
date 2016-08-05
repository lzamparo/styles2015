function [tSet,index,Lindex] = collateData(L,D)
% L is the training set data labeled by KF
% D is the data gathered from a screen (RAD52 in this case)
% L and D have both image and object labels.  Each row is an object
% Extract all the objects in D that appear in L, as well as the
% class label in L, and return this set as tSet
[Drow,Dcol] = size(D);
[Lrow,Lcol] = size(L);
tSet = zeros(Lrow,Dcol+1);
index = false(Drow,1);
Lindex = false(Lrow,1);
Dindex = 1;
for i=1:Drow
    for j=1:Lrow
        if (D(i,1) == L(j,3) && D(i,2) == L(j,4))
            index(i) = true;
            Lindex(j) = true;
            labledObject = [L(j,1),D(i,:)];
            tSet(Dindex,:) = labledObject;
            Dindex = Dindex + 1;
        end
    end        
end

end
