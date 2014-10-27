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

class Font < Struct.new(:file, :props, :chars)
  def initialize file, contents
    head, *body, @tail = contents.split(/(?=\nSTARTCHAR|\nENDFONT)/)
    props = Hash[head.lines.map {|s| s.chomp.split(' ', 2) }.reject(&:empty?)]
    chars = Hash[body.map {|s| [Integer(s[/ENCODING (\d+)/, 1]), s] }]
    super file, props, chars

    # delete empty glyphs except space (32) and non-breaking space (160)
    chars.each do |code, char|
      if char =~ /BITMAP\n(?:0+\n)+ENDCHAR/ && code != 32 && code != 160
        chars.delete code
      end
    end
  end

  def to_s
    props['CHARS'] = chars.length
    [
      props.map {|*a| a.join(' ') }.join(?\n), ?\n,
      chars.values,
      @tail, ?\n
    ].join
  end
end

TAMZEN_FONT_BACKPORTS = [
  # backport the given GLYPH at the given WEIGHT FROM the given versions (try
  # them, in sequence, until the specified glyph is found) INTO the given font
# { glyph: 'S', weight: //,       from: ['v1.6-derived', 'v1.6'], into: // },
  { glyph: 'U', weight: /Medium/, from: ['v1.6-derived', 'v1.6'], into: // },
# { glyph: 'f', weight: //,       from: ['v1.6-derived', 'v1.6'], into: // },
  { glyph: 'g', weight: /Bold/,   from: ['v1.6-derived', 'v1.6'], into: // },
  { glyph: 'g', weight: /Medium/, from: ['v1.6-derived', 'v1.6'], into: // },
  { glyph: 'h', weight: /Medium/, from: ['v1.6-derived', 'v1.6'], into: // },
  { glyph: 'm', weight: /Medium/, from: ['v1.6-derived', 'v1.6'], into: // },
  { glyph: 'l', weight: //,       from: ['v1.6-derived', 'v1.6'], into: // },
  { glyph: 'w', weight: //,       from: ['v1.6-derived', 'v1.6'], into: // },
  { glyph: 'y', weight: //,       from: ['v1.6-derived', 'v1.6'], into: // },
]

desc 'Build Tamzen fonts.'
task :tamzen do
  require 'git'
  git = Git.open('.')
  git.gtree('v1.9').blobs.each do |file, blob|
    if file.end_with? '.bdf'
      font = Font.new(file, blob.contents)

      # backport characters from older versions of the font
      TAMZEN_FONT_BACKPORTS.each do |backport|
        if font.file =~ backport[:into]
          code = backport[:glyph].ord
          if font.props['WEIGHT_NAME'] =~ backport[:weight]
            backport[:from].any? do |version|
              if old_blob = git.gtree(version).blobs[font.file]
                old_font = Font.new(font.file, old_blob.contents)
                if old_char = old_font.chars[code]
                  font.chars[code] = old_char
                  true
                end
              end
            end or warn "#{font.file} backport failed: #{backport}"
          end
        end
      end

      # output the modified font under a different name
      rename = ['Tamsyn', 'Tamzen']
      File.write font.file.sub(*rename), font.to_s.gsub(*rename)
    end
  end
end

desc 'Build Tamzen fonts for Powerline.'
task :powerline => [:tamzen, 'bitmap-font-patcher'] do
  rename = [/Tamzen/, '\&ForPowerline']
  FileList['Tamzen[0-9]*.bdf'].each do |src|
    dst = src.sub(*rename)
    IO.popen('python bitmap-font-patcher/fontpatcher.py', 'w+') do |patcher|
      patcher.write File.read(src).gsub(*rename).gsub('ISO8859', 'ISO10646')
      patcher.close_write
      File.write dst, Font.new(dst, patcher.read)
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
    '-T', t.source,
    '-font', @bdf_to_x11[t.source],
    '-geometry', "#{lines.first.length}x#{lines.length}",
    '-e', [
      'tput civis',                                 # hide the cursor
      "cat #{sample_text_file.path.inspect}",       # show sample text
      "import -window $WINDOWID #{t.name.inspect}", # take a screenshot
    ].join(' && ')
end
