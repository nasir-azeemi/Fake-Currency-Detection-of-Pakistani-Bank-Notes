function main()
global resize;
global sample;
[sample sample2] = initialize();
test = imread('50_1.jpg');
test2 = imread('50-4.jpg');
denomination_type = find_denomination(test, sample);
segmentation(test, sample, denomination_type);
segmentation_2(test2, sample, denomination_type);
segmentation_3(test2, sample, denomination_type);
segmentation_4(test2, sample2, denomination_type);

%segmentation_5(test2, denomination_type);

end

    