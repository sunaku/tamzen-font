require 'rake/clean'

task :default => :screenshots
CLOBBER.include 'fonts.dir', '*.bdf'
CLEAN.include '*.png'

#-----------------------------------------------------------------------------
# index
#-----------------------------------------------------------------------------

file 'fonts.dir' => [:tamzen, :powerline] do
  sh 'mkfontdir'
  sh 'xset', '+fp', Dir.pwd
  sh 'xset', 'fp', 'rehash'
end

#-----------------------------------------------------------------------------
# fonts
#-----------------------------------------------------------------------------

desc 'Build Tamzen fonts.'
task :tamzen => 'Tamzen.rb' do
  ruby 'Tamzen.rb' # this will generate Tamzen[0-9]*.bdf files
end

desc 'Build Tamzen fonts for Powerline.'
task :powerline => [:tamzen, 'bitmap-font-patcher'] do
  FileList['Tamzen[0-9]*.bdf'].each do |src|
    IO.popen('python bitmap-font-patcher/fontpatcher.py', 'w+') do |patcher|
      rename = [/Tamzen/, '\&ForPowerline']
      patcher.write File.read(src).gsub(*rename).gsub('ISO8859', 'ISO10646')
      patcher.close_write
      File.write src.sub(*rename), patcher.read
    end
  end
end

file 'bitmap-font-patcher' do
  sh 'hg', 'clone', 'https://bitbucket.org/ZyX_I/bitmap-font-patcher'
end

#-----------------------------------------------------------------------------
# screenshots
#-----------------------------------------------------------------------------

desc 'Build font preview screenshots.'
task :screenshots => 'fonts.dir' do
  FileList['*.bdf'].ext('png').each do |png|
    Rake::Task[png].invoke
  end
end

rule '.png' => ['.bdf', 'fonts.dir'] do |t|
  @bdf_to_x11 ||= Hash[File.readlines('fonts.dir').map(&:split)]
  sh 'convert',
    '-font', @bdf_to_x11[t.source],
    'label:' + [
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ 12345',
      'abcdefghijklmnopqrstuvwxyz 67890',
      '{}[]()<>$*-+=/#_\%^@\\\\&|~?\'"`!,.;:',
      "Illegal1i = oO0  #{
        # show powerline symbols in screenshots for powerline fonts
        # https://powerline.readthedocs.org/en/latest/fontpatching.html#glyph-table
        if t.name.include? 'Powerline'
          "  \uE0A0 \uE0A1 \uE0A2 \uE0B0 \uE0B1 \uE0B2 \uE0B3\n   "
        end
      }#{ t.source }",
    ].join("\n"),
    '-bordercolor', 'white',
    '-border', '5',
    '-strip',
    t.name
end
