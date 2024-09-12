function B = calculateBMatrix(elementCoords, Jacobian, xi, eta)
  
    % Calculate the derivatives of the shape functions with respect to x and y using the Jacobian
    dN_dxi = [-(1-xi)/4,(1-xi)/4,(1+xi)/4,-(1+xi)/4]; 
    dN_deta = [-(1-eta)/4,-(1+eta)/4,(1+eta)/4,(1-eta)/4];
% Assuming dN_dxi and dN_deta are already defined, and the Jacobian matrix is calculated
invJacobian = inv(Jacobian); % Inverse of the Jacobian matrix

% Initialize arrays to store the derivatives with respect to x and y
dN_dx = zeros(size(dN_dxi));
dN_dy = zeros(size(dN_deta));

% Calculate the derivatives with respect to x and y for each node
for i = 1:length(dN_dxi)
    dN_dxi_eta = [dN_dxi(i); dN_deta(i)]; % Column vector of derivatives w.r.t. xi and eta
    dN_dx_dy = invJacobian * dN_dxi_eta; % Transform to derivatives w.r.t. x and y

    dN_dx(i) = dN_dx_dy(1);
    dN_dy(i) = dN_dx_dy(2);
end


% Construct the B matrix
B = zeros(3, 8); % 3 rows for εx, εy, γxy; 8 columns for 4 nodes each with 2 DOFs

% Loop through each node to construct the B matrix
for i = 1:4 % 4 nodes for a quadrilateral element
    % Node i contributes to columns 2*i-1 and 2*i of the B matrix
    B(1, 2*i-1) = dN_dx(i); % Contribution to εx from node i's x-displacement
    B(2, 2*i)   = dN_dy(i); % Contribution to εy from node i's y-displacement

    % For shear strain γxy, contributions come from both x and y displacements
    B(3, 2*i-1) = dN_dy(i); % Contribution to γxy from node i's x-displacement
    B(3, 2*i)   = dN_dx(i); % Contribution to γxy from node i's y-displacement
end

end
