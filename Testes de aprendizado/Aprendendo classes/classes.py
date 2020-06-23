"""
Você irá criar a classe Carror e eu quero no mínimo 3 propriedades para a classe carro e no mínimo 3 métodos para ela
"""
# Propriedades = rodas, marca, gasolina
# Métodos = encher o tanque, andar, ligar

class Carro:
    def __init__(self, marca:str, quant_rodas:int, quant_gas:float):
        self.marca = marca
        self.quant_rodas = quant_rodas
        self.quant_gas = quant_gas

    def EncherTanque(self):
        quant_gas = self.quant_gas + 50
        print(quant_gas)

    def Andar():
        print("VRRRRUUUUUMMMMM")

    def Ligar():
        print("Estou ligando")

carro1 = Carro("fiat", 4, 50)
print(carro1.marca, carro1.quant_gas, carro1.quant_rodas)
carro1.EncherTanque()