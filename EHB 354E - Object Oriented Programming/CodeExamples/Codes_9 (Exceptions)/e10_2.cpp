// e10_2.cpp
// http://www.buzluca.info/oop
// Example2 for exceptions
#include <iostream>
using namespace std;

float fraction(int num, int denom)
{
	if(denom==0) throw "Divide by zero";
	if(denom<0) throw "Negative Denominator";
	if(denom>1000) throw -1;
	return static_cast<float>(num)/denom;
}

int main()
{
	int numerator,denumerator;
	cout << endl << "Enter the numerator ";
	cin >> numerator;
	cout << endl << "Enter the denumerator ";
	cin >> denumerator;
	try{
		cout << fraction(numerator,denumerator);
	}
/*	catch (const char * result){		// catch for char*s
		cout << endl << result;
	}
	catch (int ){							// catch for ints
		cout << endl << "Error";
	} */
	catch (...){							// catch for ints
		cout << endl << "Genel amacli hata yakalama\n";
	}
	
	
	cout << endl << "End of Program";
	return 0;
}


