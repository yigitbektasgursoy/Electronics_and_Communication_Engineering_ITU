// e32.cpp
// this Pointer
// http://www.buzluca.info/oop

#include <iostream>
using namespace std;

class Point{				// Delaration Point Class
 public:
	int x,y;					// Properties: x ve y coordinates
	void move(int, int);	// A function to move points
	void print();			// to prints cordinates on the screen
	bool is_zero();		// is point on the zero point(0,0)
};

// ***** Bodies of Member Functions *****

// A function to move the points 
void Point::move(int new_x, int new_y)
{
	x = new_x;				// assigns new value to x coordinat
	y = new_y;				// assigns new value to y coordinat 
}

// To print the coordinates on the screen 
void Point::print()
{
	cout << "X= " << x << ", Y= " << y << endl;
}
				
// is the point on the zero point(0,0)
bool Point::is_zero()
{
	return (x == 0) && (y == 0);	  
}


// Finds the point that has the largest distance from (0,0)
Point * find_max_distance (Point & p1, Point & p2) {

   unsigned long distance1 =( p1.x * p1.x) + (p1.y * p1.y); 
   unsigned long distance2 =( p2.x * p2.x) + (p2.y * p2.y);    

   if (distance1 > distance2 ) return &p1;
       else return &p2;		         
}

int main() {
  Point point1,point2;		// Two objects: point1 , point2
  point1.move(100,50);	
  point2.move(20,65);		
  Point * a;			// a is a pointer that will point one of them.
  a=find_max_distance(point1, point2);
  a->print();	// the point that has the largest distance on the screen
  return 0;
}




