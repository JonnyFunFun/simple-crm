<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Simple CRM</title>

    <!-- Bootstrap core CSS -->
    <link href="{$base_url}css/bootstrap.min.css" rel="stylesheet"/>
    <link href="{$base_url}css/jquery.dataTables.css" rel="stylesheet"/>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<!-- Fixed navbar -->
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        {include file='_nav.inc.tpl'}
    </div>
</div>

<div class="container" style="margin-top: 64px;">
    {if $messages != ''}
        {$messages}
    {/if}
    {block name=body}
    {/block}
</div> <!-- /container -->

<!-- Modal dialog DIV -->
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" style="padding: 12px;">
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="{$base_url}js/jquery.min.js"></script>
<script src="{$base_url}js/bootstrap.min.js"></script>
<script src="{$base_url}js/jquery.dataTables.min.js"></script>
<script src="{$base_url}js/bootbox.min.js"></script>
<script src="{$base_url}js/simple-crm.js"></script>
</body>
</html>
