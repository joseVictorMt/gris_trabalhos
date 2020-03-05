# ==========================================================
# Author: José Victor Medeiros Thomé da Silva
# Date: 25/02/2020
# Description: Desafio 3 de criptografia do PS GRIS 2020.1.
# ==========================================================

# Tabela de frequência de aparições das letras do idioma Inglês de 'a' a 'z' e ' '.
# A tabela foi toda extraida da página https://en.wikipedia.org/wiki/Letter_frequency
# exceto pelo caractere ' ' no qual foi colocada maior frequência por ser conveniente.
ENGLISH_FREQUENCY_TABLE = {
    'a': 0.08167, 'b': 0.01492, 'c': 0.02782, 'd': 0.04253,
    'e': 0.12702, 'f': 0.02228, 'g': 0.02015, 'h': 0.06094,
    'i': 0.06094, 'j': 0.00153, 'k': 0.00772, 'l': 0.04025,
    'm': 0.02406, 'n': 0.06749, 'o': 0.07507, 'p': 0.01929,
    'q': 0.00095, 'r': 0.05987, 's': 0.06327, 't': 0.09056,
    'u': 0.02758, 'v': 0.00978, 'w': 0.02360, 'x': 0.00150,
    'y': 0.01974, 'z': 0.00074, ' ': 0.16000
}

def xor_decrypt_msg(key, hex_msg):
    '''Decripta a mensagem passada (em hexadecimal) pela cifra XOR usando a chave passada.'''

    msg = bytes.fromhex(hex_msg) # Converte de hexadecimal para string bytes ascii.
    decrypted = b''

    # Realiza XOR em cada uma das letras da mensagem encriptada.
    for letter in msg:
        decrypted += bytes([letter ^ key])

    return decrypted

def decrypt_score(decrypted):
    '''Calcula a taxa de pontuação da string decriptada com uma frase em inglês.'''

    return sum([ENGLISH_FREQUENCY_TABLE.get(chr(letter), 0) for letter in decrypted.lower()])

def bigger_key_score(first_key, last_key, encrypted_hex):
    '''Calcula e avalia qual chave dentro do intervalo [first_key, last_key] tem
       maior taxa de pontuação.'''

    bigger = -1
    winner = None
    winner_decr = ''

    for key in range(first_key, last_key + 1):
        msg = xor_decrypt_msg(key, encrypted_hex)
        score = decrypt_score(msg)
        if(bigger < score):
            bigger = score
            winner = chr(key)
            winner_decr = msg

    return bigger, winner, winner_decr

def detect_key(encrypted_hex):
    '''Procura a chave que decripta a string encriptada em hexadecimal pela cifra de XOR.
       A dedução é feita pela soma das frequências das letras em ENGLISH_FREQUENCY_TABLE.'''

    # Verifica pelas letras minúsculas de 'a' a 'z'.
    l_score, l_winner, l_winner_decr = bigger_key_score(ord('a'), ord('z'), encrypted_hex)
    # Verifica pelas letras maiúsculas de 'A' a 'Z'
    u_score, u_winner, u_winner_decr = bigger_key_score(ord('A'), ord('Z'), encrypted_hex)

    if(u_score > l_score):
        return u_winner, u_winner_decr.decode("utf-8")

    return l_winner, l_winner_decr.decode("utf-8")

def main():
    encrypted = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
    detected_key, message = detect_key(encrypted)
    print("Chave detectada:      ", detected_key)
    print("Mensagem descriptada: ", message)

if __name__ == "__main__":
    main()
