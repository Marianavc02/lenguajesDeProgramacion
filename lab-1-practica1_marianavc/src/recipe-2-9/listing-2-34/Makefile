# Compilador
CXX = g++

# mis flags 
CXXFLAGS = -std=c++20 -Wall -Wextra -Werror

# Compila y crea ejecutable
main: main.cpp
	$(CXX) $(CXXFLAGS)  -o main main.cpp

# limpiar elimina los archivos del ejecutable y los archivos de objeto del directorio/ @ evita que imprima comando y hace que solo imprima una vez lo que hay en comillas , agrege @ a rm para que no salga al ejecutar
clean:
	@echo "Limpiando archivos de objeto y ejecutable..."
	@rm -f main.o main
	@echo "¡Limpieza completada!"