import 'dart:convert';

GetRolesSupabase getRolesSupabaseFromMap(String str) => GetRolesSupabase.fromMap(json.decode(str));

String getRolesSupabaseToMap(GetRolesSupabase data) => json.encode(data.toMap());

class GetRolesSupabase {
    GetRolesSupabase({
        required this.rolesCollection,
    });

    final RolesCollection rolesCollection;

    factory GetRolesSupabase.fromMap(Map<String, dynamic> json) => GetRolesSupabase(
        rolesCollection: RolesCollection.fromMap(json["rolesCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "rolesCollection": rolesCollection.toMap(),
    };
}

class RolesCollection {
    RolesCollection({
        required this.edges,
    });

    final List<Edge> edges;

    factory RolesCollection.fromMap(Map<String, dynamic> json) => RolesCollection(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toMap())),
    };
}

class Edge {
    Edge({
        required this.node,
    });

    final Node node;

    factory Edge.fromMap(Map<String, dynamic> json) => Edge(
        node: Node.fromMap(json["node"]),
    );

    Map<String, dynamic> toMap() => {
        "node": node.toMap(),
    };
}

class Node {
    Node({
        required this.id,
        required this.rol,
        required this.createdAt,
    });

    final String id;
    final String rol;
    final DateTime createdAt;

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["id"],
        rol: json["rol"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "rol": rol,
        "created_at": createdAt.toIso8601String(),
    };
}
