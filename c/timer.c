#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>


char* sec2[60] = {
    "00", "01","02","03","04","05","06","07","08","09",
    "10", "11","12","13","14","15","16","17","18","19",
    "20", "21","22","23","24","25","26","27","28","29",
    "30", "31","32","33","34","35","36","37","38","39",
    "40", "41","42","43","44","45","46","47","48","49",
    "50", "51","52","53","54","55","56","57","58","59",
};

void timer(int time) {
    int min, i;
    char* sec;
    while (time--) {
        i = time % 60;
        min = (time - i) / 60;
        printf("%c[2K   %2d:%s\r", 27, min, sec2[i]);
        fflush(stdout);
        sleep(1);
    }
    printf("\n");
    while(1) {
        time++;
        i = time % 60;
        min = (time - i) / 60;
        printf("%c[2K   %2d:%s\r", 27, min, sec2[i]);
        fflush(stdout);
        sleep(1);
    }
}


void err() {
    printf ("usage : chrono -m nb_minutes -s nb_seconds ");
    exit(1);
}

int main(int argc, char** argv) {
    if (argc > 5) {
        err();
    }
    if (strcmp(argv[1], "-m")) {
        if (strcmp(argv[1], "-s")) {
            timer ( atoi(argv[1]) );
        }
        timer ( atoi(argv[2]) );
    } else {
        int mins = atoi(argv[2]);
        if (argc == 3) {
            timer(60 * mins);
        } else {
            if (strcmp(argv[3], "-s") ) {
                err();
            }
            int sec = atoi(argv[4]);
            timer(60 * mins + sec);
        }
    }

    return 0;
}
