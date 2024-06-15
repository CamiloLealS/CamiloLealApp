<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Equipo extends Model
{
    protected $fillable = ['name', 'logo'];
    public $timestamps = false;

    public function jugadores()
    {
        return $this->hasMany(Jugadore::class, 'fk_equipo_id');
    }

    public function partidos()
    {
        return $this->belongsToMany(Partido::class, 'equipo_partido', 'fk_equipo_id', 'fk_partido_id')
                    ->withPivot('puntos');
    }
}
