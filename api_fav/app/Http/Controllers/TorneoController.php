<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Torneo;
use App\Http\Resources\TorneoResource;
use Illuminate\Support\Facades\DB;
use App\Models\Partido;

class TorneoController extends Controller
{
    public function index()
    {
        $torneos = Torneo::with(['partidos'])->get();
        return TorneoResource::collection($torneos);
    }

    public function store(Request $request)
    {
        // Validar los datos
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'logo' => 'required|string|max:255',
            'prizepool' =>'required|int',
            'ubicacion'=> 'required|string|max:255',
            'reglas'=> 'required|string|max:255',
        ]);

        // Crear el torneo
        $torneo = Torneo::create($validatedData);

        return response()->json([
            'message' => 'Torneo creado con éxito',
            'data' => $torneo
        ], 201);
    }

    public function show($id)
    {
        $torneo = Torneo::with('partidos.equipos')->findOrFail( $id );
        $equipos = collect([]);
        foreach ($torneo->partidos as $partido){
            $equipos->push($partido->equipos);
        }
        $equipos = $equipos->flatten()->unique('id');
        return new TorneoResource($torneo);
    }

    public function update(Request $request, $id)
    {
        $torneo = Torneo::findOrFail($id);
        $torneo->update($request->all());
        return new TorneoResource($torneo);
    }

    public function destroy($id)
    {
        $partidos = Partido::where('fk_torneo_id', $id)->get();
        foreach ($partidos as $partido) {
            DB::table('equipo_partido')->where('fk_partido_id', $partido->id)->delete();
            $partido->delete();
        }

        // Luego, eliminar el torneo
        Torneo::destroy($id);

        return response()->json(null, 204);
    }
}
