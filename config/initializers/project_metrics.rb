ProjectMetrics.configure do
  add_metric :project_metric_code_climate
  # add_metric :project_metric_github
  add_metric :project_metric_slack
  # add_metric :project_metric_pivotal_tracker
  # add_metric :project_metric_slack_trends
  # add_metric :project_metric_story_transition
  add_metric :project_metric_point_estimation
  add_metric :project_metric_story_overall
  # add_metric :project_metric_collective_overview
  add_metric :project_metric_test_coverage
  add_metric :project_metric_pull_requests
  add_metric :project_metric_travis_ci
  add_metric :project_metric_github_files
  add_metric :project_metric_github_flow
  add_metric :project_metric_tracker_velocity
  add_metric :project_metric_point_distribution

  add_hierarchy report: [{ title: :github,
                            contents: [] },
                          { title: :pivotal_tracker,
                            contents: %I[pivotal_tracker story_transition] }]
  add_hierarchy metric: [%I[code_climate test_coverage pull_requests github_files github_flow],
                         %I[travis_ci tracker_velocity point_estimation story_overall point_distribution]]
end

METRIC_NAMES = {
  code_climate: 'Code Climate',
  test_coverage: 'Test Coverage',
  pull_requests: 'PR Status',
  github_files: 'Edited Lines',
  github_flow: 'Commit Frequency',
  travis_ci: 'Build Status',
  tracker_velocity: 'Velocity',
  point_estimation: 'Story Points',
  story_overall: 'Story Assignment',
  point_distribution: 'Finished Work'
}