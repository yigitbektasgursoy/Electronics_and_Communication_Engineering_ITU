#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;
int main(int argc, char* argv[])
{
    try {
        // Check if there are at least two filenames in argv
        if (argc < 3) {
            throw "Error : At least two filenames required";
        }
        // Open the output file for writing
        ofstream output_file("output.txt");
        if (!output_file) {
            throw "Error : Output file could not be opened";
        }
        // Loop through all the input filenames in argv
        for (int i = 1; i < argc; i++) {
            // Open the input file for reading
            ifstream input_file(argv[i]);
            if (!input_file) {
                throw "Error : Input file " + string(argv[i]) + " could not be opened";
            }

            // Read each line of the input file and write it to the output file
            string line;
            while (getline(input_file, line)) {
                output_file << line << endl;
            }

            // Close the input file
            input_file.close();
        }

        // Close the output file
        output_file.close();

        // Output success message
        cout << "Files successfully appended to output.txt" << endl;

    }
    catch (const char* e) {
        cerr << e << endl;
    }

    return 0;
}

