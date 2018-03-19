;(function (global) {
    'use strict';

    var $ = global.jQuery;
    var GOVUK = global.GOVUK || {};
    var Calculator = global.Calculator || {};

    function DetailsPolyfill () {
        var self = this;

        self.init = function() {
            if(checkSupport()) {
                return;
            }
            $(document).on('turbolinks:load', addDetailsPolyfillClass);
            $(document).on('click', 'details > summary', onSummaryClick);
        };

        function addDetailsPolyfillClass() {
            $('details').addClass('details-polyfill');
        };

        function onSummaryClick(event, a) {
            var details;
            event.preventDefault();
            details = $(event.currentTarget).closest('details');
            toggleDetails(details);
            return false;
        }

        function toggleDetails(details) {
            var open = details.attr('open');
            if(open) {
                details.removeAttr('open');
            } else {
                details.attr('open', 'open');
            }
        }

        /*
         * Checks for support for `<details>`
         */

        function checkSupport () {
            var el = document.createElement('details');
            return 'boolean' === typeof el.open;
        }
    }

    Calculator.DetailsPolyfill = DetailsPolyfill;
    global.DetailsPolyfill = DetailsPolyfill;
    $(document).ready(function() {
        var detailsPolyfill = new DetailsPolyfill();
        detailsPolyfill.init();
    });
})(window);
