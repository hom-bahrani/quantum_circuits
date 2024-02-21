namespace RootNot {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math; // Include this line
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;

    operation ApplyRootOfNot(qubit: Qubit) : Unit {
        // First root-of-not gate
        H(qubit);
        Rz(-PI() / 2.0, qubit); // Corrected line
        H(qubit);
        // Quantum barrier is not necessary in Q# as it's mostly a hardware consideration for optimization

        // Second root-of-not gate (repeating the operation)
        H(qubit);
        Rz(-PI() / 2.0, qubit); // Corrected line
        H(qubit);
        // Again, no need for a barrier in Q#
    }

    @EntryPoint()
    operation DemonstrateRootOfNot() : Result {
        use qubit = Qubit();
        // Initialize the qubit to |0⟩ state (Reset is implicit on allocation in Q#)
        
        ApplyRootOfNot(qubit);

        // Normally, you would measure the qubit here if you wanted to observe its state.
        // For state vector simulation to see the effects, you would use the DumpMachine() function in simulation.
        // Measurement and resetting for cleanliness, though not strictly needed for demonstration
        let result = M(qubit);
        Message($"Measurement result: {result}");
        
        Reset(qubit);
        return result;
    }
}
