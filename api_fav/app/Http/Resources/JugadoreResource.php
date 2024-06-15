<?php

namespace App\Http\Resources;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\Resources\Json\JsonResource;

class JugadoreResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'nickname' => $this->nickname,
            'id_equipo' => $this->fk_equipo_id,
        ];
    }
}
