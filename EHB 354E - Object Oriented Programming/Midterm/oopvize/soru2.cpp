#include <iostream>
#include <string>
using namespace std;

class Collection {
private:
    string liste[10]; //Array of strings (items)
public:
    Collection() { //Default constructor
        for(int i=0; i<10; i++){
            liste[i] = "";
        }
    }
    void operator+ (string newitem){ //Member
        for(int i=0; i<10; i++){
            if(liste[i] == ""){
                liste[i] = newitem;
                return;
            }
        }
    }
    bool operator== (Collection other){ //Member
        for(int i=0; i<10; i++){
            if(liste[i] != other.liste[i]){
                return false;
            }
        }
        return true;
    }
    friend void operator<< (ostream& cihaz, Collection col); //Nonmember
};

void operator<< (ostream& cihaz, Collection col){ //Nonmember
    for(int i=0; i<10; i++){
        if(col.liste[i] != ""){
            cihaz << col.liste[i] << " ";
        }
    }
    cihaz << endl;
}

int main() {
    Collection C1, C2;
    C1 + "Apple";
    C1 + "Orange";
    C1 + "Cherry";
    C2 + "Apple";
    C2 + "Kiwi";
    cout << "Items in C1 collection: ";
    cout << C1;
    cout << "Items in C2 collection: ";
    cout << C2;
    if(C1 == C2){
        cout << "Two collections are equal" << endl;
    }
    else{
        cout << "Two collections are not equal" << endl;
    }
    return 0;
}

