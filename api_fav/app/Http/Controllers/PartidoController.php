<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Partido;
use App\Http\Resources\PartidoResource;
use Illuminate\Support\Facades\DB;

class PartidoController extends Controller
{
    public function index(Request $request)
    {
        $query = Partido::query();

        // Ordenar por fecha si se proporciona un parámetro de orden
        if ($request->has('orden') && in_array($request->orden, ['asc', 'desc'])) {
            $query->orderBy('fecha', $request->orden);
        }

        // Cargar los equipos relacionados
        $partidos = $query->with('equipos.jugadores')->get();

        return PartidoResource::collection($partidos);
    }

    public function store(Request $request)
    {
        // Validar los datos del request
        $validatedData = $request->validate([
            'fecha' => 'required',
            'completado' => 'required|boolean',
            'fk_torneo_id' => 'required|integer|exists:torneos,id',
            'equipo1_id' => 'required|integer|exists:equipos,id',
            'equipo2_id' => 'required|integer|exists:equipos,id',
            'equipo1_puntos' => 'nullable|integer',
            'equipo2_puntos' => 'nullable|integer',
        ]);

        // Crear el partido
        $partido = Partido::create([
            'fecha' => $validatedData['fecha'],
            'completado' => $validatedData['completado'],
            'fk_torneo_id' => $validatedData['fk_torneo_id']
        ]);

        // Insertar en la tabla pivot directamente solo si el partido está completado
        if ($validatedData['completado']) {
            DB::table('equipo_partido')->insert([
                [
                    'fk_equipo_id' => $validatedData['equipo1_id'],
                    'fk_partido_id' => $partido->id,
                    'puntos' => $validatedData['equipo1_puntos']
                ],
                [
                    'fk_equipo_id' => $validatedData['equipo2_id'],
                    'fk_partido_id' => $partido->id,
                    'puntos' => $validatedData['equipo2_puntos']
                ]
            ]);
        }else{
            DB::table('equipo_partido')->insert([
                [
                    'fk_equipo_id' => $validatedData['equipo1_id'],
                    'fk_partido_id' => $partido->id,
                    'puntos' => '0',
                ],
                [
                    'fk_equipo_id' => $validatedData['equipo2_id'],
                    'fk_partido_id' => $partido->id,
                    'puntos' => '0',
                ]
            ]);
        }

        // Devolver una respuesta JSON
        return response()->json(['message' => 'Partido creado con éxito', 'partido' => $partido], 201);
    }
    public function showByTorneo($torneo_id)
    {
        $partidos = Partido::where('fk_torneo_id', $torneo_id)->get();
        return response()->json($partidos);
    }

    public function show($id)
    {
        // Buscar el partido por ID y cargar las relaciones con los equipos
        $partido = Partido::with(['equipos'])->findOrFail($id);

        // Devolver el partido como un recurso
        return new PartidoResource($partido);
    }

    public function update(Request $request, $id)
    {
        $partido = Partido::findOrFail($id);
        $partido->update($request->all());
        return new PartidoResource($partido);
    }

    public function destroy($id)
    {
        DB::table('equipo_partido')->where('fk_partido_id', $id)->delete();

        // Luego, eliminar el partido
        Partido::destroy($id);

        return response()->json(null, 204);
    }
}
