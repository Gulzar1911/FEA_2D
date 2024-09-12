figure;
hold on;
% Plot elements
for i = 1:size(elements, 1)
    elem = elements(i, :);
    X = nodes(elem, 1);
    Y = nodes(elem, 2);
    fill(X, Y, 'cyan'); % Fill color for elements
end
% Plot nodes
plot(nodes(:, 1), nodes(:, 2), 'ko', 'MarkerFaceColor', 'black'); % Black dots for nodes

fixedNodes = [1, 11,]; % Example fixed nodes
plot(nodes(fixedNodes, 1), nodes(fixedNodes, 2), 'ro', 'MarkerFaceColor', 'red'); % Red dots for fixed nodes

rightBoundaryNodes = [6,7]; % Example nodes on the right boundary
plot(nodes(rightBoundaryNodes, 1), nodes(rightBoundaryNodes, 2), 'bo', 'MarkerFaceColor', 'blue'); % Blue dots for loaded nodes

% Labeling Nodes
for i = 1:size(nodes, 1)
    text(nodes(i, 1), nodes(i, 2), [' ' num2str(i)], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
% Adding Annotations for Boundary Conditions
text(mean(nodes(fixedNodes, 1)), mean(nodes(fixedNodes, 2)), 'Fixed Nodes', 'Color', 'red');
text(mean(nodes(rightBoundaryNodes, 1)), mean(nodes(rightBoundaryNodes, 2)), 'Loaded Nodes', 'Color', 'blue');

xlabel('X Coordinate');
ylabel('Y Coordinate');
title('FEA Mesh with Boundary Conditions');
axis equal;
grid on;
hold off;
