{
    "widgets": [
        {
            "height": 10,
            "width": 9,
            "y": 10,
            "x": 14,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ { "expression": "m1 - m2", "label": "Post-With-Media", "id": "e1", "region": "us-east-1" } ],
                    [ { "expression": "m1 - m3", "label": "Post-Not-Fraud", "id": "e2", "region": "us-east-1" } ],
                    [ { "expression": "m5 - m4", "label": "Post-Fraud-Media-Only", "id": "e3", "region": "us-east-1" } ],
                    [ { "expression": "m6 - m4", "label": "Post-Fraud-Text-Only", "id": "e4", "region": "us-east-1" } ],
                    [ { "expression": "100 * m4 / m1", "label": "% Fraud-Both", "id": "e5", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "100 * e3 / m1", "label": "% Fraud-Media-Only", "id": "e6", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "100 * e4 / m1", "label": "% Fraud-Text-Only", "id": "e7", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "100 * e3 / e1", "label": "% Fraud-Media-In-Post-With-Media", "id": "e8", "region": "us-east-1", "visible": false } ],
                    [ "${namespace}", "Post-Processed", { "region": "us-east-1", "id": "m1" } ],
                    [ ".", "Post-Text-Only", { "region": "us-east-1", "id": "m2" } ],
                    [ ".", "Post-Is-Fraud", { "region": "us-east-1", "id": "m3" } ],
                    [ ".", "Post-Fraud-Both", { "region": "us-east-1", "id": "m4" } ],
                    [ ".", "Post-Fraud-Media", { "region": "us-east-1", "id": "m5" } ],
                    [ ".", "Post-Fraud-Text", { "region": "us-east-1", "id": "m6" } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "title": "RawMetrics",
                "period": 1,
                "stat": "Sum",
                "yAxis": {
                    "left": {
                        "label": "1 second sum",
                        "showUnits": false
                    }
                }
            }
        },
        {
            "height": 10,
            "width": 6,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ { "expression": "m1 - m2", "label": "Post-With-Media", "id": "e1", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m1 - m3", "label": "Post-Not-Fraud", "id": "e2", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m5 - m4", "label": "Post-Fraud-Media-Only", "id": "e3", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m6 - m4", "label": "Post-Fraud-Text-Only", "id": "e4", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "100 * m4 / m1", "label": "% Fraud-Both", "id": "e5", "region": "us-east-1", "color": "#7f7f7f" } ],
                    [ { "expression": "100 * e3 / m1", "label": "% Fraud-Media-Only", "id": "e6", "region": "us-east-1", "color": "#d62728" } ],
                    [ { "expression": "100 * e4 / m1", "label": "% Fraud-Text-Only", "id": "e7", "region": "us-east-1", "color": "#ff7f0e" } ],
                    [ { "expression": "100 * e3 / e1", "label": "% Fraud-Media-In-Post-With-Media", "id": "e8", "region": "us-east-1", "visible": false } ],
                    [ "${namespace}", "Post-Processed", { "region": "us-east-1", "id": "m1", "visible": false } ],
                    [ ".", "Post-Text-Only", { "region": "us-east-1", "id": "m2", "visible": false } ],
                    [ ".", "Post-Is-Fraud", { "region": "us-east-1", "id": "m3", "visible": false } ],
                    [ ".", "Post-Fraud-Both", { "region": "us-east-1", "id": "m4", "visible": false } ],
                    [ ".", "Post-Fraud-Media", { "region": "us-east-1", "id": "m5", "visible": false } ],
                    [ ".", "Post-Fraud-Text", { "region": "us-east-1", "id": "m6", "visible": false } ]
                ],
                "view": "timeSeries",
                "stacked": true,
                "region": "us-east-1",
                "title": "FraudRatioStacked",
                "period": 1,
                "stat": "Sum",
                "yAxis": {
                    "left": {
                        "label": "Percentage",
                        "showUnits": false
                    }
                }
            }
        },
        {
            "height": 10,
            "width": 2,
            "y": 0,
            "x": 6,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ { "expression": "m1 - m2", "label": "Post-With-Media", "id": "e1", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m1 - m3", "label": "Post-Not-Fraud", "id": "e2", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m5 - m4", "label": "Post-Fraud-Media-Only", "id": "e3", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m6 - m4", "label": "Post-Fraud-Text-Only", "id": "e4", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "100 * m4 / m1", "label": "% Fraud-Both", "id": "e5", "region": "us-east-1", "color": "#7f7f7f" } ],
                    [ { "expression": "100 * e3 / m1", "label": "% Fraud-Media-Only", "id": "e6", "region": "us-east-1", "color": "#d62728" } ],
                    [ { "expression": "100 * e4 / m1", "label": "% Fraud-Text-Only", "id": "e7", "region": "us-east-1", "color": "#ff7f0e" } ],
                    [ { "expression": "100 * e3 / e1", "label": "% Fraud-Media-In-Post-With-Media", "id": "e8", "region": "us-east-1", "visible": false } ],
                    [ "${namespace}", "Post-Processed", { "region": "us-east-1", "id": "m1", "visible": false } ],
                    [ ".", "Post-Text-Only", { "region": "us-east-1", "id": "m2", "visible": false } ],
                    [ ".", "Post-Is-Fraud", { "region": "us-east-1", "id": "m3", "visible": false } ],
                    [ ".", "Post-Fraud-Both", { "region": "us-east-1", "id": "m4", "visible": false } ],
                    [ ".", "Post-Fraud-Media", { "region": "us-east-1", "id": "m5", "visible": false } ],
                    [ ".", "Post-Fraud-Text", { "region": "us-east-1", "id": "m6", "visible": false } ]
                ],
                "view": "singleValue",
                "stacked": true,
                "region": "us-east-1",
                "title": "FraudRatioValues",
                "period": 1,
                "stat": "Sum"
            }
        },
        {
            "height": 10,
            "width": 6,
            "y": 0,
            "x": 8,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "${namespace}", "Post-Fraud-Both", { "region": "us-east-1", "id": "m4", "color": "#7f7f7f" } ],
                    [ { "expression": "m5 - m4", "label": "Post-Fraud-Media-Only", "id": "e3", "region": "us-east-1", "color": "#ff7f0e" } ],
                    [ { "expression": "m6 - m4", "label": "Post-Fraud-Text-Only", "id": "e4", "region": "us-east-1", "color": "#d62728" } ],
                    [ { "expression": "m1 - m2", "label": "Post-With-Media", "id": "e1", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m1 - m3", "label": "Post-Not-Fraud", "id": "e2", "region": "us-east-1", "color": "#2ca02c" } ],
                    [ { "expression": "100 * m4 / m1", "label": "% Fraud-Both", "id": "e5", "region": "us-east-1", "color": "#7f7f7f", "visible": false } ],
                    [ { "expression": "100 * e3 / m1", "label": "% Fraud-Media-Only", "id": "e6", "region": "us-east-1", "color": "#d62728", "visible": false } ],
                    [ { "expression": "100 * e4 / m1", "label": "% Fraud-Text-Only", "id": "e7", "region": "us-east-1", "color": "#ff7f0e", "visible": false } ],
                    [ { "expression": "100 * e3 / e1", "label": "% Fraud-Media-In-Post-With-Media", "id": "e8", "region": "us-east-1", "visible": false } ],
                    [ "${namespace}", "Post-Processed", { "region": "us-east-1", "id": "m1", "visible": false } ],
                    [ ".", "Post-Text-Only", { "region": "us-east-1", "id": "m2", "visible": false } ],
                    [ ".", "Post-Is-Fraud", { "region": "us-east-1", "id": "m3", "visible": false } ],
                    [ ".", "Post-Fraud-Media", { "region": "us-east-1", "id": "m5", "visible": false } ],
                    [ ".", "Post-Fraud-Text", { "region": "us-east-1", "id": "m6", "visible": false } ]
                ],
                "view": "pie",
                "stacked": true,
                "region": "us-east-1",
                "title": "FraudPostsPie",
                "period": 1,
                "stat": "Sum",
                "setPeriodToTimeRange": true,
                "labels": {
                    "visible": true
                }
            }
        },
        {
            "height": 10,
            "width": 5,
            "y": 0,
            "x": 14,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "${namespace}", "Post-Fraud-Both", { "region": "us-east-1", "id": "m4", "color": "#7f7f7f" } ],
                    [ { "expression": "m5 - m4", "label": "Post-Fraud-Media-Only", "id": "e3", "region": "us-east-1", "color": "#ff7f0e" } ],
                    [ { "expression": "m6 - m4", "label": "Post-Fraud-Text-Only", "id": "e4", "region": "us-east-1", "color": "#d62728" } ],
                    [ { "expression": "m1 - m2", "label": "Post-With-Media", "id": "e1", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m1 - m3", "label": "Post-Not-Fraud", "id": "e2", "region": "us-east-1", "color": "#2ca02c" } ],
                    [ { "expression": "100 * m4 / m1", "label": "% Fraud-Both", "id": "e5", "region": "us-east-1", "color": "#7f7f7f", "visible": false } ],
                    [ { "expression": "100 * e3 / m1", "label": "% Fraud-Media-Only", "id": "e6", "region": "us-east-1", "color": "#d62728", "visible": false } ],
                    [ { "expression": "100 * e4 / m1", "label": "% Fraud-Text-Only", "id": "e7", "region": "us-east-1", "color": "#ff7f0e", "visible": false } ],
                    [ { "expression": "100 * e3 / e1", "label": "% Fraud-Media-In-Post-With-Media", "id": "e8", "region": "us-east-1", "visible": false } ],
                    [ "${namespace}", "Post-Processed", { "region": "us-east-1", "id": "m1", "visible": false } ],
                    [ ".", "Post-Text-Only", { "region": "us-east-1", "id": "m2", "visible": false } ],
                    [ ".", "Post-Is-Fraud", { "region": "us-east-1", "id": "m3", "visible": false } ],
                    [ ".", "Post-Fraud-Media", { "region": "us-east-1", "id": "m5", "visible": false } ],
                    [ ".", "Post-Fraud-Text", { "region": "us-east-1", "id": "m6", "visible": false } ]
                ],
                "view": "timeSeries",
                "stacked": true,
                "region": "us-east-1",
                "title": "AllStacked",
                "period": 1,
                "stat": "Sum",
                "setPeriodToTimeRange": true,
                "labels": {
                    "visible": true
                },
                "yAxis": {
                    "left": {
                        "label": "1 second sum",
                        "showUnits": false
                    }
                }
            }
        },
        {
            "height": 10,
            "width": 4,
            "y": 0,
            "x": 19,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "${namespace}", "Post-Processed", { "region": "us-east-1", "id": "m1" } ],
                    [ { "expression": "m1 - m3", "label": "Post-Not-Fraud", "id": "e2", "region": "us-east-1", "color": "#2ca02c", "period": 1 } ],
                    [ "${namespace}", "Post-Fraud-Both", { "region": "us-east-1", "id": "m4", "color": "#7f7f7f" } ],
                    [ { "expression": "m5 - m4", "label": "Post-Fraud-Media-Only", "id": "e3", "region": "us-east-1", "color": "#ff7f0e", "period": 1 } ],
                    [ { "expression": "m6 - m4", "label": "Post-Fraud-Text-Only", "id": "e4", "region": "us-east-1", "color": "#d62728", "period": 1 } ],
                    [ { "expression": "m1 - m2", "label": "Post-With-Media", "id": "e1", "region": "us-east-1", "visible": false, "period": 1 } ],
                    [ { "expression": "100 * m4 / m1", "label": "% Fraud-Both", "id": "e5", "region": "us-east-1", "color": "#7f7f7f", "visible": false, "period": 1 } ],
                    [ { "expression": "100 * e3 / m1", "label": "% Fraud-Media-Only", "id": "e6", "region": "us-east-1", "color": "#d62728", "visible": false, "period": 1 } ],
                    [ { "expression": "100 * e4 / m1", "label": "% Fraud-Text-Only", "id": "e7", "region": "us-east-1", "color": "#ff7f0e", "visible": false, "period": 1 } ],
                    [ { "expression": "100 * e3 / e1", "label": "% Fraud-Media-In-Post-With-Media", "id": "e8", "region": "us-east-1", "visible": false, "period": 1 } ],
                    [ "${namespace}", "Post-Text-Only", { "region": "us-east-1", "id": "m2", "visible": false } ],
                    [ ".", "Post-Is-Fraud", { "region": "us-east-1", "id": "m3", "visible": false } ],
                    [ ".", "Post-Fraud-Media", { "region": "us-east-1", "id": "m5", "visible": false } ],
                    [ ".", "Post-Fraud-Text", { "region": "us-east-1", "id": "m6", "visible": false } ]
                ],
                "view": "singleValue",
                "stacked": true,
                "region": "us-east-1",
                "title": "Values",
                "period": 1,
                "stat": "Sum",
                "setPeriodToTimeRange": true,
                "labels": {
                    "visible": true
                },
                "sparkline": false
            }
        },
        {
            "height": 10,
            "width": 8,
            "y": 10,
            "x": 0,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ { "expression": "m1 - m2", "label": "Post-With-Media", "id": "e1", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m1 - m3", "label": "Post-Not-Fraud", "id": "e2", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m5 - m4", "label": "Post-Fraud-Media-Only", "id": "e3", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "m6 - m4", "label": "Post-Fraud-Text-Only", "id": "e4", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "100 * m4 / m1", "label": "% Fraud-Both", "id": "e5", "region": "us-east-1", "color": "#7f7f7f" } ],
                    [ { "expression": "100 * e3 / m1", "label": "% Fraud-Media-Only", "id": "e6", "region": "us-east-1", "color": "#d62728" } ],
                    [ { "expression": "100 * e4 / m1", "label": "% Fraud-Text-Only", "id": "e7", "region": "us-east-1", "color": "#ff7f0e" } ],
                    [ { "expression": "100 * e3 / e1", "label": "% Fraud-Media-In-Post-With-Media", "id": "e8", "region": "us-east-1", "visible": false } ],
                    [ { "expression": "100 * m3 / m1", "label": "% Fraud", "id": "e9", "region": "us-east-1", "color": "#ffbb78" } ],
                    [ "${namespace}", "Post-Processed", { "region": "us-east-1", "id": "m1", "visible": false } ],
                    [ ".", "Post-Text-Only", { "region": "us-east-1", "id": "m2", "visible": false } ],
                    [ ".", "Post-Is-Fraud", { "region": "us-east-1", "id": "m3", "visible": false } ],
                    [ ".", "Post-Fraud-Both", { "region": "us-east-1", "id": "m4", "visible": false } ],
                    [ ".", "Post-Fraud-Media", { "region": "us-east-1", "id": "m5", "visible": false } ],
                    [ ".", "Post-Fraud-Text", { "region": "us-east-1", "id": "m6", "visible": false } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "title": "FraudRatio",
                "period": 1,
                "stat": "Sum",
                "yAxis": {
                    "left": {
                        "label": "Percentage",
                        "showUnits": false
                    }
                }
            }
        },
        {
            "height": 10,
            "width": 6,
            "y": 10,
            "x": 8,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "${namespace}", "Post-Fraud-Both", { "region": "us-east-1", "id": "m4", "color": "#7f7f7f", "visible": false } ],
                    [ { "expression": "m5 - m4", "label": "Post-Fraud-Media-Only", "id": "e3", "region": "us-east-1", "color": "#ff7f0e", "visible": false } ],
                    [ { "expression": "m6 - m4", "label": "Post-Fraud-Text-Only", "id": "e4", "region": "us-east-1", "color": "#d62728", "visible": false } ],
                    [ { "expression": "m1 - m2", "label": "Post-With-Media", "id": "e1", "region": "us-east-1", "color": "#8c564b" } ],
                    [ { "expression": "m1 - m3", "label": "Post-Not-Fraud", "id": "e2", "region": "us-east-1", "color": "#2ca02c", "visible": false } ],
                    [ { "expression": "100 * m4 / m1", "label": "% Fraud-Both", "id": "e5", "region": "us-east-1", "color": "#7f7f7f", "visible": false } ],
                    [ { "expression": "100 * e3 / m1", "label": "% Fraud-Media-Only", "id": "e6", "region": "us-east-1", "color": "#d62728", "visible": false } ],
                    [ { "expression": "100 * e4 / m1", "label": "% Fraud-Text-Only", "id": "e7", "region": "us-east-1", "color": "#ff7f0e", "visible": false } ],
                    [ { "expression": "100 * e3 / e1", "label": "% Fraud-Media-In-Post-With-Media", "id": "e8", "region": "us-east-1", "visible": false } ],
                    [ "${namespace}", "Post-Processed", { "region": "us-east-1", "id": "m1", "visible": false } ],
                    [ ".", "Post-Text-Only", { "region": "us-east-1", "id": "m2" } ],
                    [ ".", "Post-Is-Fraud", { "region": "us-east-1", "id": "m3", "visible": false } ],
                    [ ".", "Post-Fraud-Media", { "region": "us-east-1", "id": "m5", "visible": false } ],
                    [ ".", "Post-Fraud-Text", { "region": "us-east-1", "id": "m6", "visible": false } ]
                ],
                "view": "pie",
                "stacked": true,
                "region": "us-east-1",
                "title": "TextOnlyRatio",
                "period": 1,
                "stat": "Sum",
                "setPeriodToTimeRange": true,
                "labels": {
                    "visible": true
                }
            }
        }
    ]
}