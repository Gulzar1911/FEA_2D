function [Jacobian, detJ] = calculateJacobian(elementCoords, xi, eta)
    % Number of nodes per element (4 for a quadrilateral)
    numNodes = size(elementCoords, 1);

    % Initialize the Jacobian matrix
    Jacobian = zeros(2, 2);

    % Calculate derivatives of shape functions with respect to xi and eta
    % for a 4-node quadrilateral element
    % These should be replaced with the actual derivatives of the shape functions
    dN_dxi = [-(1-xi)/4,(1-xi)/4,(1+xi)/4,-(1+xi)/4]; % Placeholder for derivatives of N with respect to xi
    dN_deta = [-(1-eta)/4,-(1+eta)/4,(1+eta)/4,(1-eta)/4]; % Placeholder for derivatives of N with respect to eta

    % Loop through each node to construct the Jacobian matrix
    for i = 1:numNodes
        x = elementCoords(i, 1);
        y = elementCoords(i, 2);

        Jacobian(1, 1) = Jacobian(1, 1) + dN_dxi(i) * x;
        Jacobian(1, 2) = Jacobian(1, 2) + dN_dxi(i) * y;
        Jacobian(2, 1) = Jacobian(2, 1) + dN_deta(i) * x;
        Jacobian(2, 2) = Jacobian(2, 2) + dN_deta(i) * y;
    end

    % Calculate the determinant of the Jacobian
    detJ = det(Jacobian);
end
