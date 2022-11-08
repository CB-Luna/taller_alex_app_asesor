import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/save_imagenes_local.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/save_instruccion_imagen_temporal.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class JornadaController extends ChangeNotifier {

  List<Jornadas> jornadas = [];

  GlobalKey<FormState> jornadaFormKey = GlobalKey<FormState>();

  //Jornada
  // String numJornada = '';
  DateTime? fechaRevision = DateTime.now();
  DateTime? fechaRegistro = DateTime.now();
  String tarea = "";
  String comentarios = "";
  String descripcion = "";
  List<String> imagenes = [];
  List<SaveImagenesLocal> imagenesLocal = [];
  List<SaveInstruccionImagenTemporal> instruccionesImagenesTemp = [];
  bool activo = true;
  String tipoProyecto = "";
  String proyecto =  "";

  bool validateForm(GlobalKey<FormState> jornadaKey) {
    return jornadaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    // numJornada = '';
    fechaRevision = null;
    fechaRegistro = null;
    tarea = "";
    comentarios = "";
    descripcion = "";
    imagenes = [];
    imagenesLocal = [];
    instruccionesImagenesTemp = [];
    activo = true;
    tipoProyecto = "";
    proyecto = "";
  }


  void addJornada1(int idEmprendimiento, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      completada: false,
      );
    final nuevaTarea = Tareas(
      tarea: tarea,
      descripcion: "Creación Jornada 1",
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro);
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 1")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      print("Fase de Add1: ${faseEmp.fase}");
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 1
      final nuevaInstruccionJornada = Bitacora(instruccion: 'syncAddJornada1', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instruccion: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 1", usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      nuevaTarea.jornada.target = nuevaJornada;
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 1 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void updateJornada1(int id, DateTime newFechaRegistro, DateTime newFechaRevision, String newTarea, bool newCompletada, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateJornada1', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
          statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
          dataBase.statusSyncBox.put(statusSyncTarea);
        }
      dataBase.tareasBox.put(updateTarea);
      var updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.fechaRevision = newFechaRevision;
        updateJornada.completada = newCompletada;
        final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
        if (statusSyncJornada != null) {
          statusSyncJornada.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la jornada
          dataBase.statusSyncBox.put(statusSyncJornada);
        }
        updateJornada.bitacora.add(nuevaInstruccion);
        dataBase.jornadasBox.put(updateJornada);
        print('Jornada actualizada exitosamente');
      }
    }
    notifyListeners();
  }


  void addJornada2(int idEmprendimiento, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      completada: false,
      );
    final nuevaTarea = Tareas(
      tarea: tarea, 
      descripcion: "Creación Jornada 2", 
      comentarios: comentarios, 
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    //Se agregan las imagenes a la Tarea
    for (var i = 0; i < imagenes.length; i++) {
      final nuevaImagenTarea = Imagenes(
        imagenes: imagenes[i],
        nombre: imagenesLocal[i].nombre,
        path: imagenesLocal[i].path,
        base64: imagenesLocal[i].base64,
        ); //Se crea el objeto imagenes para la Tarea
      nuevaImagenTarea.tarea.target = nuevaTarea;
      nuevaTarea.imagenes.add(nuevaImagenTarea);
    }
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 2")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      print("Fase de Add2: ${faseEmp.fase}");
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 2
      final nuevaInstruccionJornada = Bitacora(instruccion: 'syncAddJornada2', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instruccion: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 2", usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      nuevaTarea.jornada.target = nuevaJornada;
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 2 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void updateJornada2(int id, DateTime newFechaRegistro, DateTime newFechaRevision, String newTarea, String newComentarios, bool newCompletada, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateJornada2', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      updateTarea.comentarios = newComentarios;
      //Se actualiza la tarea con las nuevas imagenes
      dataBase.tareasBox.put(updateTarea);
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
          statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
          dataBase.statusSyncBox.put(statusSyncTarea);
        }
      final updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.fechaRevision = newFechaRevision;
        updateJornada.completada = newCompletada;
        final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
        if (statusSyncJornada != null) {
          statusSyncJornada.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la jornada
          dataBase.statusSyncBox.put(statusSyncJornada);
        }
        updateJornada.bitacora.add(nuevaInstruccion);
        dataBase.jornadasBox.put(updateJornada);
        print('Jornada actualizada exitosamente');
      }
    }
    notifyListeners();
  }

  void updateImagenesJornada2(Tareas tarea, List<SaveInstruccionImagenTemporal> listInstruccionesImagenesTemp) {
    for (var i = 0; i < listInstruccionesImagenesTemp.length; i++) {
      switch (listInstruccionesImagenesTemp[i].instruccion) {
        case "syncAddImagenJornada2":
          final nuevaInstruccion = Bitacora(instruccion: 'syncAddImagenJornada2', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
          final nuevaImagenTarea = Imagenes(
            imagenes: listInstruccionesImagenesTemp[i].imagenLocal.path,
            nombre: listInstruccionesImagenesTemp[i].imagenLocal.nombre,
            path: listInstruccionesImagenesTemp[i].imagenLocal.path,
            base64: listInstruccionesImagenesTemp[i].imagenLocal.base64,
            ); //Se crea el objeto imagenes para la Tarea
          nuevaImagenTarea.tarea.target = tarea;
          nuevaImagenTarea.bitacora.add(nuevaInstruccion);
          int idNuevaTarea = dataBase.imagenesBox.put(nuevaImagenTarea);
          tarea.imagenes.add(dataBase.imagenesBox.get(idNuevaTarea)!);
          dataBase.tareasBox.put(tarea);
          print("Número de jornada desde syncAddImagenJornada2: ${tarea.jornada.target!.numJornada}");
          continue;
        case "syncUpdateImagenJornada2":
          final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateImagenJornada2', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
          final updateImagen = dataBase.imagenesBox.get(listInstruccionesImagenesTemp[i].imagenLocal.id!);
          if(updateImagen != null) {
            updateImagen.imagenes = listInstruccionesImagenesTemp[i].imagenLocal.path;
            updateImagen.nombre = listInstruccionesImagenesTemp[i].imagenLocal.nombre;
            updateImagen.path = listInstruccionesImagenesTemp[i].imagenLocal.path;
            updateImagen.base64 = listInstruccionesImagenesTemp[i].imagenLocal.base64;
            updateImagen.bitacora.add(nuevaInstruccion);
            dataBase.imagenesBox.put(updateImagen);
            continue;
          } else {
            continue;
          }
        case "syncDeleteImagenJornada":
          final deleteImagen = dataBase.imagenesBox.get(listInstruccionesImagenesTemp[i].imagenLocal.id ?? -1);
          if(deleteImagen != null) {
            final nuevaInstruccion = Bitacora(
              instruccion: 'syncDeleteImagenJornada', 
              instruccionAdicional: listInstruccionesImagenesTemp[i].instruccionAdicional, 
              usuario: prefs.getString("userId")!,
              idDBR: deleteImagen.idDBR,
              idEmiWeb: deleteImagen.idEmiWeb,
              emprendimiento: deleteImagen.tarea.target!.jornada.target!.emprendimiento.target!.nombre,
            ); //Se crea la nueva instruccion a realizar en bitacora
            deleteImagen.bitacora.add(nuevaInstruccion);
            // Se elimina imagen de ObjectBox
            dataBase.imagenesBox.remove(deleteImagen.id);
            continue;
          } else {
            continue;
          }
        default:
          continue;
      }
    }
  }

  void addJornada3(int idEmprendimiento, int idCatalogoProyecto, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      completada: false,
      );
    final nuevaTarea = Tareas(
      tarea: tarea, 
      descripcion: descripcion, 
      comentarios: comentarios,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    //Se agregan las imagenes a la Tarea
    for (var i = 0; i < imagenes.length; i++) {
      final nuevaImagenTarea = Imagenes(
        imagenes: imagenes[i],
        nombre: imagenesLocal[i].nombre,
        path: imagenesLocal[i].path,
        base64: imagenesLocal[i].base64,
        ); //Se crea el objeto imagenes para la Tarea
      nuevaImagenTarea.tarea.target = nuevaTarea;
      nuevaTarea.imagenes.add(nuevaImagenTarea);
    }
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 3")).build().findFirst();
    //Se recupera el tipo proyecto y proyecto
    final catalogoProyecto = dataBase.catalogoProyectoBox.get(idCatalogoProyecto);
    if (emprendimiento != null && catalogoProyecto != null && faseEmp != null) {
      print("Fase de Add3: ${faseEmp.fase}");
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 3
      final nuevaInstruccionJornada = Bitacora(instruccion: 'syncAddJornada3', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instruccion: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 3", usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      //Se asigna una catalogoProyecto(Proyecto) al emprendimiento, como por default catalogoProuyecto ya tiene un clasificacion emprendimiento
      emprendimiento.catalogoProyecto.target = catalogoProyecto;
      nuevaTarea.jornada.target = nuevaJornada;
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 3 agregada exitosamente');
      // Se actualiza el estado del emprendimiento porque se cambia su clasificacionEmp
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(emprendimiento.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
      }
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void updateJornada3(int id, int idEmprendimiento, DateTime newFechaRegistro, String newTarea, bool newCompletada, DateTime newFechaRevision, 
    String newComentarios, List<String> newImagenes, List<Imagenes>? oldImagenes, int newIdProyecto, String newDescripcion, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateJornada3', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      updateTarea.comentarios = newComentarios;
      updateTarea.descripcion = newDescripcion;
      //Se eliminan imagenes anteriores
      if (oldImagenes != null) {
        for (var i = 0; i < oldImagenes.length; i++) {
        dataBase.imagenesBox.remove(oldImagenes[i].id);
      }
      }
      //Se agregan las nuevas imagenes
      for (var i = 0; i < newImagenes.length; i++) {
        final nuevaImagenTarea = Imagenes(imagenes: newImagenes[i]); //Se crea el objeto imagenes para la Tarea
        int idNuevaTarea = dataBase.imagenesBox.put(nuevaImagenTarea);
        updateTarea.imagenes.add(dataBase.imagenesBox.get(idNuevaTarea)!);
      }
      //Se actualiza la tarea con las nuevas imagenes
      dataBase.tareasBox.put(updateTarea);
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
        statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
        dataBase.statusSyncBox.put(statusSyncTarea);
      }
      dataBase.tareasBox.put(updateTarea);
      var updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.fechaRevision = newFechaRevision;
        updateJornada.completada = newCompletada;
        final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
        if (statusSyncJornada != null) {
          statusSyncJornada.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la jornada
          dataBase.statusSyncBox.put(statusSyncJornada);
        }
        dataBase.jornadasBox.put(updateJornada);
        final updateEmprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
        final updateCatalogoProyecto = dataBase.catalogoProyectoBox.get(newIdProyecto);
        if (updateEmprendimiento != null && updateCatalogoProyecto != null) {
          //Se actualiza un catalogoProyecto(Proyecto) al emprendimiento, como por default catalogoProuyecto ya tiene un clasificacion emprendimiento
          updateEmprendimiento.catalogoProyecto.target = updateCatalogoProyecto;
          //Indispensable para que se muestre en la lista de jornadas
          dataBase.emprendimientosBox.put(updateEmprendimiento);
          // Se actualiza el estado del emprendimiento porque se cambia su clasificacionEmp
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
          }
          updateJornada.bitacora.add(nuevaInstruccion);
          notifyListeners();
          print('Jornada 3 actualizada exitosamente');
        }
      }
    }
  }

  void addJornada4(int idEmprendimiento, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      completada: false,
      );
    final nuevaTarea = Tareas(
      tarea: "Creación Jornada 4",
      descripcion: "Creación Jornada 4",
      comentarios: comentarios,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
      print("Entro aca");
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    //Se agregan las imagenes a la Tarea
    for (var i = 0; i < imagenes.length; i++) {
      final nuevaImagenTarea = Imagenes(
        imagenes: imagenes[i],
        nombre: imagenesLocal[i].nombre,
        path: imagenesLocal[i].path,
        base64: imagenesLocal[i].base64,
        ); //Se crea el objeto imagenes para la Tarea
      nuevaImagenTarea.tarea.target = nuevaTarea;
      nuevaTarea.imagenes.add(nuevaImagenTarea);
    }
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 4")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      print("Fase de Add4: ${faseEmp.fase}");
      // Se actualiza el estado activo de las jornadas anteriores
      jornadas = emprendimiento.jornadas.toList();
      for (var i = 0; i < jornadas.length; i++) {
        jornadas[i].completada = true;
        final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(jornadas[i].statusSync.target!.id)).build().findUnique();
        if (statusSyncJornada != null) {
            statusSyncJornada.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la jornada
            dataBase.statusSyncBox.put(statusSyncJornada);
          }
        dataBase.jornadasBox.put(jornadas[i]);
        print('Jornada ${i + 1} actualizada exitosamente');
      }
      print("Entro aca");
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 1
      final nuevaInstruccionJornada = Bitacora(instruccion: 'syncAddJornada4', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instruccion: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 4", usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      nuevaTarea.jornada.target = nuevaJornada;
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 4 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void updateJornada4(int id, DateTime newFechaRegistro, String? newComentarios, List<String> newImagenes, List<Imagenes>? oldImagenes, bool newCompletada, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateJornada4', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.comentarios = newComentarios;
      //Se eliminan imagenes anteriores
      if (oldImagenes != null) {
        for (var i = 0; i < oldImagenes.length; i++) {
        dataBase.imagenesBox.remove(oldImagenes[i].id);
      }
      }
      //Se agregan las nuevas imagenes
      for (var i = 0; i < newImagenes.length; i++) {
        final nuevaImagenTarea = Imagenes(imagenes: newImagenes[i]); //Se crea el objeto imagenes para la Tarea
        int idNuevaTarea = dataBase.imagenesBox.put(nuevaImagenTarea);
        updateTarea.imagenes.add(dataBase.imagenesBox.get(idNuevaTarea)!);
      }
      //Se actualiza la tarea con las nuevas imagenes
      dataBase.tareasBox.put(updateTarea);
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
          statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
          dataBase.statusSyncBox.put(statusSyncTarea);
        }
      dataBase.tareasBox.put(updateTarea);
      var updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.completada = newCompletada;
        final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
        if (statusSyncJornada != null) {
          statusSyncJornada.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la jornada
          dataBase.statusSyncBox.put(statusSyncJornada);
        }
        updateJornada.bitacora.add(nuevaInstruccion);
        dataBase.jornadasBox.put(updateJornada);
        print('Jornada actualizada exitosamente');
      }
    }
    notifyListeners();
  }

  void remove(Jornadas jornada) {
    dataBase.jornadasBox.remove(jornada.id);
    notifyListeners(); 
  }

  getAll() {
    jornadas = dataBase.jornadasBox.getAll();
    notifyListeners();
  }

  void getJornadasActualUser(List<Emprendimientos> emprendimientos) {
    jornadas = [];
    emprendimientos.forEach((element) {
      element.jornadas.forEach(
        (element) {jornadas.add(element);
        });
    });
  }
  void getJornadasByEmprendimiento(Emprendimientos emprendimiento) {
    jornadas = [];
    jornadas = emprendimiento.jornadas.toList();
  }
  
}