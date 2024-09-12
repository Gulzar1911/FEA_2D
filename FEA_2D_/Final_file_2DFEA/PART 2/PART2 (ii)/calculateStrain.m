function strain = calculateStrain(displacements, nodes, elements)
    % Initialize strain array
    numElements = size(elements, 1);
    strain = zeros(numElements, 3); % Assuming 2D strain: εxx, εyy, and γxy

    gaussPoints = [-1/sqrt(3), 1/sqrt(3)];
    gaussWeights = [1, 1];

    for elemIndex = 1:numElements
        elementNodes = elements(elemIndex, :);
        elementCoords = nodes(elementNodes, :);

        elementDisplacements = [];
        for nodeIndex = 1:length(elementNodes)
            nodeDOFStart = (elementNodes(nodeIndex) - 1) * 2;
            elementDisplacements = [elementDisplacements; displacements(nodeDOFStart + 1); displacements(nodeDOFStart + 2)];
        end

      

        % Initialize element strain
        elementStrain = zeros(3, 1);

        for i = 1:length(gaussPoints)
            for j = 1:length(gaussPoints)
                xi = gaussPoints(i);
                eta = gaussPoints(j);

                % Calculate Jacobian matrix for the element at (xi, eta)
                [Jacobian, detJ] = calculateJacobian(elementCoords, xi, eta);

                % Calculate B matrix (strain-displacement matrix)
                B = calculateBMatrix(elementCoords, Jacobian, xi, eta);

               

                % Integrate strain over the element
                tempStrain = B * elementDisplacements; % Matrix multiplication
                elementStrain = elementStrain + tempStrain * detJ * gaussWeights(i) * gaussWeights(j); % Scalar multiplication
            end
        end

        % Store the strain for this element
        strain(elemIndex, :) = elementStrain; % Strain for each element
    end
end
