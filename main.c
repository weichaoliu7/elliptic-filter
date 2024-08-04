/*
 * File: main.c
 * Description: This program simulates a 7th-order low-pass elliptic filter
 *              for a DDS (Direct Digital Synthesis) system. It calculates
 *              the transfer function of the filter and generates Bode plot data
 *
 * Author: Liu W.C.
 * Date: 2024.8.4
 *
 */

#include <math.h>
#include <stdio.h>
#include <complex.h>

#define PI 3.14159265358979323846

// Define the impedances with symbolic variables
double L1, L2, L3, C1, C2, C3, C4, C5, C6, C7, R1, R2, V_R2;

// Define the impedances with symbolic variables
#define L1 470e-9
#define L2 390e-9
#define L3 390e-9
#define C1 1e-12
#define C2 5.6e-12
#define C3 4.7e-12
#define C4 22e-12
#define C5 33e-12
#define C6 22e-12
#define C7 22e-12
#define R1 200
#define R2 200
#define V_R2 2

// Calculate impedance of a capacitor
double complex Z_C(double complex s, double C) {
    return 1.0 / (s * C);
}

// Calculate impedance of an inductor
double complex Z_L(double complex s, double L) {
    return s * L;
}

// Parallel impedance calculation
double complex parallel(double complex Z1, double complex Z2) {
    return 1.0 / (1.0 / Z1 + 1.0 / Z2);
}

// Series impedance calculation
double complex series(double complex Z1, double complex Z2) {
    return Z1 + Z2;
}

// Calculate transfer function H(s) = Vout/Vin
double complex H_s(double complex s) {
    // Impedances
    double complex Z_C1 = Z_C(s, C1);
    double complex Z_C2 = Z_C(s, C2);
    double complex Z_C3 = Z_C(s, C3);
    double complex Z_C4 = Z_C(s, C4);
    double complex Z_C5 = Z_C(s, C5);
    double complex Z_C6 = Z_C(s, C6);
    double complex Z_C7 = Z_C(s, C7);

    double complex Z_L1 = Z_L(s, L1);
    double complex Z_L2 = Z_L(s, L2);
    double complex Z_L3 = Z_L(s, L3);

    double complex Z_R1 = R1;
    double complex Z_R2 = R2;

    // Parallel impedances
    double complex Z_C1_L1 = parallel(Z_C1, Z_L1); // Impedance of capacitor C1 and inductor L1 connected in parallel
    double complex Z_C2_L2 = parallel(Z_C2, Z_L2); // Impedance of capacitor C2 and inductor L2 connected in parallel
    double complex Z_C3_L3 = parallel(Z_C3, Z_L3); // Impedance of capacitor C3 and inductor L3 connected in parallel

    double complex Z_R2_C7 = parallel(Z_R2, Z_C7); // Impedance of resistive R2 and capacitor C7 connected in parallel

    // Parallel C7 is connected in series with the parallel impedance of C3, L3
    double complex Z_R2_C7_C3_L3 = series(Z_R2_C7, Z_C3_L3);

    // Component series voltage divider
    // Voltage across R2 and C7 in series with C3 and L3
    double complex V_R2_C7_C3_L3 = Z_R2_C7_C3_L3 / Z_R2_C7 * V_R2;

    // Result is connected in parallel with C6
    double complex Z_R2_C7_C3_L3_C6 = parallel(Z_R2_C7_C3_L3, Z_C6);

    // Voltages of parallel elements are equal
    double complex V_R2_C7_C3_L3_C6 = V_R2_C7_C3_L3;

    // Result obtained is connected in series with the parallel impedance of C2 and L2
    double complex Z_R2_C7_C3_L3_C6_C2_L2 = series(Z_R2_C7_C3_L3_C6, Z_C2_L2);

    // Component series voltage divider
    // Voltage across R2 and C7, C3 and L3, and C6 in series with C2 and L2
    double complex V_R2_C7_C3_L3_C6_C2_L2 = Z_R2_C7_C3_L3_C6_C2_L2 / Z_R2_C7_C3_L3_C6 * V_R2_C7_C3_L3;

    // Result is then connected in parallel with C5
    double complex Z_R2_C7_C3_L3_C6_C2_L2_C5 = parallel(Z_R2_C7_C3_L3_C6_C2_L2, Z_C5);

    // Voltages of parallel elements are equal
    double complex V_R2_C7_C3_L3_C6_L2_C5 = V_R2_C7_C3_L3_C6_C2_L2;

    // Result is then connected in series with the parallel impedance of C1 and L1
    double complex Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1 = series(Z_R2_C7_C3_L3_C6_C2_L2_C5, Z_C1_L1);

    // Component series voltage divider
    // Voltage across R2 and C7, C3 and L3, C6, C2 and L2, C5, and series with C1 and L1
    double complex V_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1 = Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1 / Z_R2_C7_C3_L3_C6_C2_L2_C5 * V_R2_C7_C3_L3_C6_C2_L2;

    // Result is then connected in parallel with C4
    double complex Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4 = parallel(Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1, Z_C4);

    // Voltages of parallel elements are equal
    double complex V_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4 = V_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1;

    // Result is then connected in parallel with R1
    double complex Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4_R1 = parallel(Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4, Z_R1);

    // Voltages of parallel elements are equal
    double complex V_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4_R1 = V_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4;

    // Total equivalent impedance
    double complex V1 = V_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4_R1;

    // Define the transfer function H(s) = Vout/Vin
    return V_R2 / V1;
}

int main() {

    // Open file for writing data
    FILE *file = fopen("bode_data.txt", "w");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    // Frequency range from 1 kHz to 1 THz
    int num_points = 1000;
    double f_start = 1e3; // Start frequency in Hz
    double f_end = 1e12;  // End frequency in Hz
    double step = exp(log(f_end / f_start) / (num_points - 1)); // Logarithmic step factor
    double complex s;
    int flag = 0;

    for (int i = 0; i < num_points; i++) {
        double freq = f_start * pow(step, i);
        s = 2 * PI * freq * I; // s = jw
        double complex H = H_s(s);
        printf("frequency: %.2e Hz, H(s): %.2e + j * %.2e\n", freq, creal(H), cimag(H));
    
        double magnitude = cabs(H);

        double phase = carg(H) * 180.0 / PI;

        double magnitude_dB = 20 * log10(magnitude); // Magnitude in dB
        fprintf(file, "%.2e %.2e %.2f\n", freq, magnitude_dB, phase);
    }

    return 0;
}
