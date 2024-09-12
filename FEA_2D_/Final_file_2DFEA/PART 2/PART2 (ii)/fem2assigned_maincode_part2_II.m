% Define geometry, material properties, and mesh
L= 30; % assigning according to your name initials
nodes = [0,0; 15,0; L,0; 30,15; 45,15; 60,15; 60,30; 45,30; L,30; 15,30; 0,30; 0,15; 15,15]; % Node coordinates
elements = [1,2,13,12; 13,10,11,12; 2,3,4,13; 13,4,9,10; 4,5,8,9; 5,6,7,8]; % Element connectivity
E = 40e9; % Young's modulus
nu = 0.3; % Poisson's ratio
thickness = 2; %thickness

loadAngles = [0, 45, 90]; % Define the load angles in degrees
forceMagnitude = 1500; % Define the force magnitude % force magnitude= ((Distributive Load)---> pressure * Total length)/2

for angle = loadAngles
    % Calculate force components
    forceX = forceMagnitude * cosd(angle); % X component of the force
    forceY = forceMagnitude * sind(angle); % Y component of the force

    numNodes = size(nodes, 1);
    dof = 2; % Degrees of freedom per node in 2D problem
    
    % Initialize global stiffness matrix and load vector
    K_global = zeros(numNodes * dof);
    F_global = zeros(numNodes * dof, 1);
    %elementsNodes = 4;
    
    % Loop over elements to compute and assemble stiffness matrices
    for i = 1:6
        % Compute element stiffness matrix for plane stress
        K_local = computeStiffnessMatrix(nodes, elements(i,: ), E, nu, thickness);
    
        % Assemble into global stiffness matrix
        K_global = assembleGlobalMatrix(K_global, K_local, elements(i, :));
    end
    
    % Define fixed and loaded nodes
    fixedNodes = [1, 11,]; % Example fixed nodes
    loadedNodes = [6, 7]; % Nodes where force is applied
    % calculating the force magnitude on each node
    % force magnitude= ((Distributive Load)---> pressure * Total length)/2
    
    
    % Apply boundary conditions
    [K_global, F_global] = applyBoundaryConditions(K_global, F_global, fixedNodes, loadedNodes, forceX, forceY);
    
    % Solve for displacements
    displacements = K_global \ F_global;
    
    % Post-process results
    % Calculate strain
    strain = calculateStrain(displacements, nodes, elements);
    % Calculate stress
    stress = calculateStress(strain, E, nu);
    % Visualize results (assuming visualizeResults is already implemented)
    visualizeResults(nodes, elements, displacements, stress);


    % Write results to text files
    displacementFileName = ['displacements_Angle_' num2str(angle) '.txt'];
    writetable(array2table(displacements), displacementFileName, 'WriteVariableNames', false);

    strainFileName = ['strain_Angle_' num2str(angle) '.txt'];
    writetable(array2table(strain), strainFileName, 'WriteVariableNames', false);
end

