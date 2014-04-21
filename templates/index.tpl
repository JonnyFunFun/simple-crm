{extends '_template_.tpl'}

{block name=body}
<!-- Main component for a primary marketing message or call to action -->
<div class="jumbotron">
    <h1>Simple CRM</h1>
    <p>This application is a simple CRM application to handle tracking customers, as well as their addresses, emails,
        and all contacts with that customer.</p>
    <p>This application is a result of IT-330 - Database Design &amp; Management - and was written by
        <a href="http://www.jonathanenzinna.com/" target="_blank">Jonathan Enzinna</a>.</p>
    <p>
        <a class="btn btn-lg btn-primary" href="{$base_url}customers/list/" role="button">Get started &raquo;</a>
    </p>
</div>
{/block}