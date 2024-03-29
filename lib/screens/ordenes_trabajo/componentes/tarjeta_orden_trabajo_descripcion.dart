import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/detalle_orden_trabajo_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';


class TargetaOrdenTrabajoDescripcion extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const TargetaOrdenTrabajoDescripcion({
    Key? key, 
    required this.ordenTrabajo, 
    }) : super(key: key);

  @override
  State<TargetaOrdenTrabajoDescripcion> createState() => _TargetaOrdenTrabajoDescripcionState();
}

class _TargetaOrdenTrabajoDescripcionState extends State<TargetaOrdenTrabajoDescripcion> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          15, 10, 15, 10),
      child: Container(
        width: double.infinity,
        height: 290,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).grayLighter,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x32000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetalleOrdenTrabajoScreen(
                      ordenTrabajo: widget.ordenTrabajo,
                      pantalla: "pantallaRecepcion",
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child:
                    getImageEmprendimiento(widget.ordenTrabajo.vehiculo.target?.path),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(16, 10, 16, 0),
                      child: Text(
                        maybeHandleOverflow("${widget.ordenTrabajo.vehiculo.target?.modelo} - ${widget.ordenTrabajo.vehiculo.target?.marca}", 26, "..."),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(16, 5, 16, 0),
                      child: Text(
                        maybeHandleOverflow("${
                          widget.ordenTrabajo.cliente.target?.nombre} ${
                          widget.ordenTrabajo.cliente.target?.apellidoP} ${
                            widget.ordenTrabajo.cliente.target?.apellidoM}", 26, "..."),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(16, 0, 16, 5),
                      child: Text(
                        maybeHandleOverflow(widget.ordenTrabajo.descripcionFalla, 45, "..."),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FlutterFlowTheme.of(context)
                            .bodyText2
                            .override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(16, 0, 16, 5),
                      child: Text(
                        "Id Local: ${widget.ordenTrabajo.id}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FlutterFlowTheme.of(context)
                            .bodyText2
                            .override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(16, 10, 16, 0),
                      child: Text(
                        widget.ordenTrabajo.estatus.target!.estatus,
                        style: FlutterFlowTheme.of(context).bodyText2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(16, 10, 16, 0),
                      child: Text(
                        '${(widget.ordenTrabajo.estatus.target!.avance * 100).toStringAsFixed(0)} %',
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Outfit',
                              color:
                                  FlutterFlowTheme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


