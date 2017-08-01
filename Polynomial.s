                .syntax     unified
                .cpu        cortex-m4
                .text
                .thumb_func
                .align      2

// float Poly(float, float [], int32_t) ;

zero:           .float      0.0
                .global     Poly
Poly:           VLDR        S1,zero     // float res = 0.0
                VMOV        S2,1.0      // float fact = 1.0
                LDR         R2,=0       // int i = 0;
Loop:           CMP         R2,R1       // i > terms
                BGT         End         // goto End
                VLDMIA      R0!,{S3}    // S3 <-- *coef++
                VMLA.F32    S1,S3,S2    // res += *coef++ * fact
                VMUL.F32    S2,S2,S0    // fact *= x
                ADD         R2,R2,1     // i++
                B           Loop        // repeat
End:            VMOV        S0,S1       // S0 <-- res
                BX          LR          // return res
                .end

/*
float Poly(float x, float coef[], int32_t terms) {
    float res = 0.0;
    float fact = 1.0;

    for (int i = 0; i <= terms; i++) {
        res += coef[i] * fact;
        fact *= x;
    }

    return res;
}
*/
