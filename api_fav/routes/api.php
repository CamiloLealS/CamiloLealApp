<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\EquipoController;
use App\Http\Controllers\JugadoreController;
use App\Http\Controllers\PartidoController;
use App\Http\Controllers\TorneoController;

Route::resource("/equipos", EquipoController::class);
Route::resource("/jugadores", JugadoreController::class);
Route::resource("/partidos", PartidoController::class);
Route::resource("/torneos", TorneoController::class);
Route::post('/torneos', [TorneoController::class,'store']);
Route::post('/partidos', [PartidoController::class,'store']);
Route::get('/partidos/{id}',[PartidoController::class,'show']);
Route::get('/partidos/torneos/{torneo_id}', [PartidoController::class, 'showByTorneo']);

//Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    //return $request->user();
//});
