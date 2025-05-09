-- ########## Création des tables #########

-- Stocke les commandes passées
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY, -- dentifiant unique de la commande
    date TEXT, -- Date de la commande
    time TEXT --Heure de la commande
);

-- Contient les différents types de pizzas proposés
CREATE TABLE IF NOT EXISTS pizza_types (
    pizza_type_id TEXT PRIMARY KEY, -- Code unique du type de pizza 
    name TEXT, -- Nom complet de la pizza
    category TEXT, --  Catégorie (ex: "Classic", "Veggie", "Chicken")
    ingredients TEXT --  Liste des ingrédients (séparés par des virgules)
);

-- Associe chaque pizza à un type et une taille, avec son prix
CREATE TABLE IF NOT EXISTS pizzas (
    pizza_id TEXT PRIMARY KEY,
    pizza_type_id TEXT,
    size TEXT, -- Taille ("S", "M", "L")
    price REAL, -- Prix en dollars
    FOREIGN KEY (pizza_type_id) REFERENCES pizza_types (pizza_type_id)
);

-- Détails des pizzas commandées dans chaque commande
CREATE TABLE IF NOT EXISTS order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    pizza_id TEXT,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizza(pizza_id)
);

-- Gère le stock des ingrédients pour éviter les ruptures. Cette base fictivie sera très utiles pour créer l'alerte.
CREATE TABLE IF NOT EXISTS ingredient_stock (
    ingredient_name TEXT PRIMARY KEY,
    initial_stock INTEGER NOT NULL,
    current_stock INTEGER NOT NULL,
    CHECK (current_stock <= initial_stock) --  contrainte CHECK qui spécifie une condition que les données de la table doivent satisfaire.
    --  la valeur de "current_stock" est toujours inférieure ou égale à la valeur de "initial_stock". Cela permet d'éviter d'avoir un stock actuel négatif ou supérieur au stock initial, ce qui n'aurait pas de sens dans un scénario de gestion des stocks. 
);
INSERT INTO ingredient_stock (ingredient_name, initial_stock, current_stock) VALUES
('Barbecued Chicken', 50, 20),
('Red Peppers', 100, 50),
('Green Peppers', 100, 30),
('Tomatoes', 200, 20),
('Red Onions', 150, 10),
('Barbecue Sauce', 30, 5),
('Chicken', 100, 40),
('Artichoke', 40, 10),
('Spinach', 80, 5),
('Garlic', 200, 50),
('Jalapeno Peppers', 60, 20),
('Fontina Cheese', 30, 10),
('Gouda Cheese', 30, 5),
('Mushrooms', 120, 30),
('Asiago Cheese', 40, 10),
('Alfredo Sauce', 20, 5),
('Pesto Sauce', 25, 10),
('Corn', 50, 20),
('Cilantro', 30, 10),
('Chipotle Sauce', 15, 5),
('Pineapple', 40, 10),
('Thai Sweet Chilli Sauce', 10, 2),
('Bacon', 60, 20),
('Pepperoni', 80, 30),
('Italian Sausage', 50, 10),
('Chorizo Sausage', 40, 10),
('Sliced Ham', 40, 10),
('Mozzarella Cheese', 250, 50),
('Capocollo', 30, 10),
('Goat Cheese', 25, 5),
('Oregano', 50, 20),
('Anchovies', 20, 5),
('Green Olives', 80, 30),
('Beef Chuck Roast', 20, 10),
('Brie Carre Cheese', 15, 2),
('Prosciutto', 20, 5),
('Caramelized Onions', 30, 10),
('Pears', 20, 10),
('Thyme', 40, 15),
('Nduja Salami', 20, 5),
('Pancetta', 30, 10),
('Friggitello Peppers', 20, 5),
('Calabrese Salami', 25, 10),
('Genoa Salami', 25, 10),
('Prosciutto di San Daniele', 15, 2),
('Arugula', 60, 20),
('Coarse Sicilian Salami', 20, 5),
('Luganega Sausage', 30, 10),
('Onions', 100, 30),
('Soppressata Salami', 20, 5),
('Smoked Gouda Cheese', 20, 10),
('Romano Cheese', 20, 10),
('Blue Cheese', 15, 2),
('Ricotta Cheese', 40, 15),
('Gorgonzola Piccante Cheese', 15, 2),
('Parmigiano Reggiano Cheese', 20, 5),
('Zucchini', 60, 20),
('Plum Tomatoes', 40, 15),
('Sun-dried Tomatoes', 40, 10),
('Peperoncini verdi', 25, 10);

-- ##################### Importation des données CSV ################"
.mode csv
.import orders.csv orders

.mode csv
.import pizza_types.csv pizza_types

.mode csv
.import pizzas.csv pizzas

.mode csv
.import order_details.csv order_details