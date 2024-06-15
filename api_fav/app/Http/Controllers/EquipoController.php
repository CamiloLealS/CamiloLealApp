<?php

namespace App\Http\Controllers;

use App\Http\Resources\EquipoResource;
use Illuminate\Http\Request;
use App\Models\Equipo;

class EquipoController extends Controller
{
    public function index()
    {
        $equipo = Equipo::with(['jugadores','partidos'])->get();
        return EquipoResource::collection($equipo);
    }

    public function store(Request $request)
    {
        $equipo = Equipo::create($request->all());
        return new EquipoResource($equipo);
    }

    public function show($id)
    {
        $equipo = Equipo::with('jugadores', 'partidos')->findOrFail($id);
        return new EquipoResource($equipo);
    }

    public function update(Request $request, $id)
    {
        $equipo = Equipo::findOrFail($id);
        $equipo->update($request->all());
        return new EquipoResource($equipo);
    }

    public function destroy($id)
    {
        Equipo::destroy($id);
        return response()->json(null, 204);
    }
}
