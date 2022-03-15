function segmentation_3(test, sample, denomination_type)
if (denomination_type > 10)
    test = im2double(test);
    if (denomination_type == 50)
        test_lines = imcrop(test, [686.5 1325.5 69 791]);
    elseif (denomination_type == 100)
        test_lines = imcrop(test, [575.5 1307.5 45 785]);
        
        
    end
    test_lines = imadjust(rgb2gray(test_lines));
    %test_lines = imfilter(test_lines, [0 -1 0; -1 5 -1; 0 -1 0]);
    %imshow(test_lines);
    test_lines = edge(test_lines, 'Sobel');
    %imshow(test_lines);
    test_lines = imclose(test_lines, strel('square', 4));
    test_lines = bwmorph(test_lines, 'bridge');
    test_lines = imfill(test_lines, 'holes');
    test_lines = imdilate(test_lines, strel('square', 4));
    test_lines = imfill(test_lines, 'holes');
    [l, n] = bwlabel(test_lines);
    %figure, imshow(test_lines);
    disp(n);
    if (n == 34)
       disp('Legit currency bill 3');
    else
        disp('Counterfeit Bill');
    end
    
end

end