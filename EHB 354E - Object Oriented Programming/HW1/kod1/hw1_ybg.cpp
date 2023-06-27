//Yigit Bektas Gursoy - 040180063 - HOMEWORK1
#include <iostream>
#include <iomanip>
using namespace std;

// Define a Cube class
class Cube {
private:
    int length;
    int width;
    int height;

public:
    // Constructor to initialize length, width, and height
    Cube(int l, int w, int h) : length(l), width(w), height(h) {}

    // Function to calculate the volume of the cube
    int getVolume() const {
        return length * width * height;
    }

    // Getter functions to return the length, width, and height of the cube
    int getLength() const {
        return length;
    }

    int getWidth() const {
        return width;
    }

    int getHeight() const {
        return height;
    }

    // Function to print the cube details
    void printCube(int number) const {
        cout << setw(2) << number << ". Cube "
                  << setw(2) << length << " "
                  << setw(2) << width << " "
                  << setw(3) << height << " "
                  << setw(7) << getVolume() << "\n";
    }
};

// Overload the ">" operator to compare two cubes based on their volume
bool operator>(const Cube& cube1, const Cube& cube2) {
    return cube1.getVolume() > cube2.getVolume();
}

// Overload the "+" operator to combine two cubes into a new cube
Cube operator+(const Cube& cube1, const Cube& cube2) {
    int newLength = max(cube1.getLength(), cube2.getLength());
    int newWidth = max(cube1.getWidth(), cube2.getWidth());
    int newHeight = cube1.getHeight() + cube2.getHeight();
    return Cube(newLength, newWidth, newHeight);
}

int main() {
    const int MAX_CUBES = 10;

    // Create an array of Cube objects
    Cube cubes[MAX_CUBES] = {
        {25, 56, 83},
        {5, 50, 86},
        {50, 60, 76},
        {44, 35, 75},
        {40, 28, 117},
        {13, 34, 95},
        {47, 32, 60},
        {43, 38, 74},
        {46, 70, 78},
        {22, 26, 102}
    };

    // Print the unsorted cubes
    cout << "CUBES (UNSORTED)\n" << setw(28) << right <<" L  W  H    Volume\n";
    for (int i = 0; i < MAX_CUBES; i++) {
        cubes[i].printCube(i+1);
    }

    // Sort the cubes by volume using a bubble sort algorithm
    cout  << "CUBES (SORTED BY VOLUME)\n" << setw(28) << right<< " L  W  H    Volume\n";
    for (int i = 0; i < MAX_CUBES; i++) {
        for (int j = i+1; j < MAX_CUBES; j++) {
            if (!(cubes[j] > cubes[i])) {
                Cube temp = cubes[i];
                cubes[i] = cubes[j];
                cubes[j] = temp;
            }
        }
    }
    // Print the sorted cubes


    for (int i = 0; i < MAX_CUBES; i++) {
        cubes[i].printCube(i+1);
    }

    // Print header for the cumulative sums of cubes section
    cout << "\nCUMULATIVE SUMS OF CUBES AFTER SORTING\n" << setw(56) << right<<" L  W  H    Volume\n";
    // Create a new cube called newCube with the dimensions of the first cube in the sorted array
    Cube newCube = cubes[0];
    // Iterate through the remaining cubes in the sorted array, adding each one to the cumulative sum
    for (int i = 1; i < MAX_CUBES; i++) {
         // Create a temporary cube called temp by adding the current cube to the cumulative sum
        Cube temp = newCube + cubes[i];
        // Print the details of the current cumulative sum
        cout << "Number of cubes added = " <<setw(2)<< right << i+1 << " , ";
        temp.printCube(i+1);
        // Update the cumulative sum to be the newly calculated value
        newCube = temp;
    }

    cout << "PROGRAM FINISHED.\n";
    return 0;
}