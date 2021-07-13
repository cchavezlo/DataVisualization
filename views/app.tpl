<!DOCTYPE html>
<html>

<head>
    <meta name="description" content="Revisa tus notas de la UNSA, calcula tus promedios y descubre cuanto te falta." />
    <meta property="og:image" content="/static/logo.png" />
    <meta property="og:url" content="https://cuantomefalta.app/" />
    <meta property="og:title" content="CuantoMeFalta" />
    <meta property="og:description"
        content="Revisa tus notas de la UNSA, calcula tus promedios y descubre cuanto te falta." />

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">


    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{get('title','NOT')}}</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
    <script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.7/jquery.validate.min.js">
    </script>

    <link href="https://fonts.googleapis.com/css?family=Averia+Libre" rel="stylesheet">
    <script type="text/javascript" src="/static/d3.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/d3/5.7.0/d3.min.js"></script>
    <script type="text/javascript" src="https://d3js.org/topojson.v3.min.js"></script>





    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700&display=swap" rel="stylesheet">
    <link rel='stylesheet' type='text/css' href='/static/style.css'>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.4.1/dist/chart.min.js"></script>

    <!--<script src="/static/utils.js"></script>->
     <script src="https://d3js.org/d3.v5.min.js"></script>
    <script src="https://unpkg.com/simple-statistics@7.0.2/dist/simple-statistics.min.js"></script>
    <script src="https://unpkg.com/topojson@3"></script>

    <style>

        .tabs>.indicator {
            background-color: #64b5f6;
        }

        .modal {
            border-radius: 30px;
        }

        .rdn {
            border-radius: 15px;
        }
    </style>
    -->

</head>

<body>
    <!--Nav bar y side bar-->
    <nav class="green darken-3 nav-extended">
        <div class="nav-wrapper container">

            <a href="/" class="brand-logo" style="cursive; font-size: 37px"> Ciencia de Datos</a>

            <ul class="right hide-on-med-and-down">
                <li><a href="/">Explorar Datos</a></li>
                <li><a href="/nulos"> Nulos </a> </li>
                <li><a class="dropdown-button" data-constrainWidth='false' data-beloworigin='true' href='#'
                        data-activates='dd1'>Opciones <i class="material-icons right">arrow_drop_down</i></a> </li>

            </ul>

        </div>
    </nav>

    <!--Contenido-->
    <div class="container ">

        {{!base}}
        <div class="section"></div>

    </div>
    <!--Scripts-->

    <script type="text/javascript">
        //$(".tabs>li>a").css("color", '#1e88e5');
        $(".dropdown-content>li>a").css("color", '#1e88e5');
        $(".button-collapse").sideNav({
            draggable: true
        });
        $('#licencia').modal();
        $('.collapsible').collapsible();
    </script>
</body>

</html>