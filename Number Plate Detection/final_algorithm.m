x = final_ac' ;

eps = 0.01 ;
alpha = 0.005 ;
theta1 = rand(20,21)*(2*eps)-eps ;
theta2 = rand(10,21)*(2*eps)-eps ;
theta2_grad = zeros(10,21) ;
theta1_grad = zeros(20,21) ;
m = size(x,1) ;
costs = [];
for q = 1:10000
    cost = 0 ;
    
    for p = 1:m
        a1 = x(p,:) ;
        a1 = [1 a1] ;
        a1 = a1' ;
        z2 = theta1*a1 ; 
        a2 = sigmoid(z2) ;
        a2 = [1 ;a2];
        z3 = theta2*a2 ;
        a3 = sigmoid(z3) ;
        h = a3 ;


        delta3 = a3 - (y_new(p,:))' ;
        delta2 = theta2'*delta3 ;
        delta2 = delta2(2:end).*sigmoidGradient(z2) ;

        theta2_grad = theta2_grad + delta3*a2' ;
        theta1_grad = theta1_grad + delta2*a1' ;
        
        cost = cost + delta3 ;


    end

theta2_grad = (1/m)*theta2_grad ;
theta1_grad = (1/m)*theta1_grad ;

theta1 = theta1 - alpha*theta1_grad ;
theta2 = theta2 - alpha*theta2_grad ;


costs = [costs cost];

end

function g = sigmoid(z)
    g = 1.0 ./ (1.0 + exp(-z)) ;
end

function g = sigmoidGradient(z)
g = zeros(size(z));
a = sigmoid(z) ;
g = a .* (1-a) ;
end