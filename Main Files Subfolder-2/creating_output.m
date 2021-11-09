y=[] ;
for i=1:9
    for j=1:160
        y=[y; i];
    end
end

y=[y; ones(160,1)*10];
y_new = zeros(160,10) ;

for i = 1:1600
    y_new(i,y(i)) = 1;
end
% 
% y_extra=[] ;
% for i=[2,3,7,8,10]
%     for j=1:60
%         y_extra=[y_extra; i];
%     end
% end
% 
% y_new_extra=zeros(300,10);
% 
% for i=1:300
%     y_new_extra(i,y_extra(i)) = 1;
% end
% 
% y_new=[y_new ;y_new_extra] ;
    
