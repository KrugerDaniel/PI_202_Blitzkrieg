class Conta:

    def __init__(self, nome_do_cliente, saldo, limite):
        self.nome_do_cliente = nome_do_cliente
        self.saldo = saldo
        self.limite = limite

    def sacar(self, saque):
        if saque <= self.saldo:
            self.saldo -= saque

        else:
            print("Você não possui este valor na sua conta")

    def depositar(self, deposito):
        if self.saldo + deposito <= self.limite:
            self.saldo += deposito

        else:
            print("Você não pode depositar esta quantia devido ao seu limite")

    def consultar():
        print("Cliente: ", nome_do_cliente)
        print("Saldo: ", saldo)