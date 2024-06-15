<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class TorneoResource extends JsonResource
{
    public function toArray($request)
    {
        $equipos = $this->partidos->flatMap->equipos->unique('id');
        return [
            "id"=> $this->id,
            "logo" => $this->logo,
            "ubicacion" => $this->ubicacion,
            "prizepool" => $this->prizepool,
            "name" => $this->name,
            "reglas" => $this->reglas,
            'equipos' => EquipoResource::collection($equipos),
        ];
    }
}
