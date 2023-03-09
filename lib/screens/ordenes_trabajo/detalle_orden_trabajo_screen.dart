import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taller_alex_app_asesor/screens/inspeccion/inspeccion_screen.dart';
import 'package:taller_alex_app_asesor/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:taller_alex_app_asesor/screens/diagnostico/diagnostico_screen.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/agregar_observacion_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/componentes/widgets/recepcion_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import '../widgets/flutter_flow_widgets.dart';
import 'flutter_flow_animaciones.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetalleOrdenTrabajoScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  final String pantalla;
  const DetalleOrdenTrabajoScreen({
    Key? key, 
    required this.ordenTrabajo, 
    required this.pantalla,
  }) : super(key: key);

  @override
  _DetalleOrdenTrabajoScreenState createState() => _DetalleOrdenTrabajoScreenState();
}

class _DetalleOrdenTrabajoScreenState extends State<DetalleOrdenTrabajoScreen>
    with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentPageName = 'pantallaRecepcion';

  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
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
          begin: Offset(79, 0),
          end: Offset(0, 0),
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

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.pantalla;
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'pantallaRecepcion': RecepcionScreen(ordenTrabajo: widget.ordenTrabajo,),
      'pantallaInspeccion': InspeccionScreen(ordenTrabajo: widget.ordenTrabajo,),
      'pantallaDiagnostico': DiagnosticoScreen(),
      // 'terceraParte': TerceraParteFormularioObservacionesWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).background,
      body: SafeArea(
        child: tabs[_currentPageName]!
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).customColor1,
        selectedItemColor: FlutterFlowTheme.of(context).primaryColor,
        unselectedItemColor: FlutterFlowTheme.of(context).grayLight,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_car_outlined,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.directions_car,
              size: 24,
            ),
            label: '•',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.checklist_rtl_outlined,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.checklist_rtl_outlined,
              size: 24,
            ),
            label: '•',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.car_repair,
              size: 24,
            ),
            label: '__',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.attach_money_rounded,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.attach_money_rounded,
              size: 24,
            ),
            label: '•',
            tooltip: '',
          )
        ],
      ),
    );
  }
}
