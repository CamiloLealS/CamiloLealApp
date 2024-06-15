<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class JugadoresSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table("jugadores")->insert([
            ['nickname'=>'Mazino', 'fk_equipo_id'=> '2'],
            ['nickname'=>'Aspas', 'fk_equipo_id'=> '2'],
            ['nickname'=>'KiNgg', 'fk_equipo_id'=> '2'],
            ['nickname'=>'C0m', 'fk_equipo_id'=> '2'],
            ['nickname'=>'Tex', 'fk_equipo_id'=> '2'],
            ['nickname'=>'Kezn1t', 'fk_equipo_id'=> '1'],
            ['nickname'=>'Klaus', 'fk_equipo_id'=> '1'],
            ['nickname'=>'Shyy', 'fk_equipo_id'=> '1'],
            ['nickname'=>'Heat', 'fk_equipo_id'=> '1'],
            ['nickname'=>'Melser', 'fk_equipo_id'=> '1'],
            ['nickname'=>'Boaster', 'fk_equipo_id'=> '3'],
            ['nickname'=>'Derke', 'fk_equipo_id'=> '3'],
            ['nickname'=>'Alfajer', 'fk_equipo_id'=> '3'],
            ['nickname'=>'Leo', 'fk_equipo_id'=> '3'],
            ['nickname'=>'Chronicle', 'fk_equipo_id'=> '3'],
            ['nickname'=>'Boo', 'fk_equipo_id'=> '4'],
            ['nickname'=>'benjyfishy', 'fk_equipo_id'=> '4'],
            ['nickname'=>'MiniBoo', 'fk_equipo_id'=> '4'],
            ['nickname'=>'RieNs', 'fk_equipo_id'=> '4'],
            ['nickname'=>'Wo0t', 'fk_equipo_id'=> '4']
        ]);
    }
}
