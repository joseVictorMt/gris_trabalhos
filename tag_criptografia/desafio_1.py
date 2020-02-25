# Desafio 1 de criptografia

class Base_64:
    ''' Representa um tratador de mensagens na base 64. '''

    def __init__(self):
        ''' Inicializa o objeto tratador gerando a tabela da base 64 a
            ser usada nas operações. '''
        self.table_generator()

    def table_generator(self):
        ''' Gera a tabela de caracteres da base 64. '''

        upper_a = 65
        upper_case_letters = [ chr(upper_a + i) for i in range(26) ]

        lower_a = 97
        lower_case_letters = [ chr(lower_a + i) for i in range(26) ]

        from_0_to_9 = [ str(i) for i in range(10) ]

        last_ones = ['+', '/']

        self.char_table = upper_case_letters + lower_case_letters + from_0_to_9 + last_ones


    def hexa_conversor(self, message):
        ''' Converte a mensagem passada para a base 64. '''

        # Converte a mensagem passada como parâmetro para o formato binário.
        msg_binary_format = '0' + "{0:08b}".format(int(message, 16))

        # Calcula quantos valores binários de 6 algarimsmos podem ser obtidos para mapeamento.
        bin_format_len = len(msg_binary_format)
        total_indexes = int(bin_format_len / 6)

        # Insere na conversão os valores da tabela obtidos pelo mapeamento da mensagem binária.
        base_64_msg = ''
        for i in range(total_indexes):
            table_index = int(msg_binary_format[6*i : 6*(i+1)], 2)
            base_64_msg = ''.join([base_64_msg, self.char_table[table_index]])


        return base_64_msg


base_64_converter = Base_64()

#print(base_64_converter.hexa_conversor('49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'))
message = input("Entre com um valor em hexadecimal: ")
print(base_64_converter.hexa_conversor(message))

