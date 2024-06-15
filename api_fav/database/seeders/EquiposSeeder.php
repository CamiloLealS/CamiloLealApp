<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class EquiposSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run(): void
    {
        DB::table('equipos')->insert([
            ['name'=>'KRU Esports', 'logo'=>'kru.png'],
            ['name'=>'Leviatan', 'logo'=>'lev.png'],
            ['name'=>'FNATIC', 'logo'=>'fnatic.png'],
            ['name'=>'Team Heretics', 'logo'=>'th.png'],
        ]);
    }
}
