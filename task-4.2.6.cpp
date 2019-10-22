
#include <iostream>

using namespace std;



struct Cell {
  Cell* next = 0;
  // Cell* previous;
  int value = 0;
};

void ll_print(Cell* cell) {
  // Cell* cell = list->begin();
  while (cell->next != 0) {
    cell = cell->next;
    cout << cell->value << " ";
  }
  cout << endl;
}

class stack {
private:
  Cell* _begin;
  unsigned int size = 0;

public:
  stack ();
  virtual ~stack ();
  int push(int x);
  int pop();
  Cell* begin();
  int length();
};


stack::stack() {
  _begin = new Cell;
}
stack::~stack() {
  Cell* previous = _begin;
  Cell* current = _begin;
  while (current->next != 0) {
    previous = current;
    current = current->next;
    delete previous;
  }
  delete current;
  // delete &size;
}
Cell* stack::begin() {
  return _begin;
}
int stack::length() {
  return size;
}

int stack::push (int x) {
  Cell* new_cell = new Cell;
  new_cell->next = _begin->next;
  new_cell->value = x;
  _begin->next = new_cell;
  size++;
  return size;
}

int stack::pop () {
  if (size < 1) {
    throw "stack: pop() on empty stack";
    // throw range_error("ll: Out of bounds");
    // return NULL; // Error, out of bounds
  }
  Cell* buffer = _begin->next->next;
  int value = _begin->next->value;
  delete _begin->next;
  _begin->next = buffer;
  size--;
  return value;
}



int main(int argc, char const *argv[]) {

  try {

    // Start

    // cout << "In all tests lines should be identical.\n\n";

    cout << "= Creation test\nShould be an empty line\n";
    stack stack1 = stack();
    ll_print(stack1.begin());

    cout << "\n= Push test\nShould be \"4 3 123123 123\"\n";
    stack1.push(123);
    stack1.push(123123);
    stack1.push(3);
    stack1.push(4);
    ll_print(stack1.begin());

    cout << "\n= Pop test\nShould be \"4 3 123123 123\"\n";
    cout << stack1.pop() << " ";
    cout << stack1.pop() << " ";
    cout << stack1.pop() << " ";
    cout << stack1.pop() << endl;

    cout << "\n= Length test\nShould be \"0\"\n";
    cout << stack1.length() << endl;


  } catch (const char* msg) {
    cerr << msg << endl;
  }

  return 0;
}
