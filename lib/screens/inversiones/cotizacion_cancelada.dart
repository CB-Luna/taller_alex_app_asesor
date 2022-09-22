import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/screens/inversiones/inversiones_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class CotizacionCancelada extends StatefulWidget {
  final int idEmprendimiento;
  const CotizacionCancelada({
    Key? key, 
    required this.idEmprendimiento
    }) : super(key: key);

  @override
  State<CotizacionCancelada> createState() => _CotizacionCanceladaState();
}

class _CotizacionCanceladaState extends State<CotizacionCancelada> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFDDEEF8),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Text(
                        '¡Cotización\nCancelada!',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 30,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'Listo, la cotización ha sido \ncancelada con éxito.',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                            ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                      child: SizedBox(
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Color.fromARGB(228, 255, 82, 70),
                          size: 250,
                          )
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InversionesScreen(idEmprendimiento: widget.idEmprendimiento,),
                            ),
                          );
                        },
                        text: 'Listo',
                        options: FFButtonOptions(
                          width: 200,
                          height: 45,
                          color: const Color(0xFF28BFFA),
                          textStyle: AppTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}