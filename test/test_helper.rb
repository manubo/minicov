require 'coverage'
require 'byebug'
require 'json'
Coverage.start
require 'minitest/autorun'

module MinitestCoverage
  LOGS = []

  Minitest.after_run {
    File.open('run_log.json', 'w') { |f| f.write JSON.dump(LOGS) }
  }

  def run_one_method(klass, method_name, reporter)
    before = Coverage.peek_result
    super(klass, method_name, reporter)
    after = Coverage.peek_result
    coverage = {}
    after.each do |key, lines|
      next unless /minitest-coverage\/(lib|test)\// =~ key
      if before[key]
        result = after[key].zip(before[key]).map { |a, b| a.to_i - b.to_i }
      else
        result = lines
      end
      coverage[key] = result if result.any? { |count| count > 0 }
    end
    LOGS << [klass.name, method_name.to_s, coverage]
  end
end

Minitest::Runnable.singleton_class.send :prepend, MinitestCoverage