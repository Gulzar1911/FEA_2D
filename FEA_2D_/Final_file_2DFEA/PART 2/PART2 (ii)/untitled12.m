% Plotting the nodes
L= 30; % assigning according to your name initials
nodes = [0,0; 15,0; L,0; 30,15; 45,15; 60,15; 60,30; 45,30; L,30; 15,30; 0,30; 0,15; 15,15]; % Node coordinates
elements = [1,2,13,12; 13,10,11,12; 2,3,4,13; 13,4,9,10; 4,5,8,9; 5,6,7,8]; % Element connectivity
plot(nodes(:,1), nodes(:,2), 'ko');
hold on;

% Annotate the nodes with their numbers
for i = 1:size(nodes, 1)
    text(nodes(i,1), nodes(i,2), [' ' num2str(i)], 'VerticalAlignment','bottom','HorizontalAlignment','right')
end

% Plotting the elements
for i = 1:size(elements, 1)
    elem_nodes = nodes(elements(i, :), :);
    elem_nodes = [elem_nodes; elem_nodes(1, :)]; % Close the loop for plotting
    plot(elem_nodes(:,1), elem_nodes(:,2), '-');
end

hold off;
xlabel('X Coordinate');
ylabel('Y Coordinate');
title('FEA Mesh: Nodes and Elements');
axis equal;
grid on;



