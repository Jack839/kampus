#include<iostream>
#include "myHeader.h"

using namespace std;

void printNum(int x) {
  cout << "int";
}

void printNum(float x) {
  cout << "float";
}

int main() {
  const int a = 1;
  float b = 6.328;
//awesome stuff
  printNum(a);
  printNum(b);
}
