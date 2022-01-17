@php
$config = [
    'appName' => config('app.name'),
    'locale' => $locale = app()->getLocale(),
    'locales' => config('app.locales'),
    // 'githubAuth' => config('services.github.client_id'),
];
@endphp
<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  @routes
  <title>{{ config('app.name') }}</title>
  <link rel="stylesheet" href="{{asset('dist/css/main.css')}}">
  <link rel="stylesheet" href="{{asset('dist/css/bootstrap.min.css')}}">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
  <div class="wrapper" id="app">

  </div>

  {{-- Global configuration object --}}
  <script>
    window.config = @json($config);
    @if($access_token)
    document.cookie = 'token='+{!! json_encode($access_token); !!};
    window.location.href ='/';
    @endif
  </script>

<script src="{{asset('/js/app.js')}}"></script>
<script src="{{asset('dist/js/bootstrap.min.js')}}"></script>
<script src="{{asset('dist/js/jquery.js')}}"></script>
<script src="{{asset('dist/js/hide-sidebar.js')}}"></script>
</body>
</html>
