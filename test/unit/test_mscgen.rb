require_relative '../helper'
require 'mscfiddle/msc_gen'

class TestMscGen < Minitest::Test
  GOOD = 'msc {
  Browser, "HTTP-Server", Livereload, Filesystem, Guard;
  |||;
  Browser => "HTTP-Server" [label = "GET /"];
  "HTTP-Server" => Filesystem [label = "Read /index.html"];
  "HTTP-Server" => Browser [label = "HTML with hook"];
  Browser => Browser [label = "Execute hook"];
  Browser => Livereload [label = "Register Web Socket"];
  Filesystem box Filesystem [label = "Waiting for change"],
  |||;
  |||;
  Filesystem => Guard [label = "index.html changed"];
  Guard => Livereload [label = "Trigger reload"];
  Livereload => Browser [label = "Trigger reload"];
  Browser => "HTTP-Server" [label = "GET /"];
  }'

  def test_good
    svg = MscFiddle::MscGen.new(GOOD).to_svg
    refute_empty(svg)
  end

  def test_bad
    err = assert_raises(MscFiddle::MscGen::RenderingError) { MscFiddle::MscGen.new("hoppla\n").to_svg }
    refute_nil(err)
    assert_match 'syntax error', err.message
  end
end
