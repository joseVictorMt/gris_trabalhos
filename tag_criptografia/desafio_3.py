# ==========================================================
# Author: José Victor Medeiros Thomé da Silva
# Date: 25/02/2020
# Description: Desafio 3 de criptografia do PS GRIS 2020.1.
# ==========================================================
import re  # Biblioteca de expressões regulares do python.
from collections import Counter # Dicionário contador.
from math import sqrt

ENGLISH_FREQUENCY_TABLE = {
    'a' : 0.8167,
    'b' : 0.1492,
    'c' : 0.2202,
    'd' : 0.4253,
    'e' : 1.2702,
    'f' : 0.2228,
    'g' : 0.2015,
    'h' : 0.6094,
    'i' : 0.6966,
    'j' : 0.0153,
    'k' : 0.1292,
    'l' : 0.4025,
    'm' : 0.2406,
    'n' : 0.6749,
    'o' : 0.7507,
    'p' : 0.1929,
    'q' : 0.0095,
    'r' : 0.5987,
    's' : 0.6327,
    't' : 0.9356,
    'u' : 0.2758,
    'v' : 0.0978,
    'w' : 0.2560,
    'x' : 0.0150,
    'y' : 0.1994,
    'z' : 0.0077
}

def xor_decrypt_msg(key, hex_msg):
    '''Decripta a mensagem passada pela cifra XOR usando a chave passada.'''

    # Converte a mensagem para o formato ascii e a chave para seu valor unicode.
    msg = bytearray.fromhex(hex_msg).decode('ascii')
    key = ord(key)

    # Cada letra da mensagem é convertida para o valor unicode antes de decriptar.
    decrypted = ''.join([chr(ord(letter) ^ key) for letter in msg])
    # Retorna a mensagem decriptada e sem caracteres de controle.
    return re.sub(r'[\x00-\x1f\x7f-\x9f]', '', decrypted)

def decrypt_score(string):
    '''Calcula a taxa de pontuação da string decriptada com uma frase em inglês.'''

    char_counter = Counter(string.lower())
    string_size = len(string)
    score = 0
    for letter, quant in char_counter.items():
        score += sqrt(ENGLISH_FREQUENCY_TABLE.get(letter, 0) * quant/string_size)

    return score

def detect_key(encrypted_hex):
    '''Procura a chave de decriptação desejada para a string.'''

    bigger = -1
    winner = None
    for key in range(ord('a'), ord('z') + 1):
        score = decrypt_score(xor_decrypt_msg(chr(key), encrypted_hex))
        if(bigger < score):
            winner = chr(key)
            bigger = score

    for key in range(ord('A'), ord('Z') + 1):
        score = decrypt_score(xor_decrypt_msg(chr(key), encrypted_hex))
        if(bigger < score):
            winner = chr(key)
            bigger = score

    return winner


encrypted = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
detected_key = detect_key(encrypted)
print(detected_key)
print(xor_decrypt_msg(detected_key, encrypted))
