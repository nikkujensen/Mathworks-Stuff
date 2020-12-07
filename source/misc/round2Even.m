function newNum = round2Even(num)
% this function rounds to an even number

% round first to an integer
myInt = round(num);

% correct for if it is odd or even
myRem = rem(myInt,2);
newNum = myInt + myRem;

end