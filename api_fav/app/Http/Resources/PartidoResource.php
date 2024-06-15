<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PartidoResource extends JsonResource
{
    
    public function toArray($request)
    {
        return [
            "id"=> $this->id,
            "completado" => $this->completado,
            "torneo_id" => $this->fk_torneo_id,
            "fecha" => $this->fecha,
            "equipos" => $this->equipos->map(function ($equipo){
                return [
                    'id' => $equipo->id,
                    'name' => $equipo ->name,
                    'logo' => $equipo->logo,
                    'puntos' => $equipo->pivot->puntos,
                    'jugadores' => $equipo->jugadores,
                ];
            }),
        ];
    }
}
