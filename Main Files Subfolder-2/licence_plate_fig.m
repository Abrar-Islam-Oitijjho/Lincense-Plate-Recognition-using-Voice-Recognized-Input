function varargout = licence_plate_fig(varargin)
% LICENCE_PLATE_FIG MATLAB code for licence_plate_fig.fig
%      LICENCE_PLATE_FIG, by itself, creates a new LICENCE_PLATE_FIG or raises the existing
%      singleton*.
%
%      H = LICENCE_PLATE_FIG returns the handle to a new LICENCE_PLATE_FIG or the handle to
%      the existing singleton*.
%
%      LICENCE_PLATE_FIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LICENCE_PLATE_FIG.M with the given input arguments.
%
%      LICENCE_PLATE_FIG('Property','Value',...) creates a new LICENCE_PLATE_FIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before licence_plate_fig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to licence_plate_fig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help licence_plate_fig

% Last Modified by GUIDE v2.5 15-Jul-2020 19:38:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @licence_plate_fig_OpeningFcn, ...
                   'gui_OutputFcn',  @licence_plate_fig_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before licence_plate_fig is made visible.
function licence_plate_fig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to licence_plate_fig (see VARARGIN)

% Choose default command line output for licence_plate_fig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes licence_plate_fig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = licence_plate_fig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_enter_image.
function pushbutton_enter_image_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%close all;
%clear all;  


%x=get(handles.text_im_input,'string')


    
    

imag=get(handles.text_im_input,'string');
bb="Number Plate Images/image"+imag;
cc=bb+".png";

axes(handles.axes1)
smileg=imread(cc);
image(smileg);
axis off
axis image


im = imread(cc);      %read the input image%input image can be chnage here
imgray = rgb2gray(im);                              %convert from rgb to gray
imbin = imbinarize(imgray);                         %creating a binary array
im = edge(imgray, 'prewitt');                       %detecting edge to find out the plate protion

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
%imshow(im);
%figure;
im = bwareaopen(~im, 250);%remove some object if it width is too long or too small than 500
[h, w] = size(im);%get width

%imshow(im);

axes(handles.axes2)
%smileg=imread(cc);
imshow(im);
axis off
axis image


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
aa=string(noPlate);
set(handles.text_im_output,'string',aa);


function letter=readLetter(snap)

load NewTemplates                  %load the image from the file
snap=imresize(snap,[42 24]);       %reshape the input image
rec=[ ];

%%correlate with all letter & number images to find out the best match
for n=1:24:length(NewTemplates)
    cor=corr2(NewTemplates(:,n:(n+23)),snap);
    rec=[rec cor]; 
end

ind=find(rec==max(rec));         %find the best match


% Alphabets listings.
if ind==1 
    letter='A';
elseif ind==2
    letter='B';
elseif ind==3
    letter='C';
elseif ind==4
    letter='D';
elseif ind==5
    letter='E';
elseif ind==6
    letter='F';
elseif ind==7
    letter='G';
elseif ind==8
    letter='H';
elseif ind==9
    letter='I';
elseif ind==10
    letter='J';
elseif ind==11
    letter='K';
elseif ind==12
    letter='L';
elseif ind==13
    letter='M';
elseif ind==14
    letter='N';
elseif ind==15
    letter='O';
elseif ind==16
    letter='P';
elseif ind==17
    letter='Q';
elseif ind==18
    letter='R';
elseif ind==19
    letter='S';
elseif ind==20
    letter='T';
elseif ind==21
    letter='U';
elseif ind==22
    letter='V';
elseif ind==23
    letter='W';
elseif ind==24
    letter='X';
elseif ind==25
    letter='Y';
elseif ind==26
    letter='Z';
    %*-*-*-*-*
% Numerals listings.
elseif ind==27
    letter='1';
elseif ind==28
    letter='2';
elseif ind==29
    letter='3';
elseif ind==30
    letter='4';
elseif ind==31
    letter='5';
elseif ind==32
    letter='6';
elseif ind==33
    letter='7';
elseif ind==34
    letter='8';
elseif ind==35
    letter='9';
elseif ind==36
    letter='0';

end


% --- Executes on button press in pushbutton_template.
function pushbutton_template_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%CREATE TEMPLATES 
%Alphabets
%read all the letters from images
A=imread('alpha/A.bmp');B=imread('alpha/B.bmp');C=imread('alpha/C.bmp');
D=imread('alpha/D.bmp');E=imread('alpha/E.bmp');F=imread('alpha/F.bmp');
G=imread('alpha/G.bmp');H=imread('alpha/H.bmp');I=imread('alpha/I.bmp');
J=imread('alpha/J.bmp');K=imread('alpha/K.bmp');L=imread('alpha/L.bmp');
M=imread('alpha/M.bmp');N=imread('alpha/N.bmp');O=imread('alpha/O.bmp');
P=imread('alpha/P.bmp');Q=imread('alpha/Q.bmp');R=imread('alpha/R.bmp');
S=imread('alpha/S.bmp');T=imread('alpha/T.bmp');U=imread('alpha/U.bmp');
V=imread('alpha/V.bmp');W=imread('alpha/W.bmp');X=imread('alpha/X.bmp');
Y=imread('alpha/Y.bmp');Z=imread('alpha/Z.bmp');

%Natural Numbers
one=imread('alpha/1.bmp');two=imread('alpha/2.bmp');
three=imread('alpha/3.bmp');four=imread('alpha/4.bmp');
five=imread('alpha/5.bmp'); six=imread('alpha/6.bmp');
seven=imread('alpha/7.bmp');eight=imread('alpha/8.bmp');
nine=imread('alpha/9.bmp'); zero=imread('alpha/0.bmp');


%Creating Array for Alphabets
letter=[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z];
%Creating Array for Numbers
number=[one two three four five six seven eight nine zero ];

NewTemplates=[letter number];
 
save ('NewTemplates','NewTemplates')
%clear all


% --- Executes on button press in pushbutton_1.
function pushbutton_1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old=get(handles.text_im_input,'string');
new=('1');
new1=strcat(old,new);           % add two different strings
set(handles.text_im_input,'string',new1);


% --- Executes on button press in pushbutton_2.
function pushbutton_2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old=get(handles.text_im_input,'string');
new=('2');
new1=strcat(old,new);           % add two different strings
set(handles.text_im_input,'string',new1);

% --- Executes on button press in pushbutton_3.
function pushbutton_3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old=get(handles.text_im_input,'string');
new=('3');
new1=strcat(old,new);           % add two different strings
set(handles.text_im_input,'string',new1);

% --- Executes on button press in pushbutton_4.
function pushbutton_4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old=get(handles.text_im_input,'string');
new=('4');
new1=strcat(old,new);           % add two different strings
set(handles.text_im_input,'string',new1);

% --- Executes on button press in pushbutton_5.
function pushbutton_5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old=get(handles.text_im_input,'string');
new=('5');
new1=strcat(old,new);           % add two different strings
set(handles.text_im_input,'string',new1);

% --- Executes on button press in pushbutton_6.
function pushbutton_6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old=get(handles.text_im_input,'string');
new=('6');
new1=strcat(old,new);           % add two different strings
set(handles.text_im_input,'string',new1);

% --- Executes on button press in pushbutton_7.
function pushbutton_7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old=get(handles.text_im_input,'string');
new=('7');
new1=strcat(old,new);           % add two different strings
set(handles.text_im_input,'string',new1);

% --- Executes on button press in pushbutton_8.
function pushbutton_8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old=get(handles.text_im_input,'string');
new=('8');
new1=strcat(old,new);           % add two different strings
set(handles.text_im_input,'string',new1);

% --- Executes on button press in pushbutton_9.
function pushbutton_9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old=get(handles.text_im_input,'string');
new=('9');
new1=strcat(old,new);           % add two different strings
set(handles.text_im_input,'string',new1);

% --- Executes on button press in pushbutton_0.
function pushbutton_0_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old=get(handles.text_im_input,'string');
new=('0');
new1=strcat(old,new);           % add two different strings
set(handles.text_im_input,'string',new1);



function pushbutton_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
new='';
set(handles.text_im_input,'string',new);
set(handles.text_im_output,'string',new);
arrayfun(@cla,findall(0,'type','axes')) ;


% --- Executes on button press in pushbutton_speak.
function pushbutton_speak_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_speak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta11 = load('t11') ;
theta22 = load('t22') ;
theta1=theta11.theta1 ;
theta2=theta22.theta2 ;
recObj= audiorecorder(8000, 8, 1); 
set(handles.text_speech,'string','Start speaking');

%disp('Start speaking.') 
recordblocking(recObj,2); 
set(handles.text_speech,'string','End of Recording');
%disp('End of Recording.'); 
new = getaudiodata(recObj); 

new = autocorr(new) ;
new = new(2:21);
new = new' ;


a1 = [1 new] ;
a1 = a1' ;
z2 = theta1*a1 ; 
a2 = sigmoid(z2) ;
a2 = [1 ;a2];
z3 = theta2*a2 ;
a3 = sigmoid(z3) ;
h = a3 ;
idx=find(h==max(h));
set(handles.text_im_input,'string',string(idx));
%setappdata(0,'c',idx);
%x=getappdata(0,'in1'); setappdata(0,'in1',old);



function g = sigmoid(z)
    g = 1.0 ./ (1.0 + exp(-z)) ;
