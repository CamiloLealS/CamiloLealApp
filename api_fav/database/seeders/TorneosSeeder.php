<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TorneosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table("torneos")->insert([
            ['name'=>'Masters Reykjavik 2022', 'reglas'=>'1.No cheats','logo'=> 'mastersReyk.png', 'prizepool'=> '1000000', 'ubicacion'=>'Reykjavik, Islandia'],
            ['name'=>'Champions Istanbul 2022', 'reglas'=>'1.No cheats','logo'=> 'champIstan.png', 'prizepool'=> '1000000', 'ubicacion'=>'Estambul, Turquía'],
            ['name'=>'Masters Tokyo 2023', 'reglas'=>'1.No cheats','logo'=> 'mastersTok.png', 'prizepool'=> '1000000', 'ubicacion'=>'Tokyo, Japón'],
            ['name'=>'Champions Los Angeles 2023', 'reglas'=>'1.No cheats','logo'=> 'champLA.png', 'prizepool'=> '1000000', 'ubicacion'=>'Los Ángeles, USA'],
        ]);
    }
}
