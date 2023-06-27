#include <iostream>
#include <map>
#include <vector>
#include <fstream>
#include <algorithm>
using namespace std;
// Subcategory class
class Subcategory {
public:
    string name;
    int amount;

    Subcategory(string n, int a) : name(n), amount(a) {}

    void print() {
        cout << "Name: " << name << ", Amount: " << amount << endl;
    }
};

// Comparison function for sorting
bool compareSubcategory(const Subcategory &a, const Subcategory &b) {
    return a.amount < b.amount;
}

int main() {
    // Map
    map<string, vector<Subcategory>> M;

    // Initialize map
    M["ELECTRONICS GROUP"] = {
        Subcategory("Router", 41), Subcategory("Battery", 136), Subcategory("Monitor", 30),
        Subcategory("Printer", 24), Subcategory("Audio", 43), Subcategory("Navigation", 15),
        Subcategory("Video", 32), Subcategory("Modem", 26)
    };
    M["MACHINERY GROUP"] = {
        Subcategory("Shipping", 23), Subcategory("Crane", 7), Subcategory("Hydraulics", 15),
        Subcategory("Pneumatics", 10), Subcategory("Forklift", 8), Subcategory("Carrier", 13)
    };
    M["STATIONERY GROUP"] = {
        Subcategory("Paper Clip", 1370), Subcategory("Envelope", 560), Subcategory("Ink", 140),
        Subcategory("Notepad", 710), Subcategory("Paper Pack", 230), Subcategory("Clipboard", 1720),
        Subcategory("Binder", 690)
    };

    ofstream file("Output.html");

    // Loop over map
    for (auto &group : M) {
        // Sort subcategories by amount
        sort(group.second.begin(), group.second.end(), compareSubcategory);

        int totalAmount = 0;

        file << "<table border=1>\n";
        file << "<tr>\n<td align=center colspan=2 bgcolor=aqua >" << group.first << "</td>\n</tr>\n";
        file << "<tr>\n<td> SUBCATEGORY NAME </td>\n<td> AMOUNT </td>\n</tr>\n";

        // Loop over subcategories
        for (auto &subCategory : group.second) {
            totalAmount += subCategory.amount;
            file << "<tr>\n<td> " << subCategory.name << " </td>\n<td align=center> " << subCategory.amount << " </td>\n</tr>\n";
        }
        
        file << "<tr>\n<td> TOTAL AMOUNT </td>\n<td align=center> " << totalAmount << " </td>\n</tr>\n";
        file << "</table>\n<br>\n";
    }

    file.close();

    return 0;
}