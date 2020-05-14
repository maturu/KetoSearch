$(document).on('turbolinks:load', function() {
  if($('#heatmap').length){
    $(window).on('load resize', function() {
      var range = $('#heatmap').width() / 100;
      gen_heatmap(range)
    });

    gen_heatmap($('#heatmap').width() / 100);
    function gen_heatmap(range){
      $('#heatmap').empty();
      var now = new Date();
      now.setMonth(now.getMonth());
      var cal = new CalHeatMap();
      cal.init({
        itemSelector: '#heatmap',
        data: JSON.parse(gon.data),
        cellSize: 12,
        domain: "month",
        subDomain: "day",
        range: Math.ceil(range),
        tooltip: true,
        start: now,
        legendColors: {
            min: "#efefef",
            max: "steelblue",
            empty: "#efefef"
        },
        domainLabelFormat: "%b",
        legend: [1,2,3,4],
        label: {
          position: "top"
        },
        domainDynamicDimension: false,
        domainMargin: 3
      });
    }
  }
});
