-- Q1.5.1 
SELECT * FROM produits;
--Résultat : tous les produits enregistrés s'affichent.

-- Q1.5.2 
SELECT * FROM produits
WHERE quantite = 0;
--Résultat : le produit Jus d'orange 1 L, dont la quantité est égale à zéro.

-- Q1.5.3
SELECT *
FROM produits
ORDER BY prix DESC;
--Résultat : les produits s'affichent du plus cher au moins cher. DESC signifie ordre décroissant.
-- Q1.5.4
SELECT
    produits.id,
    produits.nom,
    produits.prix,
    produits.quantite,
    categories.nom AS categorie
FROM produits
INNER JOIN categories
    ON produits.categorie_id = categories.id;
 --Résultat : Produit	Catégorie
Huile d'olive 1 L	Alimentation
Couscous moyen 1 kg	Alimentation
Eau minérale 1,5 L	Boissons
Jus d'orange 1 L	Boissons
Savon de Marseille	Hygiène
-- Q1.5.5
SELECT
    categories.nom AS categorie,
    COUNT(produits.id) AS nombre_produits
FROM categories
LEFT JOIN produits
    ON categories.id = produits.categorie_id
GROUP BY categories.id, categories.nom;
--Résultat:le nombre de produits est affiché pour chaque catégorie. 
-- Q1.5.6
SELECT
    SUM(prix * quantite) AS valeur_totale_stock
FROM produits;
--Rsultat:1133.30
-- test1
INSERT INTO produits
(nom, prix, quantite, disponible, date_ajout, categorie_id)
VALUES
('Produit test', -5, 2, 1, '2026-10-28', 1);
--Résultat :erreur car la contrainte CHECK (prix >= 0) interdit un prix négatif.
-- test2
INSERT INTO produits
(nom, prix, quantite, disponible, date_ajout, categorie_id)
VALUES
('Produit test', 5, -2, 1, '2026-10-28', 1);
--Résultat :erreur, car la quantité doit être supérieure ou égale à zéro.
-- test3
INSERT INTO produits
(nom, prix, quantite, disponible, date_ajout, categorie_id)
VALUES
('Produit test', 5, 2, 1, '2026-10-28', 99);
--Résultat:erreur de clé étrangère si les clés étrangères sont activées, car la catégorie 99 n'existe pas.
-- test4
DELETE FROM categories
WHERE id = 1;
--Résultat:suppression refusée si des produits utilisent la catégorie 1, grâce à ON DELETE RESTRICT et à l'activation des clés étrangères.

