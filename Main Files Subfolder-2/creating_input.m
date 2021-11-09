final_ac = [] ;
lst = ["one";"two";"three";"four";"five";"six";"seven";"eight";"nine";"zero"] ;
for i=1:10
    for j=1:80
        c = j ;
        c = string(c) ;
        [x1,fs] = audioread(lst(i)+c+'_oitijjho.wav') ;
        x2 = x1 + rand(length(x1),1).*0.1 ;
        %x3 = x1 + rand(length(x1),1).*0.1 ;
        %x4 = x1 + rand(length(x1),1).*0.1 ;
        
        ac = autocorr(x1) ;
        ac2 = autocorr(x2) ;
        ac3 = autocorr(x3) ;
        ac4 = autocorr(x4) ;
        ac = ac(2:21) ;
        ac2 = ac2(2:21) ;
        %ac3 = ac3(2:21) ;
        %ac4 = ac4(2:21) ;
        final_ac = [final_ac ac ac2 ] ; 
    end
end

%  lst_extra = ["two";"three";"seven";"eight";"zero"] ;
%  
%  for i=1:5
%      for j=41:60
%         c = j ;
%         c = string(c) ;
%         [x1,fs] = audioread(lst_extra(i)+c+'_oitijjho.wav') ;
%         x2 = x1 + rand(length(x1),1).*0.1 ;
%         x3 = x1 + rand(length(x1),1).*0.1 ;
%         ac = autocorr(x1) ;
%         ac2 = autocorr(x2) ;
%         ac3 = autocorr(x3);
%         ac = ac(2:21) ;
%         ac2 = ac2(2:21) ;
%         ac3 = ac3(2:21) ;
%         final_ac = [final_ac ac ac2 ac3] ; 
%      end
%  end
 