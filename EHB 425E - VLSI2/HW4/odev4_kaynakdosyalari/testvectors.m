fid = fopen('test_vectors.txt', 'w'); % Open the file for writing
for A = 2:2^16
    for B = 2:2^16
        if (A^B > 2^16-1)
            break;
        end
        AB_array(A-1,1) = uint16(A);
        AB_array(A-1,2) = uint16(B-1);
        AB_array(A-1,3) = uint16(A^(B-1));
    end
end

% Print the output to the file
for i = 1:size(AB_array, 1)
    fprintf(fid, '%d\t%d\t%d\n', AB_array(i,1), AB_array(i,2), AB_array(i,3));
end

fclose(fid); % Close the file
