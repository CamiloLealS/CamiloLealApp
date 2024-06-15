<?php

namespace App\Http\Controllers;

use App\Http\Resources\JugadoreResource;
use Illuminate\Http\Request;
use App\Models\Jugadore;

class JugadoreController extends Controller
{
    public function index()
    {
        $jugadores =  Jugadore::with(['equipo'])->get();
        return JugadoreResource::collection($jugadores);
    }

    public function store(Request $request)
    {
        $jugador = Jugadore::create($request->all());
        return new JugadoreResource($jugador);
    }

    public function show($id)
    {
        $jugador = Jugadore::with(['equipo'])->findOrFail($id);
        return new JugadoreResource($jugador);
    }

    public function update(Request $request, $id)
    {
        $jugador = Jugadore::findOrFail($id);
        $jugador->update($request->all());
        return new JugadoreResource($jugador);
    }

    public function destroy($id)
    {
        Jugadore::destroy($id);
        return response()->json(null, 204);
    }
}
