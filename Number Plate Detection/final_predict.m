recObj= audiorecorder(8000, 8, 1); 
disp('Start speaking.') 
recordblocking(recObj,2); 
disp('End of Recording.'); 
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

function g = sigmoid(z)
    g = 1.0 ./ (1.0 + exp(-z)) ;
end


