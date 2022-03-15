function segmentation(test, sample, denomination_type)

global resize;
test = im2double(test);

if (denomination_type == 10)
    test_c = imcrop(test, [258.5 65.5 327 277]);
    diff = imcrop(sample{1}, [258.5 65.5 327 277]);
elseif (denomination_type == 50)
    test_c = imcrop(test, [244.5 65.5 381 282]);
    diff = imcrop(sample{2}, [244.5 65.5 381 282]);
elseif (denomination_type == 100)
    test_c = imcrop(test, [242.5 48.5 330 306]);
    diff = imcrop(sample{3}, [242.5 48.5 330 306]);
end

difference = 0;

for i = 1:3
    difference = difference + norm(diff(:,:,i) - test_c(:,:,i));
end

difference = difference / 3;
disp(difference);

if (difference < 7)
    disp('Legit currency bill');
else
    disp('Counterfeit bill');
end

end