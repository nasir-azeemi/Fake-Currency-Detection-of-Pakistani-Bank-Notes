function segmentation_5(test, denomination_type)
if (denomination_type > 10)
    %test = im2double(test);
    if (denomination_type == 50)
        test_lines = imcrop(test, [1974.5 1547.5 185 268]);
    elseif (denomination_type == 100)
        test_lines = imcrop(test, [1845.5 1513.5 182 311]); 
    end
    %figure, imshow(test_lines);
    ff = imrotate(test_lines, -91);
    ff_g = rgb2gray(ff);
    ff_a = imadjust(ff_g);
    sobel_h = fspecial('sobel');
    ff_1 = imfilter(ff_a, sobel_h);
    ff_bw = ff_1 == 255;
    str_el = strel('line',3,0);
    ff_op = imopen(ff_bw,str_el);
    %figure, imshow(ff_op);
    ff_re = imreconstruct(ff_op,ff_bw);
    ff_inv = ff_re == 0;
    f = imopen(ff_inv, strel('disk',8));
    f = imclose(f, strel('disk',10));
    %figure, imshow(f);
end