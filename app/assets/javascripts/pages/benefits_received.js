;(function (global) {
    'use strict';

    var $ = global.jQuery;
    var GOVUK = global.GOVUK || {};
    var Calculator = global.Calculator || {};

    function BenefitsReceivedPage () {
        var self = this;

        self.init = function() {
            initListenersForCheckboxes();
            updateCheckboxesState();
        };

        function initListenersForCheckboxes() {
            $('.multiple-choice input[type=checkbox]').on('click change', updateCheckboxesState);
        }

        function updateCheckboxesState() {
            var checked = $('.multiple-choice input[type=checkbox]:checked').toArray().map(function(n){ return n.value; });
            if(checked.length == 0) {
                enableAllCheckboxes();
            } else {
                if(checked.indexOf('none') ==-1 && checked.indexOf('dont_know') == -1) {
                    disableSpecialCheckboxes();
                    enableBenefitsCheckboxes();
                } else {
                    enableSpecialCheckboxes();
                    disableBenefitsCheckboxes();
                }
            }
        }

        function disableSpecialCheckboxes() {
            $('input[type=checkbox][value=none],input[type=checkbox][value=dont_know]').prop('disabled', true);
        }

        function enableSpecialCheckboxes() {
            $('input[type=checkbox][value=none],input[type=checkbox][value=dont_know]').prop('disabled', false);
        }

        function enableAllCheckboxes() {
            $('input[type=checkbox]').prop('disabled', false);
        }

        function enableBenefitsCheckboxes() {
            $('input[type=checkbox][value!=none][value!=dont_know]').prop('disabled', false);
        }

        function disableBenefitsCheckboxes() {
            $('input[type=checkbox][value!=none][value!=dont_know]').prop('disabled', true);
        }
    }


    BenefitsReceivedPage.prototype.init = function () {
      this.init();
    };


    Calculator.BenefitsReceivedPage = BenefitsReceivedPage;
    global.Calculator = Calculator;
})(window);
