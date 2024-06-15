<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class EquipoPartidoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table("equipo_partido")->insert([
            ['fk_equipo_id'=>'1','fk_partido_id'=>'46','puntos'=> '2'],
            ['fk_equipo_id'=>'2','fk_partido_id'=>'46','puntos'=>  '1'],
            ['fk_equipo_id'=>'3','fk_partido_id'=>'47','puntos'=> '2'],
            ['fk_equipo_id'=>'4','fk_partido_id'=>'47','puntos'=>  '1'],
            ['fk_equipo_id'=>'2','fk_partido_id'=>'48','puntos'=> '3'],
            ['fk_equipo_id'=>'3','fk_partido_id'=>'48','puntos'=> '2'],
            ['fk_equipo_id'=> '1','fk_partido_id'=>'49','puntos'=> '3'],
            ['fk_equipo_id'=>'4','fk_partido_id'=>'49','puntos'=> '2'],
            ['fk_equipo_id'=> '1','fk_partido_id'=>'50','puntos'=> '2'],
            ['fk_equipo_id'=>'3','fk_partido_id'=>'50','puntos'=>  '1'],
            ['fk_equipo_id'=>'2','fk_partido_id'=>'51','puntos'=> '2'],
            ['fk_equipo_id'=>'4','fk_partido_id'=>'51','puntos'=>  '1'],
            ['fk_equipo_id'=>'3','fk_partido_id'=>'52','puntos'=>  '1'],
            ['fk_equipo_id'=>'4','fk_partido_id'=>'52','puntos'=> '3'],
            ['fk_equipo_id'=> '1','fk_partido_id'=>'53','puntos'=> '3'],
            ['fk_equipo_id'=>'2','fk_partido_id'=>'53','puntos'=>  '1'],
            ['fk_equipo_id'=> '1','fk_partido_id'=>'54','puntos'=> '2'],
            ['fk_equipo_id'=>'4','fk_partido_id'=>'54','puntos'=>  '1'],
            ['fk_equipo_id'=>'2','fk_partido_id'=>'55','puntos'=> '2'],
            ['fk_equipo_id'=>'3','fk_partido_id'=>'55','puntos'=> '1'],
            ['fk_equipo_id'=>'4','fk_partido_id'=>'56','puntos'=> '3'],
            ['fk_equipo_id'=>'3','fk_partido_id'=>'56','puntos'=> '2'],
            ['fk_equipo_id'=> '1','fk_partido_id'=>'57','puntos'=> '3'],
            ['fk_equipo_id'=>'2','fk_partido_id'=>'57','puntos'=> '0'],
            ['fk_equipo_id'=> '1','fk_partido_id'=>'58','puntos'=> '1'],
            ['fk_equipo_id'=>'4','fk_partido_id'=>'58','puntos'=> '2'],
            ['fk_equipo_id'=>'2','fk_partido_id'=>'59','puntos'=> '2'],
            ['fk_equipo_id'=>'3','fk_partido_id'=>'59','puntos'=>  '1'],
            ['fk_equipo_id'=> '1','fk_partido_id'=>'60','puntos'=> '3'],
            ['fk_equipo_id'=>'3','fk_partido_id'=>'60','puntos'=>  '1'],
            ['fk_equipo_id'=>'4','fk_partido_id'=>'61','puntos'=> '3'],
            ['fk_equipo_id'=>'2','fk_partido_id'=>'61','puntos'=>  '1'],
           ]);
    }
}
