import sqlite3

def creer_vues_et_index(conn):
    """
    Crée une vue (pizza_sales_summary) pour résumer les ventes par jour, pizza et catégorie,
    et un index (idx_order_pizza) sur les colonnes order_id et pizza_id de la table order_details.
    """
    cursor = conn.cursor()

    # Créer la vue pizza_sales_summary
    cursor.execute("""
    CREATE VIEW IF NOT EXISTS pizza_sales_summary AS
    SELECT
        o.date,
        p.pizza_id,
        pt.name AS pizza_name,
        pt.category,
        SUM(od.quantity * p.price) AS total_ventes
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizza p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY o.date, p.pizza_id, pt.category
    ORDER BY o.date, p.pizza_id;
    """)
    print("Vue pizza_sales_summary créée.")

    # Créer l'index idx_order_pizza
    cursor.execute("""
    CREATE INDEX IF NOT EXISTS idx_order_pizza
    ON order_details (order_id, pizza_id);
    """)
    print("Index idx_order_pizza créé.")
    
    conn.commit() #Enregistrer les changements
    cursor.close()

def main():
    """
    Fonction principale pour se connecter à la base de données, créer les vues et index,
    et exécuter quelques requêtes.
    """
    try:
        conn = sqlite3.connect('pizza.db')
        print("Connexion à la base de données établie.")
        
        creer_vues_et_index(conn) #Appel de la fonction de création de vues et index

        cursor = conn.cursor()
        
        # Exemple de requête utilisant la vue
        cursor.execute("SELECT date, pizza_name, total_ventes FROM pizza_sales_summary LIMIT 10;")
        print("\nExemple de données de la vue pizza_sales_summary :")
        for row in cursor.fetchall():
            print(row)
            
        # Exemple d'utilisation de l'index (bien que l'amélioration de performance ne soit pas directement visible ici)
        cursor.execute("SELECT * FROM order_details WHERE order_id = 1 AND pizza_id = 'hawaiian_m';")
        print("\nExemple de requête utilisant l'index idx_order_pizza :")
        for row in cursor.fetchall():
            print(row)

        cursor.close()
        conn.close()
        print("Connexion à la base de données fermée.")

    except sqlite3.Error as e:
        print(f"Erreur SQLite : {e}")
    finally:
        if conn:
            conn.close()
            
if __name__ == "__main__":
    main()
