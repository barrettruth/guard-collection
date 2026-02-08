describe('rustfmt_nightly', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('rustfmt_nightly', 'rust', {
      [[use std::{collections::HashMap, collections::HashSet};]],
      [[fn    main() {]],
      [[let   var:usize=1;]],
      [[          println!("{var}");]],
      [[}]],
    })
    assert.are.same({
      [[use std::collections::{HashMap, HashSet};]],
      [[fn main() {]],
      [[    let var: usize = 1;]],
      [[    println!("{var}");]],
      [[}]],
    }, formatted)
  end)
end)
