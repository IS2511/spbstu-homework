
#include <iostream>

using namespace std;



struct Cell {
  Cell* next = 0;
  // Cell* previous;
  int value = 0;
};

class ll {
private:
  Cell* cell;
  unsigned int size = 0;

public:
  ll ();
  virtual ~ll ();
  int append(int x, int k);
  int append(int x);
  int remove(int k);
  int get(int k);
  void inverse();
  Cell* begin();
  int length();
};



ll::ll () {
  cell = new Cell;
}
ll::~ll () {
  // cout << "Help! I'm being deleted!" << endl;
  Cell* previous = cell;
  Cell* current = cell;
  while (current->next != 0) {
    previous = current;
    current = current->next;
    delete previous;
  }
  delete current;
  // delete &size;
}
Cell* ll::begin() {
  return cell;
}
int ll::length() {
  return size;
}

int ll::append (int x, int k) {
  if (k > size || k < 0) {
    throw "ll: Out of bounds";
    // throw range_error("ll: Out of bounds");
    // return NULL; // Error, out of bounds
  }
  Cell* previous = cell;
  Cell* current = cell;
  Cell* new_cell = new Cell;
  new_cell->value = x;
  int i = -1;
  while ( (current->next != 0) && (i < k) ) {
    previous = current;
    current = current->next;
    i++;
  }
  new_cell->next = current;
  previous->next = new_cell;
  current = new_cell;
  size++;
  return (i);
}
int ll::append (int x) {
  Cell* current = cell;
  Cell* new_cell = new Cell;
  new_cell->value = x;
  int i = -1;
  while (current->next != 0) {
    current = current->next;
    i++;
  }
  current->next = new_cell;
  size++;
  return (i);
}

int ll::get (int k) {
  if (k+1 > size || k < 0) {
    throw "ll: Out of bounds";
    // throw range_error("ll: Out of bounds");
    // return NULL; // Error, out of bounds
  }
  Cell* previous = cell;
  Cell* current = cell;
  int i = -1;
  while ( (current->next != 0) && (i < k) ) {
    previous = current;
    current = current->next;
    i++;
  }
  return current->value;
}

int ll::remove (int k) {
  if (k+1 > size || k < 0) {
    throw "ll: Out of bounds";
    // throw range_error("ll: Out of bounds");
    // return NULL; // Error, out of bounds
  }
  Cell* previous = cell;
  Cell* current = cell;
  Cell* next = cell;
  int i = -1;
  while ( (current->next != 0) && (i < k) ) {
    previous = current;
    current = current->next;
    next = current->next;
    i++;
  }
  previous->next = next;
  int value = current->value;
  delete current;
  size--;
  return value;
}

void ll::inverse() {
  if (size < 2) {
    return;
  }
  Cell* buffer = cell->next;
  Cell* previous = cell->next;
  Cell* current = cell->next;
  int i = 0;
  while ( (current->next != 0) ) {
    previous = current;
    current = current->next;
    i++;
    buffer = current->next;
    current->next = previous;
    previous->next = buffer;
  }
}




void ll_print(ll* list) {
  Cell* cell = list->begin();
  while (cell->next != 0) {
    cell = cell->next;
    cout << cell->value << " ";
  }
  cout << endl;
}

int main(int argc, char const *argv[]) {

  try {

    // Start
    ll list1 = ll();
    list1.append(123);
    list1.append(123123);
    list1.append(3);
    list1.append(4);

    ll_print(&list1);

    list1.append(1, 0);
    ll_print(&list1);
    list1.append(2, 0);
    ll_print(&list1);
    list1.append(13, 1);
    ll_print(&list1);
    list1.append(123123123, 4);
    ll_print(&list1);
    list1.append(123123123, 5);
    ll_print(&list1);
    list1.append(123123123, 7); // Out of bounds
    ll_print(&list1);

    cout << list1.get(0) << endl;
    cout << list1.get(1) << endl;
    cout << list1.get(2) << endl;
    cout << list1.get(3) << endl;
    cout << list1.get(8) << endl;
    cout << list1.get(9) << "\n\n";
    cout << list1.length() << "\n\n";

    for (size_t i = list1.length()-1; i > 0; i--) {
      cout << list1.remove(i) << endl;
      ll_print(&list1);
    }
    cout << endl;

    list1.append(1, 0);
    list1.append(3);
    ll_print(&list1);
    list1.remove(1);
    ll_print(&list1);

    list1.append(2, 1);
    list1.append(4);
    list1.inverse();
    ll_print(&list1);

  } catch (const char* msg) {
    cerr << msg << endl;
  }

  return 0;
}
