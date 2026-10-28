class Produit {
  final int? id;
  final String nom;
  final double prix;
  final int quantite;
  final bool disponible;
  final DateTime dateAjout;
  final int categorieId;
  final int seuilAlerte;

  Produit({
    this.id,
    required this.nom,
    required this.prix,
    required this.quantite,
    this.disponible = true,
    required this.dateAjout,
    required this.categorieId,
    this.seuilAlerte = 5,
  });

  factory Produit.fromMap(Map<String, dynamic> map) {
    return Produit(
      id: map['id'] as int?,
      nom: map['nom'] as String,
      prix: (map['prix'] as num).toDouble(),
      quantite: map['quantite'] as int,
      disponible: (map['disponible'] as int) == 1,
      dateAjout: DateTime.parse(map['date_ajout'] as String),
      categorieId: map['categorie_id'] as int,
      seuilAlerte: (map['seuil_alerte'] as int?) ?? 5,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      'prix': prix,
      'quantite': quantite,
      'disponible': disponible ? 1 : 0,
      'date_ajout': dateAjout.toIso8601String(),
      'categorie_id': categorieId,
      'seuil_alerte': seuilAlerte,
    };
  }

  Produit copyWith({
    int? id,
    String? nom,
    double? prix,
    int? quantite,
    bool? disponible,
    DateTime? dateAjout,
    int? categorieId,
    int? seuilAlerte,
  }) {
    return Produit(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prix: prix ?? this.prix,
      quantite: quantite ?? this.quantite,
      disponible: disponible ?? this.disponible,
      dateAjout: dateAjout ?? this.dateAjout,
      categorieId: categorieId ?? this.categorieId,
      seuilAlerte: seuilAlerte ?? this.seuilAlerte,
    );
  }
}