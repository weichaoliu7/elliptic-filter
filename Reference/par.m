function Z_par = par(Z1, Z2)
    % Calculate the parallel impedance of two arbitrary impedances Z1 and Z2
    Z_par = (Z1 * Z2) / (Z1 + Z2);
end
