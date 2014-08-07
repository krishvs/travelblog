/**
 * Main JS file for Gamma
 */

/*globals jQuery, document */
(function ($) {
    "use strict";

    $(document).ready(function(){

        // Tooltip init
        tooltipInit();

        // Init the posts
        postInit();

        var header = $('.navbar'),
            content = $('.content');



        content.waypoint(function(direction) {
            header.toggleClass('navbar-transparent');
        });

    });


// Init bootstrap tooltip
function tooltipInit() {
    $('[data-toggle]').tooltip();
}

function postInit() {
    // Set lead paragraphs
    $('.post-body p:first-child').addClass('lead');

    // Set feature image
    var featured = $('.featured-image').find('img').attr('src');
    if (featured) {
        $('.post-header').css('backgroundImage','url('+featured+')');
        $('#footer').css('backgroundImage','url('+featured+')');
    };
}

}(jQuery));
