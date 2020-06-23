from cliente import Cliente
from conta import Conta

cliente1 = Cliente("Daniel", "003", 18)
print(cliente1.nome, cliente1.cpf, cliente1.idade)

conta1 = Conta("Daniel", 500, 1000)
print(conta1.nome_do_cliente, conta1.saldo, conta1.limite)

conta1.sacar(501)
print(conta1.saldo)

conta1.depositar(1000)
print(conta1.saldo)