from qiskit import (
    QuantumCircuit,
    QuantumRegister,
    ClassicalRegister,
    execute,
    Aer,
    IBMQ,
    BasicAer,
)
import math

## Uncomment the next line to see diagrams when running in a notebook
# %matplotlib inline

# Set up the program
reg = QuantumRegister(8, name="reg")
reg_c = ClassicalRegister(8, name="regc")
qc = QuantumCircuit(reg, reg_c)

qc.reset(reg)  # write the value 0
qc.h(reg)  # put it into a superposition of 0 and 1
qc.measure(reg, reg_c)  # read the result as a digital bit

backend = BasicAer.get_backend("statevector_simulator")
job = execute(qc, backend)
result = job.result()

# Convert the result into a random number
counts = result.get_counts(qc)
print("counts:", counts)
for key, val in counts.items():
    n = sum([(int(x) << i) for i, x in enumerate(key)])
    print("Random number:", n)

# outputstate = result.get_statevector(qc, decimals=3)
# print(outputstate)
qc.draw()  # draw the circuit