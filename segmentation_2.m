function segmentation_2(test, sample, denomination_type)
if (denomination_type > 10)
    test = im2double(test);
    if (denomination_type == 50)
        test_lines = imcrop(test, [971.5 1920.5 87 86]);
    elseif (denomination_type == 100)
        test_lines = imcrop(test, [852.5 1867.5 73 109]);
    end
    test_lines = imadjust(rgb2gray(test_lines));
    %test_lines = test_lines - imfilter(test_lines, fspecial('laplacian'));
    %imshow(test_lines);
    %test_lines = imdilate(test_lines, strel('square', 1));
    test_lines = edge(test_lines, 'Sobel');
    imshow(test_lines);
    test_lines = imclose(test_lines, strel('square', 4));
    test_lines = bwareaopen(test_lines, 20);
    test_lines = bwmorph(test_lines, 'bridge');
    test_lines = imfill(test_lines, 'holes');
    %imshow(test_lines);
    [labeledImage, numberOfObject] = bwlabel(test_lines);
    disp(numberOfObject);
    area = 0;
    for i = 1:numberOfObject
        region = labeledImage == i;
        region_props = regionprops(region, 'Area');
        area = area + region_props.Area;
    end
    disp(area);
    
    if (denomination_type == 50)
        if (area > 845 && area < 945 && numberOfObject == 2)
            disp('Legit Bill 2');
        else
            disp('Counterfeit Bill');
        end
    elseif (denomination_type == 100)
        if (area > 1350 && area < 1450 && numberOfObject == 3)
            disp('Legit Bill 2');
        else
            disp('Counterfeit Bill');
        end
    end
    
end

end