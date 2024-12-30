def main():
  # Ler as duas expressões booleanas
  expressao1 = input("Digite a primeira expressão: ")
  expressao2 = input("Digite a segunda expressão: ")

  # Criar um dicionário para armazenar as variáveis booleanas
  variaveis = {}

  # Criar uma função para avaliar uma expressão booleana
  def avaliar_expressao(expressao):
    # Substituir as variáveis por seus valores
    for variavel, valor in variaveis.items():
      expressao = expressao.replace(variavel, str(valor))

    # Avaliar a expressão usando operadores booleanos
    return eval(expressao)

  # Gerar todas as combinações possíveis de valores para as variáveis
  for i in range(2**len(variaveis)):
    # Atribuir valores às variáveis
    for j, variavel in enumerate(variaveis):
      variaveis[variavel] = (i >> j) & 1

    # Avaliar as expressões para a combinação atual de valores
    resultado1 = avaliar_expressao(expressao1)
    resultado2 = avaliar_expressao(expressao2)

    # Se os resultados forem diferentes, as expressões não representam a mesma função
    if resultado1 != resultado2:
      print("As expressões não representam a mesma função.")
      return

  # Se todas as combinações de valores resultarem no mesmo resultado, as expressões são equivalentes
  print("As expressões representam a mesma função.")

if __name__ == "__main__":
  main()
