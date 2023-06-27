#include <iostream>
#include <list>
#include <string>
#include <algorithm>
#include <cctype>
#include <ctime>

using namespace std;

struct Employee { 
 int ID; 
 string Name;
};

class BST {
public:
    struct Node {
        Employee emp; 
        Node *left, *right;
    }; 

    string deptname; 
    Node * root; 

    BST (string deptname, Employee kaynak[] , int N) : root(nullptr), deptname(deptname) {
        for(int i=0; i<N; i++) {
            ADD(kaynak[i]);
        }
    }

    bool ADD (Employee yeni) { 
        Node* newNode = new Node{yeni, nullptr, nullptr};
        if(root == nullptr){
            root = newNode;
        } else {
            Node* current = root;
            while(current){
                if(yeni.ID == current->emp.ID) return false;
                if(yeni.ID < current->emp.ID){
                    if(current->left == nullptr){
                        current->left = newNode;
                        return true;
                    } else {
                        current = current->left;
                    }
                } else {
                    if(current->right == nullptr){
                        current->right = newNode;
                        return true;
                    } else {
                        current = current->right;
                    }
                }
            }
        }
        return true;
    }

    BST (int N) : root(nullptr), deptname("Testing") { 
        srand(time(0));
        for(int i=0; i<N; i++) {
            Employee emp;
            emp.ID = rand();
            emp.Name = to_string(rand());
            ADD(emp);
        }
    }

    BST (const BST & other_tree) : root(nullptr), deptname(other_tree.deptname) {
        DUPLICATE(other_tree.root);
    }

    void DUPLICATE (Node * otherP) {
        if(otherP) {
            ADD(otherP->emp);
            DUPLICATE(otherP->left);
            DUPLICATE(otherP->right);
        }
    }

    Employee * SEARCH (string isim) {
        Node * current = root;
        transform(isim.begin(), isim.end(), isim.begin(), ::toupper);
        while(current){
            string currentName = current->emp.Name;
            transform(currentName.begin(), currentName.end(), currentName.begin(), ::toupper);
            if(currentName.find(isim) != string::npos) {
                return &(current->emp);
            } else if(isim < currentName){
                current = current->left;
            } else {
                current = current->right;
            }
        }
        return nullptr;
    }

    Employee * SEARCH (int idnum, Node * P) {
        if(P){
            if(P->emp.ID == idnum) return &(P->emp);
            if(idnum < P->emp.ID) return SEARCH(idnum, P->left);
            return SEARCH(idnum, P->right);
        }
        return nullptr;
    }

    void DISPLAY (Node * P) {
        if(P) {
            DISPLAY(P->left);
            cout << "ID: " << P->emp.ID << ", Name: " << P->emp.Name << endl;
            DISPLAY(P->right);
        }
    }
};

int main() { 
    list<BST> trees;

    Employee distEmployees[] = {{101, "Sunay"}, {102, "Cihan"}, {103, "Üner"}, {104, "Kaptan"}};
    BST dist("Distribution", distEmployees, 4);
    trees.push_back(dist);

    Employee accEmployees[] = {{201, "Şenol"}, {202, "Aktaş"}, {203, "Kaplan"}, {204, "Sungur"}};
    BST acc("Accounting", accEmployees, 4);
    trees.push_back(acc);

    Employee prodEmployees[] = {{301, "Çakır"}, {302, "Sunay"}, {303, "Acar"}};
    BST prod("Production", prodEmployees, 3);
    trees.push_back(prod);

    Employee markEmployees[] = {{401, "İlker"}, {402, "Vedat"}, {403, "Ceyhan"}};
    BST mark("Marketing", markEmployees, 3);
    trees.push_back(mark);

    BST distCopy(dist);
    trees.push_back(distCopy);

    BST randomTree(6);
    trees.push_back(randomTree);

    for(auto& tree : trees) {
        cout << "Department: " << tree.deptname << endl;
        tree.DISPLAY(tree.root);
        cout << endl;
    }

    while(true){
        string input;
        cout << "Enter a search value (Employee ID integer or Employee Name string): ";
        cin >> input;
        if(isdigit(input[0])){
            int id = stoi(input);
            for(auto& tree : trees) {
                Employee* emp = tree.SEARCH(id, tree.root);
                if(emp){
                    cout << "Found in " << tree.deptname << ", ID: " << emp->ID << ", Name: " << emp->Name << endl;
                }
            }
        } else {
            for(auto& tree : trees) {
                Employee* emp = tree.SEARCH(input);
                if(emp){
                    cout << "Found in " << tree.deptname << ", ID: " << emp->ID << ", Name: " << emp->Name << endl;
                }
            }
        }
    }

    return 0;
}