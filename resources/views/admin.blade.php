@php
$config = [
    'appName' => config('app.name'),
    'locale' => $locale = app()->getLocale(),
    'locales' => config('app.locales'),
    'githubAuth' => config('services.github.client_id'),
];
@endphp
<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="csrf-token" value="{{ csrf_token() }}" />
  @routes
  <title>{{ config('app.name') }}</title>
  <link rel="shortcut icon" type="image/x-icon" href="{{url('images/logo-icon.png')}}" />
  <!-- GLOBAL MAINLY STYLES-->
  <link href="{{asset('assets/vendors/bootstrap/dist/css/bootstrap.min.css')}}" rel="stylesheet" />
  <link href="{{asset('assets/vendors/font-awesome/css/font-awesome.min.css')}}" rel="stylesheet" />
  <link href="{{asset('assets/vendors/themify-icons/css/themify-icons.css')}}" rel="stylesheet" />
  <!-- PLUGINS STYLES-->
  <!-- THEME STYLES-->
  <link href="{{asset('assets/css/main.min.css')}}" rel="stylesheet" />
  <!-- PAGE LEVEL STYLES-->
  <link href="{{asset('assets/css/themes/blue.css')}}" rel="stylesheet" id="theme-style">

  <link rel="stylesheet" href="{{asset('dist/css/main.css')}}">
</head>

<body class="fixed-navbar has-animation bg-silver-300">
  <div id="app">
    
  </div>

  {{-- Global configuration object --}}
  <script>
    window.config = @json($config);
    @if($auth)
    window.Permissions = {!! json_encode($auth->allPermissions, true) !!};
    @else
    window.Permissions = [];
    @endif
  </script>

  {{-- Load the application scripts --}}
  <!-- jQuery -->
 <!-- CORE PLUGINS-->
 <script src="{{asset('/js/app.js')}}"></script>

 <script src="{{asset('assets/vendors/metisMenu/dist/metisMenu.min.js')}}" type="text/javascript"></script>
 <script src="{{asset('assets/vendors/jquery-slimscroll/jquery.slimscroll.min.js')}}" type="text/javascript"></script>
 <!-- PAGE LEVEL PLUGINS-->

<script src="{{asset('dist/js/hide-sidebar.js')}}"></script>
 <!-- CORE SCRIPTS-->
 <script defer src="{{asset('assets/js/app.js')}}" type="text/javascript"></script>

</body>
</html>
