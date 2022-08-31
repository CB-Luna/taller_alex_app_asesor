import 'dart:io';

import 'package:bizpro_app/screens/widgets/pdf/api/pdf_api.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/productos_emprendedor_invoice.dart';
import 'package:bizpro_app/screens/widgets/pdf/utils.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceProductosEmprendedor {
  static Future<File> generate(ProductosEmprendedorInvoice invoice) async {
    var assetImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/emlogo.png'))
          .buffer
          .asUint8List(),
    );
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice, assetImage),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
      ],
      margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    ));

    return PdfApi.saveDocument(name: 'productos_emprendedor.pdf', pdf: pdf);
  }

  static Widget buildHeader(ProductosEmprendedorInvoice invoice, MemoryImage assetImage) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                child: 
                  pw.Image(assetImage),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );


  static Widget buildInvoiceInfo(InvoiceInfo info) {

    final titles = <String>[
      'Usuario Actual:',
      'Fecha Generación:',
    ];
    final data = <String>[
      info.usuario,
      Utils.formatDateHour(info.fecha),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 250);
      }),
    );
  }


  static Widget buildTitle(ProductosEmprendedorInvoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            invoice.info.titulo,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info.descripcion),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(ProductosEmprendedorInvoice invoice) {
    final headers = [
      'ID',
      'Emprendedor',
      'Tipo de Proyecto',
      'Emprendimiento',
      'Producto',
      'Descripción',
      'Unidad de Medida',
      'Costo por Unidad',
      'Usuario',
      'Fecha de Registro'
    ];
    final data = invoice.items.map((item) {
      return [
        item.id.toString(),
        item.emprendedor,
        item.tipoProyecto,
        item.emprendimiento,
        item.producto,
        item.descripcion,
        item.unidadMedida,
        item.costo,
        item.usuario,
        Utils.formatDateHour(item.fechaRegistro),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 5),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 5),
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
        5: Alignment.centerLeft,
        6: Alignment.centerLeft,
        7: Alignment.centerLeft,
        8: Alignment.centerLeft,
        9: Alignment.centerLeft,
        10: Alignment.centerLeft,
      },
    );
  }

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}