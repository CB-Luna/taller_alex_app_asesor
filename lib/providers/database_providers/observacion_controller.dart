import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/modelsFormularios/opciones_observaciones.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:taller_alex_app_asesor/util/util.dart';
class ObservacionController extends ChangeNotifier {
  final observaciones1FormKey = GlobalKey<FormState>();
  final observaciones2FormKey = GlobalKey<FormState>();
  final observaciones3FormKey = GlobalKey<FormState>();

  bool validarFormulario(GlobalKey<FormState> observacionFormKey) {
    return observacionFormKey.currentState!.validate()
    ? true : false;
  }

  //Datos de las Observaciones
  String descripcion = "";

  DateTime? fechaObservacion; //Es null para inicializar sin valor el campo en el formulario 
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController fechaObservacionController = TextEditingController(); 
  
  String respuestaP1 = "";
  String valorSeleccionP2 = "";
  List<OpcionesObservaciones> opcionesP2 = [
    OpcionesObservaciones(opcion: "Sí", seleccion: false),
    OpcionesObservaciones(opcion: "No", seleccion: false),
  ];

  String valorSeleccionP3 = "";
  List<OpcionesObservaciones> opcionesP3 = [
    OpcionesObservaciones(opcion: "Mañana", seleccion: false),
    OpcionesObservaciones(opcion: "Tarde", seleccion: false),
    OpcionesObservaciones(opcion: "Noche", seleccion: false),
  ];

  String valorSeleccionP4 = "";
  List<OpcionesObservaciones> opcionesP4 = [
    OpcionesObservaciones(opcion: "Trayecto Largo", seleccion: false),
    OpcionesObservaciones(opcion: "Trayecto Corto", seleccion: false),
  ];

  String respuestaP5 = "";
  String valorSeleccionP6 = "";
  List<OpcionesObservaciones> opcionesP6 = [
    OpcionesObservaciones(opcion: "Esporádicamente", seleccion: false),
    OpcionesObservaciones(opcion: "Continuamente", seleccion: false),
  ];

  String valorSeleccionP7 = "";
  List<OpcionesObservaciones> opcionesP7 = [
    OpcionesObservaciones(opcion: "En frío", seleccion: false),
    OpcionesObservaciones(opcion: "En fase de calentamiento", seleccion: false),
    OpcionesObservaciones(opcion: "En fase de enfriamiento", seleccion: false),
    OpcionesObservaciones(opcion: "En caliente", seleccion: false),
  ];

  String valorSeleccionP8 = "";
  List<OpcionesObservaciones> opcionesP8 = [
    OpcionesObservaciones(opcion: "En marcha", seleccion: false),
    OpcionesObservaciones(opcion: "Alta revolución", seleccion: false),
  ];

  String valorSeleccionP9 = "";
  List<OpcionesObservaciones> opcionesP9 = [
    OpcionesObservaciones(opcion: "Irregular", seleccion: false),
    OpcionesObservaciones(opcion: "Pavimentado", seleccion: false),
    OpcionesObservaciones(opcion: "Autopista", seleccion: false),
    OpcionesObservaciones(opcion: "Tráfico intenso", seleccion: false),
  ];
  
  String respuestaP10 = "";


  void limpiarInformacion()
  {
    fechaObservacion = null;
    fechaObservacionController.clear();
    respuestaP1 = "";
    valorSeleccionP2 = "";
    opcionesP2 = [
      OpcionesObservaciones(opcion: "Sí", seleccion: false),
      OpcionesObservaciones(opcion: "No", seleccion: false),
    ];
    valorSeleccionP3 = "";
    opcionesP3 = [
      OpcionesObservaciones(opcion: "Mañana", seleccion: false),
      OpcionesObservaciones(opcion: "Tarde", seleccion: false),
      OpcionesObservaciones(opcion: "Noche", seleccion: false),
    ];
    valorSeleccionP4 = "";
    opcionesP4 = [
      OpcionesObservaciones(opcion: "Trayecto Largo", seleccion: false),
      OpcionesObservaciones(opcion: "Trayecto Corto", seleccion: false),
    ];
    respuestaP5 = "";
    valorSeleccionP6 = "";
    opcionesP6 = [
      OpcionesObservaciones(opcion: "Esporádicamente", seleccion: false),
      OpcionesObservaciones(opcion: "Continuamente", seleccion: false),
    ];
    valorSeleccionP7 = "";
    opcionesP7 = [
      OpcionesObservaciones(opcion: "En frío", seleccion: false),
      OpcionesObservaciones(opcion: "En fase de calentamiento", seleccion: false),
      OpcionesObservaciones(opcion: "En fase de enfriamiento", seleccion: false),
      OpcionesObservaciones(opcion: "En caliente", seleccion: false),
    ];
    valorSeleccionP8 = "";
    opcionesP8 = [
      OpcionesObservaciones(opcion: "En marcha", seleccion: false),
      OpcionesObservaciones(opcion: "Alta revolución", seleccion: false),
    ];
    valorSeleccionP9 = "";
    opcionesP9 = [
      OpcionesObservaciones(opcion: "Irregular", seleccion: false),
      OpcionesObservaciones(opcion: "Pavimentado", seleccion: false),
      OpcionesObservaciones(opcion: "Autopista", seleccion: false),
      OpcionesObservaciones(opcion: "Tráfico intenso", seleccion: false),
    ];
    respuestaP10 = "";
    descripcion = "";
    notifyListeners();
  }


  void actualizarFechaObservacion(DateTime fecha) {
    fechaObservacion = fecha;
    fechaObservacionController = TextEditingController(text: dateTimeFormat('d/MMMM/y', fecha));
    notifyListeners();
  }

  bool validarSeccionUnoFormulario ()
  {
    if (fechaObservacion != null 
    && respuestaP1 != ""
    && valorSeleccionP2 != "") {
      return true;
    } else {
      return false;
    }
  }

  bool validarSeccionDosFormulario ()
  {
    if (valorSeleccionP3 != "" 
    && valorSeleccionP4 != ""
    && respuestaP5 != ""
    && valorSeleccionP6 != "") {
      return true;
    } else {
      return false;
    }
  }

  bool validarSeccionTresFormulario ()
  {
    if (valorSeleccionP7 != "" 
    && valorSeleccionP8 != ""
    && valorSeleccionP9 != ""
    && respuestaP10 != "") {
      return true;
    } else {
      return false;
    }
  }

  bool agregarObservacion(OrdenTrabajo ordenTrabajo, Usuarios usuario) {
    final nuevaObservacion = Observaciones(
      fechaObservacion: fechaObservacion!,
      respuestaP1: respuestaP1,
      respuestaP2: valorSeleccionP2,
      respuestaP3: valorSeleccionP3,
      respuestaP4: valorSeleccionP4,
      respuestaP5: respuestaP5,
      respuestaP6: valorSeleccionP6,
      respuestaP7: valorSeleccionP7,
      respuestaP8: valorSeleccionP8,
      respuestaP9: valorSeleccionP9,
      respuestaP10: respuestaP10,
      nombreAsesor: "${usuario.nombre} ${usuario.apellidoP} ${usuario.apellidoM}"
    );
    //Observación
    if (ordenTrabajo.estatus.target!.estatus == "Recepción")  {
      final estatus = dataBase.estatusBox
          .query(Estatus_.estatus.equals("Observación"))
          .build()
          .findFirst();
      ordenTrabajo.estatus.target = estatus;

      final nuevaInstruccionEstatusOrdenTrabajo = Bitacora(
        instruccion: 'syncActualizarEstatusOrdenTrabajo',
        usuarioPropietario: prefs.getString("userId")!,
        idOrdenTrabajo: ordenTrabajo.id,
        instruccionAdicional: estatus?.estatus,
      ); //Se crea la nueva instruccion a realizar en bitacora
      nuevaInstruccionEstatusOrdenTrabajo.ordenTrabajo.target = ordenTrabajo;
      dataBase.bitacoraBox.put(nuevaInstruccionEstatusOrdenTrabajo);

    }

    final nuevaInstruccionAgregarObservacion = Bitacora(
      instruccion: 'syncAgregarObservacion',
      usuarioPropietario: prefs.getString("userId")!,
      idOrdenTrabajo: ordenTrabajo.id,
    ); //Se crea la nueva instruccion a realizar en bitacora

    nuevaInstruccionAgregarObservacion.observacion.target = nuevaObservacion;
    dataBase.bitacoraBox.put(nuevaInstruccionAgregarObservacion);
    nuevaObservacion.ordenTrabajo.target = ordenTrabajo;
    ordenTrabajo.observacion.add(nuevaObservacion);
    dataBase.observacionesBox.put(nuevaObservacion); //Agregamos la observacion en objectBox
    dataBase.ordenTrabajoBox.put(ordenTrabajo); 
    notifyListeners();
    return true;
  }

  void update(int id, String newNombre, String newApellidos, String newCurp, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idEmprendimiento) {

    notifyListeners();
  }

  // void addImagen(int idEmprendimiento) {
  //   final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
  //   if (emprendimiento != null) {
  //     final nuevaInstruccion = Bitacora(instruccion: 'syncAddImagenEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
  //     imagenLocal!.bitacora.add(nuevaInstruccion);
  //     emprendimiento.emprendedor.target!.imagen.target = imagenLocal;
  //     dataBase.imagenesBox.put(imagenLocal!);
  //     dataBase.emprendedoresBox.put(emprendimiento.emprendedor.target!);
  //     //print('Imagen Emprendedor agregada exitosamente');
  //     notifyListeners();
  //   } 
  // }


  
}