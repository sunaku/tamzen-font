require 'tempfile'
require 'rake/clean'

task 'default' => %w[
  .tamzen
  .powerline
  .console
  .portable
  .fontforge
  .screenshots
]

#-----------------------------------------------------------------------------
# index
#-----------------------------------------------------------------------------

directory 'bdf'
file 'bdf/fonts.dir' => ['bdf', '.tamzen', '.powerline'] do
  sh 'mkfontdir', 'bdf'
  sh 'xset', '+fp', File.expand_path('bdf')
  sh 'xset', 'fp', 'rehash'
end
CLOBBER.include 'bdf/Tamzen*.bdf'

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

# Font files are looked up in the specified named git trees.
TAMZEN_BACKPORT_TREES = %w[ Tamsyn-1.6 Tamsyn-1.6-derived Tamsyn-1.9 ]

# For each font filename regexp, the specified names are substituted.
TAMZEN_BACKPORT_MOVES = {
  /8x16/ => '8x17',
}

# For each font filename regexp, the specified glyphs are backported.
TAMZEN_BACKPORT_SPECS = {
  # A B C D E F G H I J K L M N O P Q R S T U V W X Y Z   1 2 3 4 5
  # a b c d e f g h i j k l m n o p q r s t u v w x y z   6 7 8 9 0
  # { } [ ] ( ) < > $ * - + = / # _ % ^ @ \ & | ~ ? ' " ` ! , . ; :

  /(?#for-all-fonts)/ => %w[

      b           h       l m n   p q               y

  ],

  /10x20/ => %w[

                                O   Q
    a b c d e   g h   j   l m n o p q r     u   w   y

  ],

  /8x16/ => %w[

                                O   Q
    a b   d     g h       l m n   p q r     u   w   y

  ],

  /8x15/ => %w[

      b   d       h       l m n   p q r     u   w   y

  ],

  /7x14/ => %w[

      b           h     k l m n   p q   s           y

  ],

  /7x13/ => %w[

      b           h       l m n   p q           w   y

  ],
}

desc 'Build Tamzen fonts.'
file '.tamzen' => ['bdf', __FILE__] do
  require 'git'
  git = Git.open('.')

  # cache to speed up font lookups in loops below
  font_by_tree_and_file = Hash.new do |cache, key|
    tree, file = key
    if blob = git.gtree(tree).blobs[file]
      cache[key] = Font.new(file, blob.contents)
    end
  end

  # target the newest available Tamsyn release tag
  tags = git.tags.map(&:name).grep(/^Tamsyn-/).
    sort_by {|s| s.scan(/\d+/).map(&:to_i) }
  target_tag = tags.last

  # for each BDF font in the target release tag...
  git.gtree(target_tag).blobs.keys.grep(/\.bdf$/).each do |target_file|
    target_font = font_by_tree_and_file[[target_tag, target_file]]
    source_files = TAMZEN_BACKPORT_MOVES.map {|k,v| target_file.sub(k,v) }.
                   unshift(target_file).uniq

    # backport glyphs from previous font versions
    backport_glyphs = TAMZEN_BACKPORT_SPECS.
      select {|regexp, _| regexp =~ target_file }.
      map {|_, glyphs| glyphs }.flatten.uniq.sort

    backport_glyphs.all? do |glyph|
      codepoint = glyph.ord

      TAMZEN_BACKPORT_TREES.any? do |tree|
        source_files.any? do |file|
          source_font = font_by_tree_and_file[[tree, file]] and
          source_char = source_font.chars[codepoint] and
          target_font.chars[codepoint] = source_char # backport!
        end
      end or warn "#{target_file}: glyph #{glyph.inspect} (#{codepoint}) not found"
    end or warn "#{target_file}: not all glyphs were backported; see errors above"

    # save backported font under a different name
    rename = ['Tamsyn', 'Tamzen']
    dst = File.join('bdf', target_file.sub(*rename))
    File.write dst, target_font.to_s.gsub(*rename)
  end

  touch '.tamzen'
end
CLOBBER.include '.tamzen'

desc 'Build Tamzen fonts for Powerline.'
file '.powerline' => ['.tamzen', 'bitmap-font-patcher'] do
  rename = [/Tamzen/, '\&ForPowerline']
  FileList['bdf/Tamzen*.bdf'].exclude('bdf/*Powerline*').each do |src|
    dst = src.sub(*rename)
    target_font =
      # backport powerline glyphs from existing BDF files or patch them in
      if File.exist? powerline_file = "bdf/Powerline#{src[/\d+x\d+/]}.bdf"
        source_font = Font.new(nil, File.read(src))
        powerline_font = Font.new(nil, File.read(powerline_file))
        source_font.chars.merge! powerline_font.chars # backport!
        source_font.props['CHARSET_REGISTRY'] = '"ISO10646"'
        source_font
      else
        IO.popen('bitmap-font-patcher/fontpatcher.py', 'w+') do |patcher|
          # XXX: patcher *only* operates on ISO10646 encoded fonts
          patcher.write File.read(src).gsub('ISO8859', 'ISO10646')
          patcher.close_write
          Font.new(nil, patcher.read.gsub('ISO10646', 'ISO8859'))
        end
      end
    File.write dst, target_font.to_s.gsub(*rename)
  end
  touch '.powerline'
end
CLOBBER.include '.powerline'

file 'bitmap-font-patcher' do
  sh 'hg', 'clone', 'https://bitbucket.org/ZyX_I/bitmap-font-patcher'
end

directory 'psf'
desc 'Build Tamzen fonts for the Linux Console (VT).'
file '.console' => ['psf', '.tamzen', '.powerline'] do
  share = '/usr/share/bdf2psf'
  FileList['bdf/Tamzen*.bdf'].sort.each_slice(2) do |bold, regular|
    dst = regular.gsub('bdf', 'psf').sub(/r(?=\.psf$)/, '')
    Tempfile.open('symbols') do |symbols_file|
      symbols = File.read(regular).scan(/^STARTCHAR (\S+)$/)
      symbols_file.puts symbols
      symbols_file.close
      sh 'bdf2psf', '--fb', "#{regular}+#{bold}",
        "#{share}/standard.equivalents",
        symbols_file.path, symbols.length.to_s, dst
    end
  end
  touch '.console'
end
CLOBBER.include '.console', 'psf'

directory 'pcf'
desc 'Build Tamzen fonts in Portable Compiled Format.'
file '.portable' => ['pcf', '.tamzen', '.powerline'] do
  FileList['bdf/Tamzen*.bdf'].each do |src|
    dst = src.gsub('bdf', 'pcf')
    sh 'bdftopcf', '-o', dst, '-t', src
  end
  touch '.console'
end
CLOBBER.include '.portable', 'pcf'

FONTFORGE_FORMATS = [
  'dfont',    # Apple bitmap only sfnt (dfont)
  'otb',      # X11 bitmap only sfnt (otb)
  'fon',      # Win FON
  'fnt',      # Win FNT
  'pdb',      # Palm OS Bitmap
  'pt3',      # PS Type3 Bitmap
].each do |format|
  # these non-Linux formats make `xset fp rehash` crash!
  # so stow them away into their own separate subfolders
  directory format
end

FONTFORGE_COMMANDS = ['Open($1)'] + FONTFORGE_FORMATS.map do |format|
  "Generate(#{(format + '/').inspect} + $1:t:r + #{('.' + format).inspect})"
end

desc 'Build Tamzen fonts for other platforms.'
file '.fontforge' => ['.tamzen', '.powerline'] + FONTFORGE_FORMATS do
  Tempfile.open(['fontforge', '.pe']) do |script|
    script.puts FONTFORGE_COMMANDS
    script.close
    FileList['bdf/Tamzen*.bdf'].each do |src|
      sh 'fontforge', '-script', script.path, src
    end
  end
  touch '.fontforge'
end
CLOBBER.include '.fontforge', *FONTFORGE_FORMATS

#-----------------------------------------------------------------------------
# screenshots
#-----------------------------------------------------------------------------

directory 'png'
desc 'Build font preview screenshots.'
file '.screenshots' => ['bdf/fonts.dir'] do
  FileList['bdf/Tamzen*.bdf'].each do |bdf|
    Rake::Task[bdf.sub('bdf', 'png').ext('png')].invoke
  end
  touch '.screenshots'
end
CLEAN.include '.screenshots', 'png'

rule %r{^png/.+\.png$} => [->(png){ png.sub('png', 'bdf').ext('bdf') }, 'png',
                           'bdf/fonts.dir'] do |t|

  src = File.basename(t.source)
  dst = t.name

  # translate the BDF font filename into its full X11 font name
  @bdf_to_x11 ||= Hash[File.readlines('bdf/fonts.dir').map(&:split)]

  # assemble sample text for rendering
  lines = [
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ 12345',
    'abcdefghijklmnopqrstuvwxyz 67890',
    '{}[]()<>$*-+=/#_%^@\\&|~?\'"`!,.;:',
    'Illegal1i = oO0          ',
    'The quick brown fox, (..) Hello,',
    'jumps over lazy dog. /__\ World!',
  ]
  width = lines.first.length
  lines.unshift src.center(width)

  # store sample text in a file because it's the easiest way to render
  sample_text_file = Tempfile.open('screenshot')
  sample_text_file.write lines.join(?\n)
  sample_text_file.close

  # render sample text using the source font to the destination image
  sh 'xterm',
    '-fg', 'black',
    '-bg', 'white',
    '-T', src,
    '-font', @bdf_to_x11.fetch(src),
    '-geometry', "#{lines.first.length}x#{lines.length}",
    '-e', [
      'tput civis',                              # hide the cursor
      "cat #{sample_text_file.path.inspect}",    # show sample text
      "import -window $WINDOWID #{dst.inspect}", # take a screenshot
    ].join(' && ')
end
