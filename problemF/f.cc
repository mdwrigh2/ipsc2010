#include <algorithm>
#include <numeric>
#include <iostream>
#include <vector>
using namespace std;

int Alla (vector<int> cubes) {
  // sort in descending order
  sort( cubes.begin(), cubes.end(), greater<int>() ); 
  // if there are more than 15 cubes, take 15 largest
  int N = min( 15, (int)cubes.size() ); 
  int result = 0;
  // try all possible sets of cubes in the first tower
  for (int first=0; first<(1<<N); ++first) { 
    int first_tower = 0;
    vector<int> remains;
    for (int i=0; i<N; ++i) 
      if (first & 1<<i) first_tower += cubes[i];
      else remains.push_back( cubes[i] );
    int M = remains.size();
    // try all possible sets of cubes in the second tower
    for (int second=0; second<(1<<M); ++second) {
      int second_tower = 0;
      for (int i=0; i<M; ++i) if (second & 1<<i) second_tower += remains[i];
      if (first_tower==second_tower) result = max( result, first_tower );
    }
  }
  return result;
}

bool partition (vector<int> cubes) {
  int S = accumulate( cubes.begin(), cubes.end(), 0 ); // S = sum of cube sizes
  if (S%2) return false;
  vector<bool> possible(S+1,false);
  possible[0] = true;
  for (unsigned i=0; i<cubes.size(); ++i)
    for (int j=S; j>=cubes[i]; --j)
      if (possible[j-cubes[i]])
        possible[j] = true;
  return possible[S/2];
}

int Bob (vector<int> cubes) {
  int N = cubes.size();
  int S = accumulate( cubes.begin(), cubes.end(), 0 ); // S = sum of cube sizes

  if (partition(cubes)) return S/2;
  int result = 0;

  // try all possibilities without one cube
  for (int i=0; i<N; ++i) {
    vector<int> tmp = cubes;
    tmp.erase( tmp.begin() + i ); // erase the i-th cube
    if (partition(tmp)) result = max(result, (S-cubes[i])/2 );
  }

  // try all possibilities without two cubes
  for (int i=0; i<N; ++i) {
    for (int j=0; j<i; ++j) {
      vector<int> tmp = cubes;
      tmp.erase( tmp.begin() + i ); // erase the i-th cube
      tmp.erase( tmp.begin() + j ); // erase the j-th cube
      if (partition(tmp)) result = max(result, (S-cubes[i]-cubes[j])/2 );
    }
  }
  return result;
}

int Chermi (vector<int> cubes) {
  // sort in descending order
  sort( cubes.begin(), cubes.end(), greater<int>() ); 
  int N = cubes.size();
  int S = accumulate( cubes.begin(), cubes.end(), 0 ); // S = sum of cube sizes
  for (int height=S/2; height>0; --height) {
    int first_tower = 0, second_tower = 0;
    for (int c=0; c<N; ++c) {
      if (first_tower + cubes[c] <= height) first_tower += cubes[c];
      if (first_tower > second_tower) swap(first_tower, second_tower);
    }
    if (first_tower==height && second_tower==height) return height;
  }
  return 0;
}

int Dominika (vector<int> cubes) {
  int N = cubes.size();
  int S = accumulate( cubes.begin(), cubes.end(), 0 ); // S = sum of cube sizes
  vector<int> ways(S+1,0);
  ways[0] = 1;
  for (int i=0; i<N; ++i)
    for (int j=S; j>=cubes[i]; --j)
      ways[j] = min( 2, ways[j] + ways[j-cubes[i]] );
  for (int height=S/2; height>0; --height)
    if (ways[2*height]>0 && ways[height]>1)
      return height;
  return 0;
}

int main() {
  int N;
  cin >> N;
  vector<int> cubes(N);
  for (int n=0; n<N; ++n) cin >> cubes[n];
  cout << "Alla: " << Alla(cubes) << endl;
  cout << "Bob: " << Bob(cubes) << endl;
  cout << "Chermi: " << Chermi(cubes) << endl;
  cout << "Dominika: " << Dominika(cubes) << endl;
}
