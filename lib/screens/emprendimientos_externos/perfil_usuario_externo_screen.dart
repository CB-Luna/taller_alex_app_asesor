import 'dart:ui';
import 'package:bizpro_app/modelsPocketbase/temporals/usuario_proyectos_temporal.dart';
import 'package:bizpro_app/screens/emprendimientos_externos/usuarios_externos_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/toggle_icon.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class PerfilUsuarioExternoScreen extends StatefulWidget {
  final List<UsuarioProyectosTemporal> listUsuariosProyectosTemp;
  final UsuarioProyectosTemporal usuarioProyectosTemporal;

  const PerfilUsuarioExternoScreen({
    Key? key, 
    required this.listUsuariosProyectosTemp, 
    required this.usuarioProyectosTemporal,
  }) : super(key: key);

  @override
  _PerfilUsuarioExternoScreenState createState() =>
      _PerfilUsuarioExternoScreenState();
}

class _PerfilUsuarioExternoScreenState extends State<PerfilUsuarioExternoScreen>
    with TickerProviderStateMixin {
  // final animationsMap = {
  //   'containerOnPageLoadAnimation1': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     effects: [
  //       ScaleEffect(
  //         curve: Curves.easeInOut,
  //         delay: 0.ms,
  //         duration: 700.ms,
  //         begin: const Offset(0, 0),
  //         end: const Offset(1,1),
  //       ),
  //     ],
  //   ),
  //   'rowOnPageLoadAnimation': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     effects: [
  //       FadeEffect(
  //         curve: Curves.easeInOut,
  //         delay: 0.ms,
  //         duration: 800.ms,
  //         begin: 0,
  //         end: 1,
  //       ),
  //     ],
  //   ),
  //   'textOnPageLoadAnimation1': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     effects: [
  //       FadeEffect(
  //         curve: Curves.easeInOut,
  //         delay: 0.ms,
  //         duration: 800.ms,
  //         begin: 0,
  //         end: 1,
  //       ),
  //     ],
  //   ),
  // };
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> listEmprendimientosSelected = [];
  @override
  void initState() {
    listEmprendimientosSelected = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4672FF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: AppTheme.of(context)
                                        .secondaryBackground,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: Image.asset(
                                        'assets/images/mesgbluegradient.jpeg',
                                      ).image,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                          child: InkWell(
                                            onTap: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                        UsuariosExternosScreen(
                                                          listUsuariosProyectosTemp: widget.listUsuariosProyectosTemp
                                                          ,),
                                                ),
                                              );
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 20,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Container(
                                                width: 45,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: const [
                                                    Icon(
                                                      Icons.arrow_back_outlined,
                                                      color: Color(0xFF4672FF),
                                                      size: 25,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 50, 0, 0),
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4672FF),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.blueAccent,
                                          width: 3.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                        child: SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Center(
                                            child: Text(
                                              "${widget.usuarioProyectosTemporal.usuarioTemp
                                              .nombreUsuario.substring(0, 1)} ${widget
                                              .usuarioProyectosTemporal.usuarioTemp
                                              .apellidoP.substring(0, 1)}",
                                              style:
                                                AppTheme.of(context).bodyText1.override(
                                                  fontFamily: AppTheme.of(context)
                                                      .bodyText1Family,
                                                  color: Colors.white,
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 0),
                                    child: Text(
                                      widget.usuarioProyectosTemporal.usuarioTemp.nombreUsuario,
                                      style: AppTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    "${widget.usuarioProyectosTemporal.
                                      usuarioTemp.apellidoP} ${widget
                                      .usuarioProyectosTemporal
                                      .usuarioTemp.apellidoM}",
                                    style: AppTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Teléfono:',
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                widget.usuarioProyectosTemporal.usuarioTemp.telefono ?? "Sin teléfono",
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Celular:',
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                widget.usuarioProyectosTemporal.usuarioTemp.celular ?? "Sin celular",
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Usuario Archivado:',
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                widget.usuarioProyectosTemporal.usuarioTemp.archivado == true ? "Sí" : "No",
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 15, 10, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Emprendimientos de ${widget.usuarioProyectosTemporal.usuarioTemp.nombreUsuario}',
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: const Color(0xFF4672FF),
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 430,
              child: ListView.builder(
                padding: const EdgeInsetsDirectional
                    .fromSTEB(10, 0, 10, 10),
                controller: ScrollController(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: widget.usuarioProyectosTemporal.emprendimientosTemp.length,
                itemBuilder: (context, index) {
                  final emprendimientoTemp = widget.usuarioProyectosTemporal.emprendimientosTemp[index];
                  return Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        ToggleIcon(
                          onPressed: () {
                            setState(() {
                              emprendimientoTemp.selected = !emprendimientoTemp.selected;
                              if (emprendimientoTemp.selected) {
                                listEmprendimientosSelected.add(emprendimientoTemp.id);
                              }
                            });
                          },
                          value: emprendimientoTemp.selected,
                          onIcon: Icon(
                            Icons.check_box,
                            color: AppTheme.of(
                                    context)
                                .primaryText,
                            size: 40,
                          ),
                          offIcon: Icon(
                            Icons
                                .check_box_outline_blank,
                            color: AppTheme.of(
                                    context)
                                .primaryText,
                            size: 40,
                          ),
                        ),
                        Container(
                          width: 350,
                          height: 165,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/mesgbluegradient.jpeg',
                              ).image,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color(0x2B202529),
                                offset: Offset(0, 3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ClipRRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 5,
                                    ),
                                    child: Container(
                                      width: 350,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: const Color(0x6CFFFFFF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              maybeHandleOverflow(emprendimientoTemp.nombreEmprendimiento, 25, "..."),
                                              style: AppTheme.of(context)
                                                  .title2
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 4),
                                              child: Text(
                                                maybeHandleOverflow("${emprendimientoTemp
                                                .expand.idEmprendedorFk.nombreEmprendedor} ${emprendimientoTemp
                                                .expand.idEmprendedorFk.apellidosEmp}", 40, "..."),
                                                style: AppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 4),
                                              child: Text(
                                                maybeHandleOverflow(emprendimientoTemp.descripcion, 120, "..."),
                                                style: AppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  0, 20, 0, 10),
              child: FFButtonWidget(
                onPressed: () async {
                  print("Los emprendimientos a descargar son");
                  print(listEmprendimientosSelected);
                },
                text: 'Descargar Proyectos',
                icon: const Icon(
                  Icons.check_rounded,
                  size: 20,
                ),
                options: FFButtonOptions(
                  width: 200,
                  height: 40,
                  color: AppTheme.of(context).secondaryText,
                  textStyle: AppTheme.of(context)
                      .subtitle2
                      .override(
                        fontFamily:
                            AppTheme.of(context).subtitle2Family,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
