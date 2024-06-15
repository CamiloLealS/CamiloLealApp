<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Partido extends Model
{
    protected $fillable = ['completado', 'fk_torneo_id', 'fecha'];
    public $timestamps = false;

    public function torneo()
    {
        return $this->belongsTo(Torneo::class, 'fk_torneo_id');
    }

    public function equipos()
    {
        return $this->belongsToMany(Equipo::class, 'equipo_partido', 'fk_partido_id', 'fk_equipo_id')
                    ->withPivot('puntos');
    }
}
