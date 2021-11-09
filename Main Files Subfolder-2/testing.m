% a1=[];
% for i=1:10
   c = 6 ;    
   c = string(c) ;
  

g_final = [] ;
idx_final = [] ;
%lst = ["one";"two";"three";"four";"five";"six";"seven";"eight";"nine";"zero"] ;
lst = ["convolution", "correlation", "covariance"];
%[x1,fs] = audioread('seven'+d+'_oitijjho.wav') ;
for i=11:20
    h_final = [] ;
    for j = 1:3
         
         d = i ;
         d = string(d) ;
         [x1,fs] = audioread('three'+d+'_oitijjho.wav') ;
         [x2,fs] = audioread(lst(j)+c+'_oitijjho.wav') ;
         h1 = autocorr(x1) ;
         h2 = autocorr(x2) ;
         h = corr2(h1,h2) ;
         h_final = [h_final ;h] ;
    end
    idx = find(h_final==max(h_final)) ;
    g_final = [g_final h_final] ;
    idx_final=[idx_final ; idx] ;
end



% recObj = audiorecorder(8000, 8, 1) ; 
% pause on 
% disp('Start speaking....') ;
% recordblocking(recObj, 2) ; 
% disp('End of Recording...') ; 
% y = getaudiodata(recObj) ;

%  a = autocorr(x1) ;
%     a1 = [a1 abs(a)] ;
% b1 = autocorr(y);
% b1(5)
% result = xcorr(a,b) ;
% mac = max(result) ;
% 
% % 
% a = mfcc(x1,fs) ;
% b = mfcc(y,fs) ;
% m_m = corr2(a,b) ;
% 
% a = spectralCentroid(x1,fs) ;
% a(isnan(a))=0 ;
% b = spectralCentroid(y,fs) ;
% b(isnan(b))=0 ;
% msc = max(xcorr(a,b)) ;

