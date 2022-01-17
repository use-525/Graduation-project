<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cookie;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        if (Cookie::get('token') != null) {
            $this->middleware(['header_api','auth:api']);
        }
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
   
    public function index()
    {
        // dd(Auth::user());
        // dd(Auth::user()->allPermissions);
        return view('admin', [
            'auth' => Auth::user(),
        ]);
    }
}
