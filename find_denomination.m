function output = find_denomination(name, sample)
global resize;
name = im2double(name);
%name = imresize(name, resize);
for image_n = 1:size(sample,2)
    image = sample{image_n};
    percentDiff = [0 0 0];
    for i = 1:3
        name_temp = imresize(name, resize{image_n});
        percentDiff(i) = norm(sample{image_n}(:,:,i) - name_temp(:,:,i));
    end
    if (percentDiff(1) < 30 && percentDiff(2) < 30 && percentDiff(3) < 30)

        switch image_n
            case 1
                output = 10;
            case 2
                output = 50;
            case 3
                output = 100;
        end
        break;
    end
end
fprintf('Currency denomination = %d\n',output);
end