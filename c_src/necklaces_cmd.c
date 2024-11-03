#include <stdio.h>
#include <stdlib.h>
#define MAX 99
#define TRUE 1
#define FALSE 0

typedef struct cell {
  int next,prev;
} cell;

typedef struct element {
  int s, v;
} element;

//-------------------------------------------------------------
// GLOBAL VARIABLES
//-------------------------------------------------------------
int N,K,D,M,type,head,NECK=0, LYN=0;
long long int total=0,limit=-1;
int UNRESTRICTED=0,DENSITY=0,CONTENT=0,FORBIDDEN=0,BRACELET=0,UNLABELED=0,CHORD=0,LIE=0,CHARM=0,DB=0;
int a[MAX], p[MAX], b[MAX], f[MAX], fail[MAX], num[MAX], run[MAX], num_map[MAX], charm[2*MAX+2];
int pos[MAX][MAX], split[MAX][MAX], d[MAX][MAX], match[MAX][MAX];
cell avail[MAX];
int nb = 0; // number of blocks
element B[MAX]; // run length encoding data structure
char PRIME[MAX]; // relatively prime array for charm bracelets

void PrintD(int p) {
  int i,j,next,end,min;

  /* Determine minimum position for next bit */
  next =  (D/p)*a[p] + a[D%p];
  if (next < N) return;

  /* Determine last bit */
  min = 1;
  if ((next == N) && (D%p != 0)) {
    min =  b[D%p]+1;
    p = D;
  }
  else if ((next == N) && (D%p == 0)) min = b[p];
  end = N;
  for( b[D]=min; b[D]<K; b[D]++ ) {
    i = 1;
    if ( LYN && (N%a[p] == 0) && (a[p] != N)) {}
    else {
      if (limit >=0 && total >= limit) {
        printf("output limit reached\n");
        exit(0);
      }
      total++;
      for(j=1; j<=end; j++) {
        if (a[i] == j) {
          printf("%d",b[i]);
          i++;
        }
        else printf("0");
      }
      printf("\n");
    }
    p = D;
  }
}
/*-----------------------------------------------------------*/
// FIXED DENSITY
/*-----------------------------------------------------------*/
void GenD(int t,int p) {
  int i,j,max,tail;

  if (t >= D-1) PrintD(p);
  else {
    tail = N - (D - t) + 1;
    max = a[t-p+1] + a[p];
    if (max <=tail) {
      a[t+1] = max;
      b[t+1] = b[t-p+1];

      GenD(t+1,p);
      for (i=b[t+1] +1; i<K; i++) {
        b[t+1] = i;
        GenD(t+1,t+1);
      }
      tail = max-1;
    }
    for(j=tail; j>=a[t]+1; j--) {
      a[t+1] =  j;
      for (i=1; i<K; i++) {
        b[t+1] =  i;
        GenD(t+1,t+1);
      }
    }
  }
}

void Init() {
  int i,j;
  for(j=0; j<=D; j++) a[j] = 0;
  if (D == 0) {
    if (NECK) {
      total++;
      for (j=1; j<=N; j++) printf("0");
      printf("\n");
    }
  }
  else if (D == 1) {
    for (i=1; i<K; i++) {
      total++;
      for (j=1; j<N; j++) printf("0");
      printf("%d \n",i);
    }
  }
  else {
    a[D] = N;
    for(j=N-D+1; j>=(N-1)/D + 1; j--) {
      a[1] = j;
      for (i=1; i<K; i++) {
        b[1] = i;
        GenD(1,1);
      }
    }
  }
}

int main(int argc, char *argv[]) {
  int i,j,n_digit,sum;

  sscanf(argv[1], "%d", &type);
  sscanf(argv[2], "%d", &N);
  sscanf(argv[3], "%d", &K);
  sscanf(argv[4], "%lld", &limit);
  sscanf(argv[5], "%d", &D);

  if (type != 2){
    printf("You are running the shorter version, need type == 2");
  };

  Init();
  return 0;
}

