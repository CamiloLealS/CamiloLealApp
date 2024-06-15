<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('equipo_partido', function (Blueprint $table) {
            $table->unsignedBigInteger('fk_equipo_id');
            $table->unsignedBigInteger('fk_partido_id');
            $table->foreign('fk_equipo_id')->references('id')->on('equipos');
            $table->foreign('fk_partido_id')->references('id')->on('partidos');
            $table->primary(['fk_equipo_id','fk_partido_id']);
            $table->integer('puntos');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('equipo_partido');
    }
};
