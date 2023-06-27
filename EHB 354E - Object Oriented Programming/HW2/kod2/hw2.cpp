// Yigit Bektas Gursoy 040180063 HW2

#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>
#include <iomanip>
#include <locale>
#include <sstream>

using namespace std;

class University {
private:
    string university_name;
    int city_code;
    char type; 

public:
    University(string name, int code, char t) : university_name(name), city_code(code), type(t) {}

    virtual void print() {
        cout << setw(43) << left <<university_name << " ";
    }

    int get_city_code() const {
        return city_code;
    }

    char get_type() const {
        return type;
    }

    virtual ~University() {}
};

class MultiCampusUniversity : public University {
private:
    int number_of_campuses;

public:
    MultiCampusUniversity(string name, int code, char t, int campuses)
        : University(name, code, t), number_of_campuses(campuses) {}

    void print() override {
        University::print();
    }

    int get_number_of_campuses() const {
        return number_of_campuses;
    }
};

int main() {
    setlocale(LC_ALL, "tr_TR");

    map<int, string> cities;
    ifstream cities_file("cities.txt");
    int city_code;
    string city_name;

    while (cities_file >> city_code >> ws && getline(cities_file, city_name)) {
        cities[city_code] = city_name;
    }
    cities_file.close();

    ifstream universities_file("universities.txt");
    string line;
    vector<University*> universities;

    while (getline(universities_file, line)) {
        stringstream ss(line);
        string name, temp;
        int code, campuses;
        char type, delimiter;

        getline(ss, name, ';');
        ss >> code >> delimiter >> type;

        if (ss >> delimiter >> campuses) {
            universities.push_back(new MultiCampusUniversity(name, code, type, campuses));
        } else {
            universities.push_back(new University(name, code, type));
        }
    }
    universities_file.close();

    cout << "ONE-CAMPUS UNIVERSITIES:" << endl;
    cout << setw(48) << left << "   University Name" << setw(21) << left << "City" << setw(12) << left << "Type" << endl;
    int i = 1;
    for (University* u : universities) {
        MultiCampusUniversity* mcu = dynamic_cast<MultiCampusUniversity*>(u);
        if (mcu == nullptr) {
            cout << setw(2) << i << " ";
            u->print();
            cout << " " << setw(20)<< left << cities[u->get_city_code()] << " ";
            if (u->get_type() == 'S') {
                cout << "State";
            } else {
                cout << "Foundation";
            }
            cout << endl;
            i++;
        }
    }

    cout << "MULTI-CAMPUS UNIVERSITIES:" << endl;
    cout << setw(48) << left << "   University Name" << setw(21) << left << "City" << setw(12) << left << "Type" << "Campuses" << endl;
    i = 1;
    for (University* u : universities) {
        MultiCampusUniversity* mcu = dynamic_cast<MultiCampusUniversity*>(u);
        if (mcu != nullptr) {
            cout << setw(2) << i << " ";
            mcu->print();
            cout << " " << setw(20) << left << cities[u->get_city_code()] << " ";
            if (u->get_type() == 'S') {
                cout << setw(12) << left <<"State";
            } else {
                cout << setw(12) << left << "Foundation";

            }
            cout << " " << mcu->get_number_of_campuses();
            cout << endl;
            i++;
        }
    }

    // Histograms and other output should be generated here.

    int one_campus_state = 0;
    int one_campus_foundation = 0;
    int multi_campus_state = 0;
    int multi_campus_foundation = 0;
    // Histograms
    cout << endl << "HISTOGRAMS OF TOTAL UNIVERSITY NUMBERS:" << endl;

    // One-campus universities
    int state_count = 0, foundation_count = 0;
    for (University* u : universities) {
        if (dynamic_cast<MultiCampusUniversity*>(u) == nullptr) {
            if (u->get_type() == 'S') {
                state_count++;
            } else {
                foundation_count++;
            }
        }
    }
    setlocale(LC_ALL, "C");
    cout << setw(27) << left << "ONE CAMPUS (STATE)"<< ":" << setw(3)<< right << state_count << " ";
    for (int i = 0; i < state_count; i++) {
        cout << "\u25A0";
    }
    cout << endl;

    cout <<  setw(27) << left << "ONE CAMPUS (FOUNDATION)" << ":" << setw(3)<< right <<foundation_count << " ";
    for (int i = 0; i < foundation_count; i++) {
        cout << "\u25A0";
    }
    cout << endl;

    cout << setw(27) << left << "ONE CAMPUS TOTAL" << ":" << setw(3)<< right <<  state_count + foundation_count << " ";
    for (int i = 0; i < state_count + foundation_count; i++) {
        cout << "\u25A0";
    }
    cout << endl;
    cout << endl;

    // Multi-campus universities
    state_count = 0, foundation_count = 0;
    for (University* u : universities) {
        if (dynamic_cast<MultiCampusUniversity*>(u) != nullptr) {
            if (u->get_type() == 'S') {
                state_count++;
            } else {
                foundation_count++;
            }
        }
    }

    cout << setw(27) << left << "MULTI CAMPUS (STATE) " << ":" <<  setw(3) << right << state_count << " ";
    for (int i = 0; i < state_count; i++) {
        cout << "\u25A0";
    }
    cout << endl;

    cout <<  setw(27) << left << "MULTI CAMPUS (FOUNDATION)" << ":" << setw(3) << right << foundation_count << " ";
    for (int i = 0; i < foundation_count; i++) {
        cout << "\u25A0";
    }
    cout << endl;

    cout << setw(27) << left << "MULTI CAMPUS TOTAL"<< ":" << setw(3) << right << state_count + foundation_count << " ";
    for (int i = 0; i < state_count + foundation_count; i++) {
        cout << "\u25A0";
    }
    cout << endl;
    cout << endl;
    // Overall totals
    state_count = 0, foundation_count = 0;
    for (University* u : universities) {
        if (u->get_type() == 'S') {
            state_count++;
        } else {
            foundation_count++;
        }
    }

    cout << setw(27) << left << "OVERALL TOTAL (STATE)" << ":" << setw(3) << right <<  state_count << " ";
    for (int i = 0; i < state_count; i++) {
        cout << "\u25A0";
    }
    cout << endl;

    cout <<  setw(27) << left << "OVERALL TOTAL (FOUNDATION)" << ":" <<  setw(3) << right << foundation_count << " ";
    for (int i = 0; i < foundation_count; i++) {
        cout << "\u25A0";
    }
    cout << endl;

    // Cleanup

    for (University* u : universities) {
        delete u;
    }

    return 0;
}
