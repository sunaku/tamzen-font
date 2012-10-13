require 'rake/clean'

fonts_dir = 'fonts.dir'
file fonts_dir => 'Tamzen.rb' do |t|
  ruby t.prerequisites[0]
  sh 'mkfontdir'
  sh 'xset', '+fp', Dir.pwd
  sh 'xset', 'fp', 'rehash'
end
CLOBBER.include '*.bdf', fonts_dir

rule '.png' => ['.bdf', fonts_dir] do |t|
  @bdf_to_x11 ||= Hash[File.readlines(fonts_dir).map(&:split)]
  sh 'convert',
    '-font', @bdf_to_x11[t.source],
    'label:' + [
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ 12345',
      'abcdefghijklmnopqrstuvwxyz 67890',
      '{}[]()<>$*-+=/#_\%^@\\\\&|~?\'"`!,.;:',
      "Illegal1i = oO0  #{t.source}",
    ].join("\n"),
    '-bordercolor', 'white',
    '-border', '5',
    '-strip',
    t.name
end
CLEAN.include '*.png'

task :default => fonts_dir do
  for png in FileList['*.bdf'].ext('png')
    Rake::Task[png].invoke
  end
end
