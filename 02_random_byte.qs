namespace RandomByte {
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation RandomByte () : Result[] {
        // allocate 8 qubits
        use register = Qubit[8];
        // put each qubit into superposition of 0 and 1
        ApplyToEach(H, register);

        // measure the register and store the result
        // MeasureInteger returns the qubits to the |0⟩ state, so no separate Reset is required
        let results = MeasureEachZ(register);
        ResetAll(register);
        return results;
    }
}