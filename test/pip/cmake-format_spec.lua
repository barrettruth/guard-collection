describe('cmake-format', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('cmake-format', 'cmake', {
      [[cmake_minimum_required(VERSION 3.10)]],
      [[project(test)]],
      [[add_executable(test main.cpp)]],
    })
    assert.are.same({
      [[cmake_minimum_required(VERSION 3.10)]],
      [[project(test)]],
      [[add_executable(test main.cpp)]],
    }, formatted)
  end)
end)
