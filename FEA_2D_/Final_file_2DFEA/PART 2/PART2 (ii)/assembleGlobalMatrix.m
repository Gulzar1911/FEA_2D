function K_global = assembleGlobalMatrix(K_global, K_local, elementNodes)
    numNodesPerElement = length(elementNodes);
    dofPerNode = 2; % Degrees of freedom per node

    % Loop over each node in the element
    for i = 1:numNodesPerElement
        for j = 1:numNodesPerElement
            % Global DOF indices for the current pair of nodes
            global_i_indices = (elementNodes(i) - 1) * dofPerNode + (1:dofPerNode);
            global_j_indices = (elementNodes(j) - 1) * dofPerNode + (1:dofPerNode);

            % Local DOF indices
            local_i_indices = (i - 1) * dofPerNode + (1:dofPerNode);
            local_j_indices = (j - 1) * dofPerNode + (1:dofPerNode);

            % Add local stiffness matrix of the element to the global matrix
            K_global(global_i_indices, global_j_indices) = K_global(global_i_indices, global_j_indices) + K_local(local_i_indices, local_j_indices);
        end
    end
end
