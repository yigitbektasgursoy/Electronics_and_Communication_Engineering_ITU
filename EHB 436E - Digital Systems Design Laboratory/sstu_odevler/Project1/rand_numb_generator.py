import random

# Open the file for writing
with open('random_numbers.txt', 'w') as f:
    # Generate 100 random pairs of integers
    for i in range(100):
        a = random.randint(0, 65535)
        b = random.randint(0, 65535)
        result = a * b
        # Write the result to the file
        f.write(str(a) + " " + str(b)+ " " +str(result) + '\n')