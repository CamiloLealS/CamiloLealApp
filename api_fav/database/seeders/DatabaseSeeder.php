<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
       $this->call([
        EquiposSeeder::class,
        JugadoresSeeder::class,
        TorneosSeeder::class,
        PartidosSeeder::class,
        EquipoPartidoSeeder::class,
       ]);
    }
}
