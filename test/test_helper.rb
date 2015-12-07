require 'coverage'
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
    LOGS << [klass.name, method_name.to_s, before, after]
  end
end

Minitest::Runnable.singleton_class.send :prepend, MinitestCoverage