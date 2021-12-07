#include <bits/stdc++.h>
using namespace std;

int mostFrequent(int arr[], int size) {
    sort(arr, arr + size);

    int max_count = 1, res = arr[0], curr_count = 1;
    for (int i = 1; i < size; i++) {
        if (arr[i] == arr[i - 1]) {
            curr_count++;
        } else {
            if (curr_count > max_count) {
                max_count = curr_count;
                res = arr[i - 1];
            }
            curr_count = 1;
        }
    }
    if (curr_count > max_count) {
        max_count = curr_count;
        res = arr[size - 1];
    }
    return res;
}

int foo(int arr[], int n, int size) {
    int fuel_used = 0;

    for (int i = 0; i < size; i++) {
        if (arr[i] > n) {
            fuel_used += arr[i] - n;
        } else {
            fuel_used += n - arr[i];
        }
    }

    return fuel_used;
}

int main() {
    // int test_data[] = {16, 1, 2, 0, 4, 2, 7, 1, 2, 14};
    // int size = sizeof(test_data) / sizeof(test_data[0]);

    int data[1000]; // hard coded. meh

    int c = 0;
    string line;
    ifstream myfile("input.txt");
    if (myfile.is_open()) {
        while (!myfile.eof()) {
            getline(myfile, line, ',');
            // cout << line << endl;
            data[c] = stoi(line);
            c++;
        }
        myfile.close();
    }

    // find lowest
    int fuel_used = 0;
    for (int i = 1; i <= 1000; i++) {
        if (i == 1) {
            fuel_used = foo(data, 1, 1000);
        }
        
        // cout << foo(data, i, 1000) << endl;
        if (foo(data, i, 1000) < fuel_used) {
            fuel_used = foo(data, i, 1000);
        }
    }

    // fuel_used = foo(data, mostFrequent(data, 1000), 1000);
    cout << "Fuel used in best case scenario: " << fuel_used << endl;
    
    return 0;
}