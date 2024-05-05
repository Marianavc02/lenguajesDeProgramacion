#include <iostream>
int main()
{
    int number{ 0 };
    char another{ static_cast<char>(512) };
    double bigNumber{ 1.0 };
    float littleNumber{ static_cast<float>(bigNumber) };
    
    std::cout << "number: " << number << std::endl; //usando las variables
    std::cout << "another: " << another << std::endl;
    std::cout << "littleNumber: " << littleNumber << std::endl;

    return 0;
}
