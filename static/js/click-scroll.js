// jquery-click-scroll
// by syamsul 'isul' Arifin — cleaned to avoid navigation issues

$(document).ready(function () {
    var sectionArray = [1, 2, 3, 4, 5];

    // Default nav link state
    $('.navbar-nav .nav-item .nav-link:link').addClass('inactive');
    $('.navbar-nav .nav-item .nav-link').eq(0).addClass('active').removeClass('inactive');

    // Scroll handler – only once, not per section
    $(document).on('scroll', function () {
        var docScroll = $(document).scrollTop() + 1;

        sectionArray.forEach(function (value, index) {
            var section = $('#section_' + value);
            if (section.length) {
                var offsetTop = section.offset().top - 75;
                if (docScroll >= offsetTop) {
                    $('.navbar-nav .nav-item .nav-link').removeClass('active').addClass('inactive');
                    $('.navbar-nav .nav-item .nav-link').eq(index).addClass('active').removeClass('inactive');
                }
            }
        });
    });

    // Smooth scroll only for internal anchors (href starting with "#")
    $('.click-scroll').on('click', function (e) {
        const href = $(this).attr('href');
        if (href.startsWith('#')) {
            e.preventDefault();
            const target = $(href);
            if (target.length) {
                const offsetTop = target.offset().top - 75;
                $('html, body').animate({ scrollTop: offsetTop }, 300);
            }
        }
        // else let it proceed normally (external or page-changing links)
    });
});
