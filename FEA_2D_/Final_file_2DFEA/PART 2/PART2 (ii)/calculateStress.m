function stress = calculateStress(strain, E, nu)
    % Plane stress constitutive matrix
    C = E / (1 - nu^2) * [1, nu, 0; nu, 1, 0; 0, 0, (1 - nu) / 2];

    % Calculate stress for each element
    numElements = size(strain, 1);
    stress = zeros(numElements, 3); % σxx, σyy, and τxy

    for i = 1:numElements
        stress(i, :) = C * strain(i, :)';
    end
end
