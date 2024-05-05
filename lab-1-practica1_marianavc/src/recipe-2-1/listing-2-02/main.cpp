#include <iostream>
class MyClass
{
private:
 int m_Member;
public:
 MyClass() = default;
 MyClass(const MyClass& rhs) = default;
};
int main()
{
 MyClass objectA{}; // inicializacion de el objetoA
 MyClass objectB{MyClass{}};
 return 0;
}