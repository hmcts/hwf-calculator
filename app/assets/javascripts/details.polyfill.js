;(function (global) {
    'use strict';

    var $ = global.jQuery;
    var GOVUK = global.GOVUK || {};
    var Calculator = global.Calculator || {};

    function DetailsPolyfill () {
        var self = this;
        var _nextId = 0;
        self.init = function() {
            if(checkSupport()) {
                return;
            }
            $(document).on('turbolinks:load', addDetailsPolyfillClass);
            $(document).on('turbolinks:load', addAria);
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
            updateAriaState(details);
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

        function addAria() {
            $('details').each(function() {
                var details, summary, content;
                details = $(this);
                content = details.children(':not(summary)').first();
                summary = details.children('summary').first();
                ensureContentHasId(content);
                addAriaToDetails(details, summary, content);
                updateAriaState(details);
                setTabIndex(summary);
            });
        }

        function ensureContentHasId(content) {
            if(content.attr('id') === undefined) {
                content.attr('id', nextId());
            }
        }

        function addAriaToDetails(details, summary, content) {
            details.attr('role', 'group');
            summary.attr('role', 'button');
            summary.attr('aria-controls', content.attr('id'));
        }

        function updateAriaState(details) {
            var summary, content;
            summary = details.children('summary').first();
            content = details.children(':not(summary)').first();
            if(details.attr('open')) {
                summary.attr('aria-expanded', true);
                content.attr('aria-hidden', false);
            } else {
                summary.attr('aria-expanded', false);
                content.attr('aria-hidden', true);
            }
        }

        function setTabIndex(summary) {
            summary.attr('tabindex', '0');

        }

        function nextId() {
            _nextId += 1;
            return 'polyfill-id-' + _nextId;

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
