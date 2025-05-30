(function ($) {

  "use strict";

  // Collapse the navbar when a link is clicked (bootstrap behavior)
  $('.navbar-collapse a').on('click', function () {
    $(".navbar-collapse").collapse('hide');
  });

  // Smooth scroll only if the link is a hash link (starts with "#")
  $('.smoothscroll').on('click', function (e) {
    const href = $(this).attr('href');

    if (href && href.startsWith('#')) {
      e.preventDefault();

      const elWrapped = $(href);
      if (elWrapped.length) {
        const header_height = $('.navbar').height();

        scrollToDiv(elWrapped, header_height);
      }
    }
  });

  function scrollToDiv(element, navheight) {
    const offset = element.offset();
    const offsetTop = offset.top;
    const totalScroll = offsetTop - navheight;

    $('html, body').animate({
      scrollTop: totalScroll
    }, 300);
  }

  // Timeline active scroll logic
  $(window).on('scroll', function () {
    function isScrollIntoView(elem) {
      const docViewTop = $(window).scrollTop();
      const docViewBottom = docViewTop + $(window).height();
      const elemTop = $(elem).offset().top;
      const elemBottom = elemTop + $(window).height() * 0.5;

      if (elemBottom <= docViewBottom && elemTop >= docViewTop) {
        $(elem).addClass('active');
      } else {
        $(elem).removeClass('active');
      }

      const mainTimeline = $('#vertical-scrollable-timeline')[0];
      if (mainTimeline) {
        const timelineBottom = mainTimeline.getBoundingClientRect().bottom - $(window).height() * 0.5;
        $(mainTimeline).find('.inner').css('height', timelineBottom + 'px');
      }
    }

    const timelineItems = $('#vertical-scrollable-timeline li');
    timelineItems.each(function () {
      isScrollIntoView(this);
    });
  });

})(window.jQuery);
