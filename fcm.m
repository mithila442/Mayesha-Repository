function [a_new,w_new]=fcm2(a,w) %declaration of a finction with two input: a vector and w square matrix
[row col]=size(w); %determines size of w matrix
sum=0;
e=2.7172;
%first iteration: k=1:
for i=1:row  %indictaes each row
    sum=0;
    for j=1:col %indicates each column
        if i==j %interrelationship between same criteria (price vs price) is zero. No need to elemeent update
            continue; %skip if same crteria
        else
            if w(i,j,1)~=0 %only update non-zero elements
                sum=sum+a(j,1,1)*w(i,j,1); %summation of all a(j) and w(i,j) for first iteration
                w(i,j,2)=.98*w(i,j,1)+.001*a(i,1,1)*(a(j,1,1)-sign(w(i,j,1))*w(i,j,1)*a(i,1,1)); %calculates w(i,j) value for 2nd iteration
            else
                w(i,j,2)=0; %for zero elements, next iteration value retains
            end
          end
        end
        x=a(i,1,1)+sum; %calculating input of sigmoid function
        a(i,1,2)=1/(1+e^-x); %calculating a(i) value of 2nd iteration by sigmoid function
end %end of first iteration after updating value of second iteration
k=2;
sum=0;
count=0;
%while loop for termination criteria check:
while count<row %run upto all elements satisfy termination criteria
    %remaining iterations:
    for i=1:row %indictaes each row
        sum=0;
        for j=1:col %indictaes each column
          if i==j
              continue;
          else
              if w(i,j,k)~=0 %only update non-zero elements
                sum=sum+a(j,1,k)*w(i,j,k); %summation of all a(j) and w(i,j) for k'th iteration
                w(i,j,k+1)=.98*w(i,j,k)+.001*a(i,1,k)*(a(j,1,k)-sign(w(i,j,k))*w(i,j,k)*a(i,1,k)); %calculates w(i,j) value for (k+1)th iteration
              else
                 w(i,j,k+1)=0; %for zero elements, next iteration value retains
              end
          end
        end
        x=a(i,1,k)+sum; %calculating input of sigmoid function
        a(i,1,k+1)=1/(1+e^-x); %calculating a(i) value of (k+1)th iteration by sigmoid function
    end
    %end of remaining iterations
    count=0;
    for p=1:row %checks termination criteria for all rows
        if abs(a(p,1,k+1)-a(p,1,k))<.001 %termination criteria for steady state
            count=count+1; %count increases if criteria statisfies
        end
    end
    k=k+1; %next iteration
end
a_new=a; %return final a
w_new=w; %returns final w
iter=[1:k];
graph=plot(iter,a_new(1:row,:)); %plots graphs for each iteration and each criteria
end