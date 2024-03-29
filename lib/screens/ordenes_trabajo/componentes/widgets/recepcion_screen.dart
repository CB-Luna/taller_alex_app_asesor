import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/observacion_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/ordenes_trabajo_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';

class RecepcionScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const RecepcionScreen({
    super.key, 
    required this.ordenTrabajo});

  @override
  State<RecepcionScreen> createState() => _RecepcionScreenState();
}

final animationsMap = {
    'moveLoadAnimationLR': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(-79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1,
          end: 1,
        ),
      ],
    ),
    'moveLoadAnimationRL': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1,
          end: 1,
        ),
      ],
    ),
  };
  
class _RecepcionScreenState extends State<RecepcionScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 5, 0, 0),
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x39000000),
                        offset: Offset(-4, 8),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const OrdenesTrabajoScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        Text(
                          'Atrás',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyText1Family,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                10, 0, 10, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recepción',
                  textAlign: TextAlign.center,
                  style:
                      FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: FlutterFlowTheme.of(context)
                                .bodyText1Family,
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x39000000),
                        offset: Offset(-4, 8),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: FlutterFlowTheme.of(context).alternate,
                        size: 30,
                      ),
                      AutoSizeText(
                        'Cliente',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context)
                            .subtitle1
                            .override(
                              fontFamily: 'Outfit',
                              color:
                                  FlutterFlowTheme.of(context).alternate,
                              fontSize: 15,
                            ),
                      ),
                    ],
                  ),
                ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "${widget.ordenTrabajo.cliente.target?.nombre} ${widget.ordenTrabajo.cliente.target?.apellidoP} ${widget.ordenTrabajo.cliente.target?.apellidoM}",
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
              ],
            ),
          ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "${widget.ordenTrabajo.vehiculo.target?.marca} - ${widget.ordenTrabajo.vehiculo.target?.modelo}",
                  style: FlutterFlowTheme.of(context).title1.override(
                        fontFamily: 'Outfit',
                        color: FlutterFlowTheme.of(context).dark400,
                      ),
                ),
              ],
            ),
          ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x43000000),
                    offset: Offset(-4, 8),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: getImageEmprendimiento(
                widget.ordenTrabajo.vehiculo.target?.path).
                  animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
            child: LinearPercentIndicator(
              percent: widget.ordenTrabajo.estatus.target!.avance,
              width: MediaQuery.of(context).size.width * 0.9,
              lineHeight: 24,
              animation: true,
              progressColor: FlutterFlowTheme.of(context).primaryColor,
              backgroundColor: FlutterFlowTheme.of(context).grayLighter,
              barRadius: const Radius.circular(40),
              padding: EdgeInsets.zero,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                      child: Text(
                        'Avance',
                        style: FlutterFlowTheme.of(context).bodyText2,
                      ),
                    ),
                    Text(
                      '${(widget.ordenTrabajo.estatus.target!.avance * 100).toStringAsFixed(0)} %',
                      style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Outfit',
                            color:
                                FlutterFlowTheme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                      child: Text(
                        'Estatus',
                        style: FlutterFlowTheme.of(context).bodyText2,
                      ),
                    ),
                    Text(
                      '${widget.ordenTrabajo.estatus.target?.estatus}',
                      style: FlutterFlowTheme.of(context).title1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Color(0x004672FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10, 12, 5, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Observaciones',
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 20,
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ObservacionScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        },
                        text: 'Agregar',
                        icon: const Icon(
                          Icons.add,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          width: 150,
                          height: 35,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle: FlutterFlowTheme.of(context)
                              .subtitle2
                              .override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).subtitle2Family,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    return ListView.builder(
                      controller: ScrollController(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.ordenTrabajo.observacion.toList().length,
                      itemBuilder: (context, index) {
                        final observacion = widget.ordenTrabajo.observacion.toList()[index];
                        return InkWell(
                          onTap: () async {
                          },
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 8),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.92,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).grayLighter,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x43000000),
                                          offset: Offset(-4, 8),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(15, 0, 0, 0),
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Column(
                                              mainAxisSize:
                                                  MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  (index + 1).toString(),
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1Family,
                                                            fontSize: 20,
                                                          ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .all(8),
                                            child: Column(
                                              mainAxisSize:
                                                  MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      maybeHandleOverflow(
                                                          observacion.nombreAsesor,
                                                          25,
                                                          "..."),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    FlutterFlowTheme.of(context)
                                                                        .bodyText1Family,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                              ),
                                                    ),
                                                    Text(
                                                      dateTimeFormat(
                                                          'd/MMM/y',
                                                          observacion.fechaObservacion),
                                                      textAlign:
                                                          TextAlign.end,
                                                      style: FlutterFlowTheme.of(
                                                              context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1Family,
                                                            color: FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5),
                                                  child: Text(
                                                    maybeHandleOverflow(observacion.respuestaP1, 84, "..."),
                                                    maxLines: 2,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle1Family,
                                                          color: FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
        ),
        ],
      ),
    );
  }
}