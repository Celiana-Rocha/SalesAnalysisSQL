import pymysql
from faker import Faker
import random
from datetime import datetime, timedelta

# Configurações de conexão

print("Iniciando conexão ao MySQL com pymysql...")
connection = pymysql.connect(
    host='localhost',
    user='root',         
    password='Celianasrsr1234wg',       
    database='análise de dados de vendas e desempenho comercial',   
    port=3306                   
    )
   


cursor = connection.cursor()
fake = Faker()

# Configurar quantidades
NUM_CUSTOMERS = 100
NUM_PRODUCTS = 50
NUM_ORDERS = 500

# Gerar clientes fictícios
customers = []
for _ in range(NUM_CUSTOMERS):
    customers.append((
        fake.name(),
        fake.email(),
        fake.phone_number(),
        fake.city(),
        fake.state_abbr(),
        fake.date_between(start_date='-3y', end_date='today')  # Data de cadastro
    ))

# Inserir clientes no banco
cursor.executemany("""
    INSERT INTO Customers (Name, Email, Phone, City, State, JoinDate)
    VALUES (%s, %s, %s, %s, %s, %s)
""", customers)

# Gerar produtos fictícios
categories = ['Eletrônicos', 'Roupas', 'Móveis', 'Livros', 'Brinquedos']
products = []
for _ in range(NUM_PRODUCTS):
    products.append((
        fake.word().capitalize(),  # Nome do produto
        random.choice(categories),  # Categoria
        round(random.uniform(10, 1000), 2),  # Preço
        random.randint(10, 500)  # Estoque
    ))

# Inserir produtos no banco
cursor.executemany("""
    INSERT INTO Products (Name, Category, Price, StockQuantity)
    VALUES (%s, %s, %s, %s)
""", products)

# Gerar pedidos fictícios
orders = []
order_details = []
for _ in range(NUM_ORDERS):
    customer_id = random.randint(1, NUM_CUSTOMERS)
    order_date = fake.date_between(start_date='-1y', end_date='today')
    num_items = random.randint(1, 5)
    total_amount = 0

    # Criar detalhes do pedido
    for _ in range(num_items):
        product_id = random.randint(1, NUM_PRODUCTS)
        quantity = random.randint(1, 10)
        cursor.execute("SELECT Price FROM Products WHERE ProductID = %s", (product_id,))
        price = cursor.fetchone()[0]
        subtotal = price * quantity
        total_amount += subtotal

        # Adicionar detalhes do pedido
        order_details.append((len(orders) + 1, product_id, quantity, round(subtotal, 2)))

    # Adicionar o pedido
    orders.append((customer_id, order_date, round(total_amount, 2)))

# Inserir pedidos no banco
cursor.executemany("""
    INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
    VALUES (%s, %s, %s)
""", orders)

# Inserir detalhes dos pedidos no banco
cursor.executemany("""
    INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal)
    VALUES (%s, %s, %s, %s)
""", order_details)

# Commit e fechar conexão
connection.commit()
connection.close()

print("Dados inseridos com sucesso no MySQL!")
