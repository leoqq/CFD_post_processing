fid=fopen('yistart_temp.txt','wt');
A = yistart(:,60);
B = yistart(:,57);
A1=table2array(A);
B1=table2array(B);

fprintf(fid, '%f %f \n', [A1,B1]');
fclose(fid);