INDEX = 'fonts.dir'
FONTS = FileList['*.bdf']

file INDEX => 'Tamzen.rb' do |t|
  ruby t.prerequisites[0]
  sh 'mkfontdir'
end

FONTS.each do |bdf|
  png = bdf.ext('png')
  file png => [bdf, INDEX] do
    sh 'convert',
      '-font', `fgrep #{bdf} #{INDEX} | cut -d' ' -f2`.chomp,
      'label:' + [
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ 12345',
        'abcdefghijklmnopqrstuvwxyz 67890',
        '{}[]()<>$*-+=/#_%^@\\\\&|~?\'"`!,.;:',
        "Illegal1i = oO0  #{bdf}",
      ].join("\n"),
      '-bordercolor', 'white',
      '-border', '5',
      '-strip',
      png
  end
  task :render => png
end

task :default => [INDEX, :render]
