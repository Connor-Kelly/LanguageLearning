// #include <iostream>
#include <stdio.h>

int main()
{
    FILE *filePointer;
    char buf[1024];

    filePointer = fopen("d8.txt", "r");
    // filePointer = fopen("d6smol.txt", "r");
    fread(buf, sizeof(buf), 1, filePointer);
    int count = 0;
    // std::cout << "hello";
    while (!feof(filePointer))
    {
        // Print the read data
        printf("%s\n", buf);

        // for (size_t i = 0; i < 14; i++)
        // {
        //     for (size_t j = 1; j < 14 - i; j++)
        //     {
        //         if ( buf[i] == buf[i + j]) {
        //             // printf("goto outer\n");
        //             count++;
        //             goto outer;
        //         }
        //     }
        // }
        // goto finish;
        // printf("finish");

        // outer:
        // for (int i = 0; i < 14; i++)
        // {
        //     buf[i] = buf[i+1];
        //     /* code */
        // }
        
        // buf[0] = buf[1];
        // buf[1] = buf[2];
        // buf[2] = buf[3];
        // for (size_t i = 2; i > 0; i--)
        // {
        //     buf[i + 1] = buf[i];
        // }
        // if (count == 10) {
        //     goto finish;
        // }
        
        fread(buf, sizeof(buf), 1, filePointer);
    }
    finish: 
    // printf(">> %s\n", buf);
    // printf(">> %d\n", count);

    fclose(filePointer);
    return 0;
}