// e65.cpp
// Calling the Constructor of the Base Class 

#include <iostream>
using namespace std;

class Teacher{								// Base class
	string name;
	int age,numOfStudents;
  public:
 	Teacher(string );			// Constructor of base
};

class Principal : public Teacher{  // Derived class
	int numOfTeachers;
  public:
	Principal(string , int);
};

// Body of the constructor of the base class 
Teacher::Teacher(string  new_name):name(new_name)
{
	cout << "Constructor of Teacher (Base)" << endl;
}

// Body of the constructor of derived class 
Principal::Principal(string  new_name, int numOT)
                    :Teacher(new_name), numOfTeachers(numOT)
{
	cout << "Constructor of Principal (Derived)" << endl;
}

// ----- Main Function -----
int main()
{
  Principal p1("Ali Bilir",20);
  return 0;
}


