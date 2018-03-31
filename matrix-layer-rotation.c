// https://www.hackerrank.com/challenges/matrix-rotation-algo/problem
// progress: 100%

#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>
#include <stdbool.h>

int get_index(int n_cols, int row, int col) {
    return row * n_cols + col;
}

void rotate_reverse(int row_min, int row_max, int col_min, int col_max, int *row, int *col, int n_rot) {
    int n_rows = row_max - row_min;
    int n_cols = col_max - col_min;
    int whole_circle_moves = n_rows * 2 + n_cols * 2;

    // convert row and col to flat index
    int index = 0;
    if (*row == row_min)
        index = *col - col_min;
    else if (*col == col_max)
        index = n_cols + *row - row_min;
    else if (*row == row_max)
        index = n_cols + n_rows + (col_max - *col);
    else if (*col == col_min)
        index = n_cols * 2 + n_rows + (row_max - *row);

    // add rotations to the index
    index = (index + n_rot) % whole_circle_moves;

    // convert index back to x and y coordinates
    if (index < n_cols) {
        // upper horizontal
        *row = row_min;
        *col = col_min + index;
    } else if (index < n_cols + n_rows) {
        // right vertical
        *col = col_max;
        *row = row_min + (index - n_cols);
    } else if (index < n_cols * 2 + n_rows) {
        // lower horizontal
        *row = row_max;
        *col = col_max - (index - n_cols - n_rows);
    } else {
        // left vertical
        *col = col_min;
        *row = row_max - (index - n_cols - n_rows - n_cols);
    }
}

int main() {
    int n_rows; 
    int n_cols;
    int n_rot; 
    scanf("%i %i %i", &n_rows, &n_cols, &n_rot);
    int matrix[n_rows * n_cols];
    for (int row = 0; row < n_rows; row++) {
       for (int col = 0; col < n_cols; col++) {
          scanf("%i", &matrix[get_index(n_cols, row, col)]);
       }
    }

    int matrix_rotated[n_rows * n_cols];
    for (int i = 0; 1; i++) {
        int col_min = i;
        int col_max = n_cols - i - 1;
        int row_min = i;
        int row_max = n_rows - i - 1;
        if (col_min >= col_max || row_min >= row_max)
            break;
        for (int col = col_min; col <= col_max; col++) {
            for (int row = row_min; row <= row_max; row++) {
                if (col == col_min || col == col_max || row == row_min || row == row_max) {
                    int col_rot = col;
                    int row_rot = row;
                    rotate_reverse(row_min, row_max, col_min, col_max, &row_rot, &col_rot, n_rot);
                    matrix_rotated[get_index(n_cols, row, col)] = matrix[get_index(n_cols, row_rot, col_rot)];
                }
            }
        }
    }

    for (int row = 0; row < n_rows; row++) {
        for (int col = 0; col < n_cols; col++)
            printf("%d ", matrix_rotated[get_index(n_cols, row, col)]);
        printf("\n");
    }

    return 0;
}

