#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define MAX_OBJ         10000
#define MAX_CAPACITY    1000000


int n, capacity;
int max_value, current_value;
int room, k;
char taken[MAX_OBJ], current_taken[MAX_OBJ];

typedef struct {
    int index;
    int value;
    int weight;
    float density;
} Item;

Item item[MAX_OBJ];


void search_solu(void);
void save_taken(int k);
int cmp(const void *x, const void *y);


int main(int argc, char* argv[])
{
    FILE *fi;
    int i;

    if(argc==2){
        // check filename:
        // printf("filename = %s\n", argv[1]);

        // read data file:
        fi = fopen(argv[1], "rt");
        fscanf(fi, "%d %d\n", &n, &capacity);
        for(i=0;i<n;i++)
            fscanf(fi, "%d %d\n", &item[i].value, &item[i].weight);
        fclose(fi);

        for (i=0; i<n; i++) {
            item[i].index = i;
            item[i].density = (item[i].value+0.0)/(item[i].weight);
        }

        // solve problem:
        memset(taken,'0',sizeof(taken));
        memset(current_taken, '0', sizeof(current_taken));
        room = capacity;
        current_value = 0;
        max_value = 0;

        qsort(item, n, sizeof(Item), cmp);

        k = 0;
        search_solu();

        // write answer to standard output:
        printf("%d %d\n", max_value, 1);
        printf("%c",taken[0]);
        for(i=1;i<n;i++)
        printf(" %c",taken[i]);
        printf("\n");
    }
    return 0;
}

void search_solu(void)
{
    if (current_value+room*item[k].density<=max_value) {
        return;
    }
    if (room<=0 || k==n) {
        if (current_value <= max_value) {
            return;
        }
        else {
            max_value = current_value;
            save_taken(k-1);
            return;
        }
    }
    
    // pick item k
    if (room >= item[k].weight) {
        room -= item[k].weight;
        current_value += item[k].value;
        current_taken[item[k].index] = '1';
        k++;
        search_solu();
    
        // recover data
        k--;
        room += item[k].weight;
        current_value -= item[k].value;
        current_taken[item[k].index] = '0';
    }

    // don't pick item k
    k++;
    search_solu();
    k--;
}

void save_taken(int k)
{
    int i;
    for (i=0; i<=k; i++) {
        taken[item[i].index] = current_taken[item[i].index];
    }
    for (i=k+1; i<n; i++) {
        taken[item[i].index] = '0';
    }
    // for debug
    //printf("%d\n", max_value);
    /*
    for (i=0; i<n; i++) {
        printf(" %c", taken[i]);
    }
    printf("\n");
    */
}

int cmp(const void *x, const void *y)
{
    if (((Item *)x)->density > ((Item *)y)->density) {
        return -1;
    }
    else {
        return 1;
    }
}
