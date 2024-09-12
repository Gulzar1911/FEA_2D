function runFEAForDifferentEValues()
    E_values = [30e9, 40e9, 50e9]; % Different values of Young's modulus
    for k = 1:length(E_values)
        E = E_values(k); % Current value of E
        [displacements, strain] = fem2assigned(E); % Run FEA for the current E value

        % Write displacements to a text file
        displacementFileName = ['displacements_E_' num2str(E) '.txt'];
        writetable(array2table(displacements), displacementFileName, 'WriteVariableNames', false);

        % Write strain to a text file
        strainFileName = ['strain_E_' num2str(E) '.txt'];
        writetable(array2table(strain), strainFileName, 'WriteVariableNames', false);
    end
end

function [displacements, strain] = fem2assigned(E)
    % Your existing FEA code goes here, returning 'displacements' and 'strain'
    % Ensure the code uses the passed 'E' value in the stiffness matrix computation
end
