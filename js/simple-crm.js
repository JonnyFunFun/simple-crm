/**
 * Copyright (c) 2014: Jonathan Enzinna <jonnyfunfun@gmail.com>
 *
 * This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://www.wtfpl.net/ for more details.
 */


$(document).ready(function() {
    $('.dataTable').dataTable();
});

function confirmPath(p) {
    bootbox.confirm("Are you sure you want to do that?", function(result) {
        if (result) {
            document.location.href=p;
        }
    });
}

$('body').on('hidden.bs.modal', '.modal', function () {
    $(this).removeData('bs.modal');
    $('#modal div.modal-content').html('');
});