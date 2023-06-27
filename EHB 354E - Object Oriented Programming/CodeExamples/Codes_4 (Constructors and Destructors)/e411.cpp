// e411.cpp
// http://www.buzluca.info/oop
// nested objects , orders of constructors and destructors
#include <iostream>
using namespace std;

// The inner class 
class classA{
 public:
	 classA(){ cout << "Constructor Class A" << endl;}
	 ~classA(){ cout << "Destructor Class A" << endl;}
};

// The enclosing class. Contains two objects of class A as members 
class classB{
	 classA m1,m2;    // Two member objects
 public:
	 classB(){ cout << "Constructor Class B" << endl;}
	 ~classB(){ cout << "Destructor Class B" << endl;}
};

// ----- Main Function -----
int main()
{
	classB objecOfB;
	return 0;
}
