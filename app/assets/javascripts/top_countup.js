$(function(){
        let $count1 = $('#count1'),
            $count2 = $('#count2'),
            $count3 = $('#count3');
        countUp(0, window.themes, 500, $count1);
        countUp(0, window.all_answers, 800, $count2);
        countUp(0, window.all_favorites, 1100, $count3);
        function countUp (start, stop, duration, element){
            $({percent: start}).animate({percent: stop},{
                duration : duration,
                progress : function(){
                    element.text(Math.round(this.percent));
                }
            });
        }
});