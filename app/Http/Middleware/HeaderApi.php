<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;


class HeaderApi
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        //add more headers here
        $request->headers->set('Accept', 'application/json');
        $request->headers->set('Authorization', 'Bearer '.Cookie::get('token'));

        return $next($request);
    }
}
