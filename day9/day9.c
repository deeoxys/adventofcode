// Advent of Code: Day 9 🇨
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>
#define rows 100    // make these 5 and 10 if u want to run test data~ 😌
#define columns 100

int foo(int arr[rows][columns]) {
    int riskLevelSum = 0;
    for (int row = 0; row < rows; row++) {
        for (int column = 0; column < columns; column++) {
            bool lowPoint = true;
            int local[4];
            local[0] = (column == 0) ? 10 : arr[row][column - 1];    // left
            local[1] = (column == columns - 1) ? 10 : arr[row][column + 1];    // right
            local[2] = (row == 0) ? 10 : arr[row - 1][column];    // top
            local[3] = (row == rows - 1) ? 10 : arr[row + 1][column];    // bottom
            for (int i = 0; i < 4; i++)
                if (local[i] != 10 && lowPoint)
                    if (local[i] <= arr[row][column]) lowPoint = false;
            if (lowPoint) riskLevelSum += arr[row][column] + 1;
        }
    }
    return riskLevelSum;
}

int main() {
    FILE *f = fopen("input.txt", "r");
    char lineBuffer[rows];  // char array that will read entire lines
    char lines[rows][columns];  // 2d char array to put line chars into
    int data[rows][columns];    // the same but for ints
    int i = 0;
    while (fgets(lineBuffer, rows + 2, f)) { // read 102 chars at a time, 100x values + \n + \0
        for (int j = 0; j < rows; j++) lines[i][j] = lineBuffer[j];    // set lines pointer to line buffer value
        i++;
    }
    free(f);    // 🦞🦞
    for (int row = 0; row < rows; row++)
        for (int column = 0; column < columns; column++)
            if (isdigit(lines[row][column])) data[row][column] = lines[row][column] - 48;   // ascii char 48 -> '0' to get int from chr
    printf("Risk level sum: %d\n", foo(data));
    return 1337;
}
