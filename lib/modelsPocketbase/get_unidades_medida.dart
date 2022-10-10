import 'dart:convert';

GetUnidadesMedida getUnidadesMedidaFromMap(String str) => GetUnidadesMedida.fromMap(json.decode(str));

String getUnidadesMedidaToMap(GetUnidadesMedida data) => json.encode(data.toMap());

class GetUnidadesMedida {
    GetUnidadesMedida({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.unidadMedida,
        required this.activo,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String unidadMedida;
    final bool activo;
    final String idEmiWeb;

    factory GetUnidadesMedida.fromMap(Map<String, dynamic> json) => GetUnidadesMedida(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        unidadMedida: json["unidad_medida"],
        activo: json["activo"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "unidad_medida": unidadMedida,
        "activo": activo,
        "id_emi_web": idEmiWeb,
    };
}