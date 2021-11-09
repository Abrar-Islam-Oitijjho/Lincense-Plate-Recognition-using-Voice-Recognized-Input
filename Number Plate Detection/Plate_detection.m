%close all;
%clear all;

im = imread('Number Plate Images/image2.png');      %read the input image%input image can be chnage here
%imshow(im)
imgray = rgb2gray(im);                              %convert from rgb to gray
%imshow(imgray)
imbin = imbinarize(imgray);                         %creating a binary array
%imshow(imbin)
im = edge(imgray, 'prewitt');                       %detecting edge to find out the plate protion
%imshow(im);

%Below steps are to find location of number plate
%using the edge portion and regionprops,finding the plate portion
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    

im = imcrop(imbin, boundingBox);%crop the number plate area
imshow(im);
figure;
im = bwareaopen(~im, 250);%remove some object if it width is too long or too small than 500
[h, w] = size(im);%get width

%imshow(im);

Iprops=regionprops(im,'BoundingBox','Area', 'Image'); %read letter
count = numel(Iprops);
noPlate=[]; % Initializing the variable of number plate string.

 
%Below steps are to find the letters in the plate portion
for i=1:count
   ow = length(Iprops(i).Image(1,:));       
   oh = length(Iprops(i).Image(:,1));
   if ow<(h/2) & oh>(h/3)              %assumimg the width and height of the letter compare to the plate
       letter=Letter_detection(Iprops(i).Image); % Reading the letter corresponding the binary image 'N'.
       
       noPlate=[noPlate letter]; % Appending every subsequent character in noPlate variable.
   end
end
noPlate