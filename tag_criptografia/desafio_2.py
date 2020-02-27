# ==========================================================
# Author: José Victor Medeiros Thomé da Silva
# Date: 25/02/2020
# Description: Desafio 2 de criptografia do PS GRIS 2020.1.
# ==========================================================

def fixed_xor(buff_1, buff_2):
    ''' Produz uma combinação XOR entre dois buffers '''

    if(len(buff_1) != len(buff_2)):
        print("Os valores dos buffers não tem tamanho igual.")
        return -1

    return str(hex(int(buff_1, 16) ^ int(buff_2, 16)))[2:]


#buff_1 = "1c0111001f010100061a024b53535009181c"
#buff_2 = "686974207468652062756c6c277320657965"
buff_1 = input("Entre com o primeiro valor hexadecimal: ")
buff_2 = input("Entre com o segundo valor hexadecimal: ")
print(fixed_xor(buff_1, buff_2))
