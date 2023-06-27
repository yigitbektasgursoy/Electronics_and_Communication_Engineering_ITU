#include <iostream>
#include <string>

using namespace std;

// Base class for Rectangle
class Rectangle {
protected:
    int vlength; // Vertical length of the rectangle
    int hlength; // Horizontal length of the rectangle
public:
    // Constructor to set the length parameters
    Rectangle(int vlen, int hlen) {
        if (vlen > 0 && vlen <= 40 && hlen > 0 && hlen <= 80) {
            vlength = vlen;
            hlength = hlen;
        }
        else {
            cout << "INVALID LENGTHS" << endl;
            vlength = 1;
            hlength = 1;
        }
    }
    // Function to display the rectangle on the screen
    void display() {
        cout << "RECTANGLE (Vertical=" << vlength << ", Horizontal=" << hlength << ")" << endl;
        for (int i = 0; i < vlength; i++) {
            for (int j = 0; j < hlength; j++) {
                if (i == 0 || i == vlength - 1 || j == 0 || j == hlength - 1)
                    cout << "*";
                else
                    cout << " ";
            }
            cout << endl;
        }
        cout << endl;
    }
};

// Derived class for FilledRectangle
class FilledRectangle : public Rectangle {
public:
    // Constructor to set the length parameters
    FilledRectangle(int vlen, int hlen) : Rectangle(vlen, hlen) {}
    // Function to display the filled rectangle on the screen
    void display() {
        cout << "FILLED RECTANGLE (Vertical=" << vlength << ", Horizontal=" << hlength << ")" << endl;
        for (int i = 0; i < vlength; i++) {
            for (int j = 0; j < hlength; j++) {
                cout << "*";
            }
            cout << endl;
        }
        cout << endl;
    }
};

int main() {
    // Create objects of Rectangle and FilledRectangle
    Rectangle r1(10, 10);
    Rectangle r2(5, 20);
    Rectangle r3(0, 0);
    Rectangle r4(1, 10);
    FilledRectangle fr1(15, 8);
    FilledRectangle fr2(6, 13);
    FilledRectangle fr3(-1, -1);
    // Call the display function for each object
    r1.display();
    r2.display();
    r3.display();
    r4.display();
    fr1.display();
    fr2.display();
    fr3.display();
    return 0;
}


