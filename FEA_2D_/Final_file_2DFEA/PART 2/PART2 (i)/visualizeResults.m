function visualizeResults(nodes, elements, displacements, stress)
    numNodes = size(nodes, 1);
    dof = 2; % Degrees of freedom per node in 2D

    % Calculate the deformed coordinates
    deformedNodes = nodes + reshape(displacements, dof, numNodes)';

    % Plotting the original and deformed mesh
    figure;
    subplot(1, 2, 1);
    plotMesh(nodes, elements, 'Original Mesh');
    subplot(1, 2, 2);
    plotMesh(deformedNodes, elements, 'Deformed Mesh');

    % Plotting stress distribution (if required)
    % You can use a contour plot or similar to show stresses on the deformed mesh
    % ...

end

function plotMesh(nodes, elements, titleStr)
    hold on;
    for i = 1:size(elements, 1)
        elemNodes = elements(i, :);
        X = nodes(elemNodes, 1);
        Y = nodes(elemNodes, 2);
        fill(X, Y, 'cyan'); % Modify as needed for better visualization
    end
    title(titleStr);
    axis equal;
    hold off;
end
