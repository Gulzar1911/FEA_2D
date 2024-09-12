function K_local = computeStiffnessMatrix(nodes, elementNodes, E, nu, thickness)
    % Extract the coordinates of the nodes of this element
    elementCoords = nodes(elementNodes, :);

    % Plane stress constitutive matrix
    C = E / (1 - nu^2) * [1, nu, 0; nu, 1, 0; 0, 0, (1 - nu) / 2];

    % Initialize the local stiffness matrix
    K_local = zeros(8, 8); % 4 nodes, 2 DOFs per node

    % Gaussian quadrature points and weights (2x2 integration)
    gaussPoints = [-1/sqrt(3), 1/sqrt(3)];
    gaussWeights = [1, 1];

    % Loop over Gaussian quadrature points using indices
    for i = 1:length(gaussPoints)
        for j = 1:length(gaussPoints)
            xi = gaussPoints(i);
            eta = gaussPoints(j);

            % Calculate Jacobian matrix and its determinant
            [Jacobian, detJ] = calculateJacobian(elementCoords, xi, eta);

            % Calculate B matrix (strain-displacement matrix)
            B = calculateBMatrix(elementCoords, Jacobian, xi, eta);

            % Add contribution to the stiffness matrix
            K_local = K_local + B' * C * B * detJ * thickness * gaussWeights(i) * gaussWeights(j);
        end
    end
end
