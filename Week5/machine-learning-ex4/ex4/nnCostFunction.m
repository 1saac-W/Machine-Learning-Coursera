function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
Y = zeros(num_labels,m);
for i = 1:m
  Y(y(i),i) = 1;
endfor
% You need to return the following variables correctly 
h1 = sigmoid([ones(m, 1) X] * Theta1');
h2 = sigmoid([ones(m, 1) h1] * Theta2');

cost1 = log(h2) * Y;
cost2 = log(1 .- h2) * (1 .- Y);
J = -1 / m *sum(diag(cost1) + diag(cost2))+ ...
    0.5 * lambda / m *  sum(sum(Theta1(:,2:end).^2))+ ...
      0.5 * lambda / m *  sum(sum(Theta2(:,2:end).^2));


Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
delta_3 = h2 - Y'; %5000*10
delta_2 = delta_3 * Theta2 .* [ones(m, 1) h1] .* (1 .- [ones(m, 1) h1]);
%delta_1 = delta_2 * Theta1(:,2:end) .* X.*(1 .- X);
for i = 1 : m
    Theta2_grad = Theta2_grad .+ delta_3(i,:)' * [ones(m, 1) h1](i,:);
    Theta1_grad = Theta1_grad .+ delta_2(i,2:end)' * [ones(m, 1) X](i,:);
endfor

Theta2_grad = (Theta2_grad .+ lambda .* [zeros(num_labels,1) Theta2(:,2:end)])./m;
Theta1_grad = (Theta1_grad .+ lambda .* [zeros(hidden_layer_size,1) Theta1(:,2:end)])./ m;


% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%





% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
