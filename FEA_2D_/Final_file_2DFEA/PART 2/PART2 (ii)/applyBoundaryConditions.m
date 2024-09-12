function [K_mod, F_mod] = applyBoundaryConditions(K_global, F_global, fixedNodes, loadedNodes, forceX, forceY)
    K_mod = K_global;
    F_mod = F_global;
    dof = 2; % Degrees of freedom per node (X and Y)

    % Apply Dirichlet boundary conditions (fixed nodes)
    for node = fixedNodes
        for i = (node-1)*dof+1 : node*dof
            K_mod(i, :) = 0; % Set the row to 0
            K_mod(:, i) = 0; % Set the column to 0
            K_mod(i, i) = 1; % Set the diagonal to 1
            F_mod(i) = 0;    % Set the force to 0
        end
    end
    
% Apply Neumann boundary conditions (forces in X-direction)
for node = loadedNodes
     F_mod((node-1)*dof + 1) = F_mod((node-1)*dof + 1) + forceX; % Apply force in X-direction
     F_mod((node-1)*dof + 2) = F_mod((node-1)*dof + 2) + forceY; % Apply force in Y-direction
end

end
