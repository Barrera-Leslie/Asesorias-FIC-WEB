import 'package:asesorias_fic/core/colores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TablaEstudiantes extends StatefulWidget {
  const TablaEstudiantes({super.key});

  @override
  State<TablaEstudiantes> createState() => _TablaEstudiantesState();
}

class _TablaEstudiantesState extends State<TablaEstudiantes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demostración de tabla')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          border: TableBorder.all(
            color: Colors.grey.shade300,
            width: 1,
            borderRadius: BorderRadius.circular(8),
          ),
          columns: const [
            DataColumn(label: Text("Nombre")),
            DataColumn(label: Text("Carrera")),
            DataColumn(label: Text("Grupo")),
            DataColumn(label: Text("Numero Cuenta")),
            DataColumn(label: Text("Acciones")),
          ],
          rows: [
            DataRow(
              cells: [
                const DataCell(Text("Luis Fernando Velazquez Araujo")),
                const DataCell(Text("Licenciatura en Informatica")),
                const DataCell(Text("5-1")),
                const DataCell(Text("19519958")),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.info),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text("Jenifer Guadalupe Tizoc Lopez")),
                const DataCell(Text("Licenciatura en Informatica")),
                const DataCell(Text("5-1")),
                const DataCell(Text("19519958")),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info,
                          color: UasColores.azulOficial,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: CupertinoColors.systemYellow,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text("Jose Angel Astorga Mejia")),
                const DataCell(Text("Licenciatura en Informatica")),
                const DataCell(Text("5-1")),
                const DataCell(Text("19519958")),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.info),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text("Crisoforo Ahuelican Ahuejote")),
                const DataCell(Text("Licenciatura en Informatica")),
                const DataCell(Text("5-1")),
                const DataCell(Text("19519958")),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.info),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
