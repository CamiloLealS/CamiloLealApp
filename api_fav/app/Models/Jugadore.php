<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Jugadore extends Model
{
    protected $fillable = ['nickname', 'fk_equipo_id'];
    public $timestamps = false;

    public function equipo()
    {
        return $this->belongsTo(Equipo::class, 'fk_equipo_id');
    }
}
