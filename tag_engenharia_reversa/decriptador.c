#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <dirent.h>
#include <string.h>

FILE * fileReading(char * path, char * action) {
    FILE *pFile = fopen(path, action);
    if(pFile == NULL) {
        fprintf(stderr,"Error : Falha ao abrir o arquivo %s\n", path);
        exit(-1);
    }

    return pFile;
}

int main(void) {

    // Pega o nome da pasta de arquivos encriptados (que é o mesmo do $USER).
    char *dir_path = getenv("USER");
    if(dir_path == NULL) {
        fprintf(stderr, "Pasta dos arquivos encriptados não encontrada.\n");
        exit(-1);
    }

    // Abre a pasta de arquivos encriptados.
    DIR *user_dir = opendir(dir_path);
    if(user_dir == NULL) {                                 
        fprintf(stderr,"Error : Falha ao abrir o diretório - %s\n",dir_path);
        exit(-1);
    }

    // Pega a chave de criptografia.
    FILE *pFile = fileReading("/tmp/key", "r");
    int key = (int)getc(pFile) - 48;
    fclose(pFile);

    char file_encr [512];
    char file_decr [512];
    int get_val;

    // Abre os arquivos e executa a descriptografia.
    struct dirent * dir_entry;
    FILE *decrFile;
    while(dir_entry = readdir(user_dir), dir_entry != NULL) {
        int comp = strcmp(dir_entry->d_name, ".");
        if ((comp != 0) && (comp = strcmp(dir_entry->d_name,".."), comp != 0)) {
            // Abre o arquivo encriptado.
            sprintf(file_encr, "%s/%s", dir_path, dir_entry->d_name);
            pFile = fileReading(file_encr, "rw");
            // Cria um novo arquivo para receber os valores descriptado.
            sprintf(file_decr, "%s.decr", file_encr);
            decrFile = fopen(file_decr, "w");
            if(decrFile == NULL) {
                printf("Deu ruim!!");
                exit(-1);
            }
            // Processo de descriptografia.
            while(get_val = fgetc(pFile), get_val != EOF) {
                fputc((char)get_val - key, decrFile);
            }
            fclose(decrFile);
            fclose(pFile);
        }
    }

    return 0;
}