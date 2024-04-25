namespace QSharp.Chapter4 {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    // Helper operation to prepare Bell state on two qubits
    operation PrepareBellState(q1 : Qubit, q2 : Qubit) : Unit is Adj {
        H(q1);
        CNOT(q1, q2);
    }

    // Helper operation to perform measurement in Bell basis
    operation MeasureBellBasis(q1 : Qubit, q2 : Qubit) : (Result, Result) {
        Adjoint PrepareBellState(q1, q2);
        return (MResetZ(q1), MResetZ(q2));
    }

    // Main operation demonstrating quantum teleportation
    @EntryPoint()
    operation TeleportAndVerify() : Unit {
        use (aliceEPR, bobEPR, data) = (Qubit(), Qubit(), Qubit());
        Ry(1.0, data);
        Message("The state to be teleported:");
        DumpMachine();

        PrepareBellState(aliceEPR, bobEPR);
        let message = MeasureBellBasis(data, aliceEPR);

        Message($"Measurement results: {message}");

        Message("The state of Bob's qubit after Alice's measurement");
        DumpMachine();

        let (fix1, fix2) = message;
        if (fix2 == One) {
            X(bobEPR);
        }
        if (fix1 == One) {
            Z(bobEPR);
        }

        Message("Teleportation result (the state of Bob's qubit)");
        DumpMachine();

        Adjoint Ry(1.0, bobEPR);
    }
}
