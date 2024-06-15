<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PartidosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table("partidos")->insert([
            ['completado'=>'1','fk_torneo_id'=> '1', 'fecha'=> '2022-05-14 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '1', 'fecha'=> '2022-05-15 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '1', 'fecha'=> '2022-05-18 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '1', 'fecha'=> '2022-05-19 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '2', 'fecha'=> '2022-10-14 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '2', 'fecha'=> '2022-10-15 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '2', 'fecha'=> '2022-10-18 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '2', 'fecha'=> '2022-10-19 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '3', 'fecha'=> '2023-05-14 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '3', 'fecha'=> '2023-05-15 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '3', 'fecha'=> '2023-05-18 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '3', 'fecha'=> '2023-05-19 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '4', 'fecha'=> '2023-10-14 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '4', 'fecha'=> '2023-10-15 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '4', 'fecha'=> '2023-10-18 00:00:00'],
            ['completado'=>'1','fk_torneo_id'=> '4', 'fecha'=> '2023-10-19 00:00:00'],
        ]);
    }
}
