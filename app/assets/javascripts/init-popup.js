// JavaScript Document

      $(document).ready(function() {
        $('.popup-with-form').magnificPopup({
          type: 'inline',
          preloader: false,
          focus: '#username',

          // When elemened is focused, some mobile browsers in some cases zoom in
          // It looks not nice, so we disable it:
          callbacks: {
            beforeOpen: function() {
              if($(window).width() < 700) {
                this.st.focus = false;
              } else {
                this.st.focus = '#username';
              }
            }
          }
        });
      });