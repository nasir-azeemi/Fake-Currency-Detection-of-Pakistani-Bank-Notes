function [output1 output2] = initialize()
global resize;

resize_10 = [size(imread('10_1.jpg'),1) size(imread('10_1.jpg'),2)];
resize_50 = [size(imread('50_1.jpg'),1) size(imread('50_1.jpg'),2)];
resize_100 = [size(imread('100_1.jpg'),1) size(imread('100_1.jpg'),2)];
resize = {resize_10 resize_50 resize_100};
samples = 2;
ten = imresize(double([0]), resize{1});
fifty = imresize(double([0]), resize{2});
hundred = imresize(double([0]), resize{3});

for i=1:samples
    current = im2double(imread(sprintf('10_%d.jpg',i)));
    current = imresize(current, resize{1});
    ten = ten + current;
    
    current = im2double(imread(sprintf('50_%d.jpg', i)));
    current = imresize(current, resize{2});
    fifty = fifty + current;
    
    current = im2double(imread(sprintf('100_%d.jpg',i)));
    current = imresize(current, resize{3});
    hundred = hundred + current;
end

output1 = {ten/samples fifty/samples hundred/samples};

sample2 = {[1262.5 1661.5 206 71] [1173.5 1677.5 213 53] [1055.5 1675.5 210 50]};
to_read = {'10-1.jpg' '50-1.jpg' '100-1.jpg'};
output2 = {[] [] []};
for i=1:3
    test_lines = imcrop(im2double(imread(to_read{i})), sample2{i});
    test_lines = imadjust(rgb2gray(test_lines));
    test_lines = test_lines<=0.33;
    test_lines = edge((test_lines), 'canny');
    test_lines = bwmorph(test_lines, 'bridge');
    test_lines = imfill(test_lines, 'holes');
    test_lines = bwareaopen(test_lines, 22);
    bound = boundaries(test_lines, 8);
    d = cellfun('length', bound);
    [M, N] = size(test_lines);
    final = [];
    for j = 1:size(bound)
        b = bound{j};
        [st, angle] = signature(b);
        final = [final size(angle,1)];
    end
    output2{i} = final;
end

end