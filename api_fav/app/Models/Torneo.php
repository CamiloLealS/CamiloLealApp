<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Torneo extends Model
{
    protected $fillable = ['name', 'reglas', 'logo', 'prizepool', 'ubicacion'];
    public $timestamps = false;
    public function partidos()
    {
        return $this->hasMany(Partido::class, 'fk_torneo_id');
    }
}
