function segmentation_4(test, sample, denomination_type)

test = im2double(test);

if (denomination_type == 10)
    test_lines = imcrop(test, [1262.5 1661.5 206 71]);
    sample = sample{1};
elseif (denomination_type == 50)
    test_lines = imcrop(test, [1173.5 1677.5 213 53]);
    sample = sample{2};
elseif (denomination_type == 100)
    test_lines = imcrop(test, [1055.5 1675.5 210 50]);
    sample = sample{3};
end

sig = imadjust(rgb2gray(test_lines));
sig = sig<=0.33;
test_lines = edge((sig), 'canny');
test_lines = bwmorph(test_lines, 'bridge');
test_lines = imfill(test_lines, 'holes');
img_test = bwareaopen(test_lines, 22);

%figure, imshow(img_test);
bound = boundaries(img_test, 8);
d = cellfun('length', bound);
[M, N] = size(img_test);

final = [];
for i = 1:size(bound)
    b = bound{i};
    [st, angle] = signature(b);
    final = [final size(angle,1)];
    
    plot(angle, st);

end
diff = 0;
for i=1:min(size(final, 2),size(sample, 2))
    diff = diff + abs(final(i) - sample(i));
end
diff = diff / min(size(final, 2),size(sample, 2));
disp(diff);
if ((min(size(final, 2),size(sample, 2)) == 9 || min(size(final, 2),size(sample, 2)) == 10) && diff < 50)
    disp('Legit Bill 4');
else
    disp('Counterfeit Bill 4');
end
end

