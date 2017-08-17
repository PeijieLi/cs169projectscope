/**
 * Created by stevenwuyinze on 3/22/17.
 */

function parseChartParams(JSONStr) {
    var paramMap = JSONStr;
    var chartParams = {
        chart: {
            type: paramMap['chartType']
        },
        title: {
            text: paramMap['titleText']
        },
        series: paramMap['data']
    };
    return chartParams;
}

function drawMetricCharts(containerID, metric_sample) {
    var JSONStr = JSON.parse(metric_sample.image);
    var char_type =JSONStr['chartType'];
    $('#'+containerID).attr('metric_sample', metric_sample.id);
    if(char_type === 'd3') {
        story_transition(containerID, JSONStr);
    } else if (char_type === 'point_estimation') {
        var new_data = {data: concat_arrays(JSONStr.data.data, JSONStr.data.series)};
        stacked_bar(containerID, new_data, JSONStr.data.series);
    } else if (char_type === 'github_pr') {
        github_pr(containerID, JSONStr);
    } else if (char_type === 'gauge') {
        gauge(containerID, JSONStr);
    } else if (char_type === 'pivotal_tracker') {
        pivotal_tracker(containerID, JSONStr);
    } else if (char_type === 'code_climate') {
        index_score(containerID, JSONStr.data.GPA, 0.0, 4.0);
    } else if (char_type === 'test_coverage') {
        index_score(containerID, JSONStr.data.coverage, 0.0, 100.0)
    } else if (char_type === 'pull_requests') {
        pull_requests(containerID, JSONStr.data);
    } else if (char_type === 'travis_ci') {
        travis_ci(containerID, JSONStr.data);
    } else if (char_type === 'github_files') {
        github_files(containerID, JSONStr);
        // stacked_bar(containerID, JSONStr, ['model', 'view', 'controller', 'test', 'db', 'other']);
    } else if (char_type === 'github_flow') {
        bar_chart(containerID, JSONStr.data);
    } else if (char_type === 'tracker_velocity') {
        stacked_bar(containerID, JSONStr, ['unscheduled', 'unstarted', 'started', 'finished', 'delivered', 'accepted', 'rejected'])
    } else if (char_type === 'point_distribution') {
        var new_data = {data: concat_arrays(JSONStr.data.data, JSONStr.data.series)};
        stacked_bar(containerID, new_data, JSONStr.data.series);
    } else if (char_type === 'slack') {
        var new_data = {data: concat_arrays(JSONStr.data.data, JSONStr.data.series)};
        stacked_bar(containerID, new_data, JSONStr.data.series);
    } else if (char_type === 'tracker_velocity_v2') {
        velocity(containerID, metric_sample);
    } else if (char_type === 'point_distribution_v2') {
        bar_chart(containerID, JSONStr.data);
    } else if (char_type === 'story_overall_v2') {
        story_overall(containerID, JSONStr.data);
    } else if (char_type === 'code_climate_v2') {
        index_score(containerID, metric_sample.score.toPrecision(3), 0.0, 4.0);
    } else if (char_type === 'test_coverage_v2') {
        index_score(containerID, metric_sample.score.toPrecision(3), 0.0, 100.0);
    }
    else {
        // Highcharts.chart(containerID, parseChartParams(JSONStr));
        console.log(metric_sample);
    }
}

function drawSeriesCharts(containerID, metric_samples) {
    var JSONStr = JSON.parse(metric_samples[0].image);
    score_series(containerID, metric_samples);
}

function drawDataNotFound(containerID) {
    d3.select('#' + containerID)
        .append('div')
        .style('width', '100%')
        .html('Not Found');
}

function concat_arrays(data, series) {
    if (series.length !== data.length) {
        return data
    } else {
        var new_data = {};
        data.forEach(function (d, i) {
            new_data[series[i]] = d;
        });
        return new_data;
    }
}

function to_array(input_dict) {
    var prev = undefined;
    var result = [];
    for (var key in input_dict) {
        input_dict[key].sort(function(a, b) {
            if (a.occurred_at < b.occurred_at) return -1;
            if (a.occurred_at > b.occurred_at) return 1;
            return 0;
        }).forEach(function(d, i) {
            if (prev !== undefined) {
                result.push([prev, d]);
            }
            prev = d;
        });
        prev = undefined;
    }
    return result;
}
