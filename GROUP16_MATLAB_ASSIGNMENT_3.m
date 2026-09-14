% Clear workspace and close figures
clear; clc; close all;

% Initialize Structure Array
leaves = struct();
% 1. pawpaw leaf

leaves(1).Name = 'pawpaw Leaf';
leaves(1).Biology = struct( 'Class','Dicotyledonous','Type','simple(deeply lobed','Venation','Palmate','Margin','lobed','Apex','Acute');                                                                                           
leaves(1).OriginalImage = imread("C:/images/pawpaw leaf.jpg");
leaves(1).Processed.Gray = rgb2gray(leaves(1).OriginalImage);
leaves(1).Processed.Binary = ~imbinarize(leaves(1).Processed.Gray); % Invert if leaf is darker than background
leaves(1).Processed.Edges = edge(leaves(1).Processed.Gray, 'Canny');

stats1 = regionprops(leaves(1).Processed.Binary, 'Area', 'Perimeter', 'Eccentricity');
leaves(1).Measurements = struct( 'Area_Pixels', stats1(1).Area,'Perimeter_Pixels', stats1(1).Perimeter,'Eccentricity', stats1(1).Eccentricity);

% 2. beans leaf

leaves(2).Name = 'bean Leaf';
leaves(2).Biology = struct('Class','Dicotyledonous','Type','compound','Venation','reticulate','Margin','Entire (smooth)','Apex', 'Acute');
leaves(2).OriginalImage = imread("C:/images/bean leaf.jpg");
leaves(2).Processed.Gray = rgb2gray(leaves(2).OriginalImage);
leaves(2).Processed.Binary = ~imbinarize(leaves(2).Processed.Gray);
leaves(2).Processed.Edges = edge(leaves(2).Processed.Gray, 'Canny');

stats2 = regionprops(leaves(2).Processed.Binary, 'Area', 'Perimeter', 'Eccentricity');
leaves(2).Measurements = struct('Area_Pixels', stats2(1).Area,'Perimeter_Pixels', stats2(1).Perimeter,'Eccentricity', stats2(1).Eccentricity);
% 3. Maize leaf
leaves(3).Name = 'Maize Leaf';
leaves(3).Biology = struct('Class', 'Monocotyledonous','Type', 'Simple / Linear','Venation', 'Parallel','Margin', 'Entire','Apex', 'Tapered / Acute');
leaves(3).OriginalImage = imread("C:/images/maize leaf.jpg");
leaves(3).Processed.Gray = rgb2gray(leaves(3).OriginalImage);
leaves(3).Processed.Binary = ~imbinarize(leaves(3).Processed.Gray);
leaves(3).Processed.Edges = edge(leaves(3).Processed.Gray, 'Canny');

stats3 = regionprops(leaves(3).Processed.Binary, 'Area', 'Perimeter', 'Eccentricity');
leaves(3).Measurements = struct('Area_Pixels', stats3(1).Area,'Perimeter_Pixels', stats3(1).Perimeter,'Eccentricity', stats3(1).Eccentricity);
% 4. guava leaf

leaves(4).Name = 'guava Leaf';
leaves(4).Biology = struct('Class', 'Dicotyledonous','Type', 'simple','Venation', 'Reticulate Pinnate','Margin', 'Entire(smooth)','Apex', 'Acute to obtuse');
leaves(4).OriginalImage = imread("C:/images/guava leaf.jpg");
leaves(4).Processed.Gray = rgb2gray(leaves(4).OriginalImage);
leaves(4).Processed.Binary = ~imbinarize(leaves(4).Processed.Gray);
leaves(4).Processed.Edges = edge(leaves(4).Processed.Gray, 'Canny');

stats4 = regionprops(leaves(4).Processed.Binary, 'Area', 'Perimeter', 'Eccentricity');
leaves(4).Measurements = struct('Area_Pixels', stats4(1).Area,'Perimeter_Pixels', stats4(1).Perimeter,'Eccentricity', stats4(1).Eccentricity);

% DISPLAY RESULTS IN A 4x4 IMAGE GRID

figure('Name', 'Leaf Image Processing Results', 'NumberTitle', 'off');
for k = 1:4
    % Original Image
    subplot(4, 4, (k-1)*4 + 1);
    imshow(leaves(k).OriginalImage);
    title([leaves(k).Name, ' (Original)']);
    
    % Grayscale Image
    subplot(4, 4, (k-1)*4 + 2);
    imshow(leaves(k).Processed.Gray);
    title('Grayscale');
    
    % Binary Mask
    subplot(4, 4, (k-1)*4 + 3);
    imshow(leaves(k).Processed.Binary);
    title('Binarized');
    
    % Canny Edges
    subplot(4, 4, (k-1)*4 + 4);
    imshow(leaves(k).Processed.Edges);
    title('Edge Detection');
end

imwrite(leaves(1).Processed.Gray,'pawpaw_gray.jpg')
imwrite(leaves(1).Processed.Binary,'pawpaw_binary.jpg')
imwrite(leaves(1).Processed.Edges,'pawpaw_edge.jpg')

imwrite(leaves(2).Processed.Gray,'bean_gray.jpg')
imwrite(leaves(2).Processed.Binary,'bean_binary.jpg')
imwrite(leaves(2).Processed.Edges,'bean_edge.jpg')

imwrite(leaves(3).Processed.Gray,'maize_gray.jpg')
imwrite(leaves(3).Processed.Binary,'maize_binary.jpg')
imwrite(leaves(3).Processed.Edges,'maize_edge.jpg')

imwrite(leaves(4).Processed.Gray,'guava_gray.jpg')
imwrite(leaves(4).Processed.Binary,'guava_binary.jpg')
imwrite(leaves(4).Processed.Edges,'guava_edge.jpg')