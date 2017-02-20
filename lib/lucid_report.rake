desc 'Rake task to build a lucid report'
task :lucid_report, [:json_path, :report_path] do |t, args|
  args.with_defaults(:json_path => nil, :report_path => 'lucid-report')
  options = {:json_path => args.json_path, :report_path => args.report_path}
  LucidReport.build_report(options)
end
