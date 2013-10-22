require 'tempfile'
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
  # translate the BDF font filename into its full X11 font name
  @bdf_to_x11 ||= Hash[File.readlines('fonts.dir').map(&:split)]

  # assemble sample text for rendering
  lines = [
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ 12345',
    'abcdefghijklmnopqrstuvwxyz 67890',
    '{}[]()<>$*-+=/#_%^@\\&|~?\'"`!,.;:',
    #
    # visit the following URL for Unicode code points of powerline symbols
    # https://powerline.readthedocs.org/en/latest/fontpatching.html#glyph-table
    #
    "Illegal1i = oO0    \uE0A0 \uE0A1 \uE0A2 \uE0B0 \uE0B1 \uE0B2 \uE0B3"
  ]
  width = lines.first.length
  lines.unshift t.source.center(width)

  # store sample text in a file because it's the easiest way to render
  sample_text_file = Tempfile.open('screenshot')
  sample_text_file.write lines.join(?\n)
  sample_text_file.close

  # render sample text using the source font to the destination image
  sh 'xterm',
    '-fg', 'black',
    '-bg', 'white',
    '-font', @bdf_to_x11[t.source],
    '-geometry', "#{lines.first.length}x#{lines.length}",
    '-e', [
      'tput civis',                                 # hide the cursor
      "cat #{sample_text_file.path.inspect}",       # show sample text
      "import -window $WINDOWID #{t.name.inspect}", # take a screenshot
    ].join(' && ')
end
