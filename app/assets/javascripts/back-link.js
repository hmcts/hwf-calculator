;(function (global) {
    'use strict';

    var $ = global.jQuery;
    var GOVUK = global.GOVUK || {};
    var Calculator = global.Calculator || {};

    function BackLink () {
        var self = this;

        self.init = function() {
            $(document).on('click', 'a[data-behavior=back_link]', onBackLinkClick);
        };

        function onBackLinkClick(event) {
            event.preventDefault();
            window.history.back();
            return false;
        }
    }

    Calculator.BackLink = BackLink;
    global.BackLink = BackLink;
    $(document).ready(function() {
        var backLink = new BackLink();
        backLink.init();
    });
})(window);
