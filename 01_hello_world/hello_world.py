# Import necessary modules from Qiskit
from qiskit import QuantumCircuit, Aer, execute
from qiskit.visualization import plot_histogram

# Step 1: Initialize a quantum circuit with 1 qubit and 1 classical bit for measurement
qc = QuantumCircuit(1, 1)

# Step 2: Apply a Hadamard gate to the qubit to create a superposition of |0⟩ and |1⟩
qc.h(0)

# Step 3: Measure the qubit
qc.measure(0, 0)

# To simulate the measurement outcome, we can use Qiskit's Aer simulator
simulator = Aer.get_backend("qasm_simulator")

# Execute the circuit on the simulator
job = execute(
    qc, simulator, shots=1
)  # Shots specify the number of times to run the experiment

# Grab results from the job
result = job.result()

# Convert the result to a count, which shows the measurement outcomes
counts = result.get_counts(qc)

# Print the random bit generated
print(counts)

# Display the circuit
qc.draw()
