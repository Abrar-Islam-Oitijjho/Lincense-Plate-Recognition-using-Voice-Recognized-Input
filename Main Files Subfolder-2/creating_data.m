recObj= audiorecorder(8000, 8, 1); 
c=0;

for i=1:20
    c=i+60
    c=string(c);
    pause on 
   
    disp('Start speaking....'+c) ;
    recordblocking(recObj, 2); 
    disp('End of Recording...'+c); 
    y = getaudiodata(recObj); 
  
    filename = 'eight'+c+'_oitijjho.wav'; 
    audiowrite(filename, y, 8000) ;
    pause off 
    
end
% pause on
% disp('Start speaking....'+c) ;
% recordblocking(recObj, 2); 
% disp('End of Recording...'+c); 
% y = getaudiodata(recObj);
% filename = 'five16_oitijjho.wav'; 
% audiowrite(filename, y, 8000) ;
% pause off





%recObj= audiorecorder(8000, 8, 1); 
% pause on 
% disp('Start speaking.') 
% recordblocking(recObj, 2); 
% disp('End of Recording.'); 
% y = getaudiodata(recObj); 
% filename = 'light.wav'; 
% audiowrite(filename, y, 8000) 
% pause off 
%  
% recObj= audiorecorder(8000, 8, 1); 
% pause on 
% disp('Start speaking.') 
% recordblocking(recObj, 2); 
% disp('End of Recording.'); 
% y1 = getaudiodata(recObj); 
% filename = 'dark.wav'; 
% audiowrite(filename, y1, 8000) 
% pause off 