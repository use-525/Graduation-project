<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\HomeController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

// Route::get('{path}', [SpaController::class,'index'])->where('path', '(.*)');
// Route::get('/admin/{any?}', function () {
//     return view('home');
// })->where('any', '[\/\w\.-]*');
Route::get('/auth/redirect', [AuthController::class, 'redirect'])->name('redirect.github');
Route::get('/callback', [AuthController::class, 'callback'])->name('callback.github');

Route::get('/{any?}', [HomeController::class,'index'])->where('any', '[\/\w\.-]*');
