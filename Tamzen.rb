class Font < Struct.new(:file, :props, :chars)
  def initialize blob
    head, *body, @tail = blob.data.split(/(?=\nSTARTCHAR|\nENDFONT)/)
    props = Hash[head.lines.map {|s| s.chomp.split(' ', 2) }]
    chars = Hash[body.map {|s| [Integer(s[/ENCODING (\d+)/, 1]), s] }]
    super blob.name, props, chars
  end

  def to_s
    props['CHARS'] = chars.length
    [
      props.map {|*a| a.join(' ') }.join("\n"), "\n",
      chars.values,
      @tail
    ].join
  end
end

require 'grit'
GIT = Grit::Repo.new('.')
GIT.tree('v1.8').blobs.each do |blob|
  if blob.name =~ /\.bdf$/
    font = Font.new(blob)

    # delete empty glyphs except space and non-breaking space
    font.chars.each do |code, char|
      if code != 32 && code != 160 && char =~ /BITMAP\n(?:00\n)+ENDCHAR/
        font.chars.delete code
      end
    end

    # backport characters from older versions of the font
    [
      ['g'.ord, /Medium/, 'v1.6'],
      ['h'.ord, /Medium/, 'v1.6'],
      ['m'.ord, /Medium/, 'v1.6'],
      ['l'.ord, //,       'v1.6'],
      ['w'.ord, //,       'v1.6'],
      ['y'.ord, //,       'v1.6'],
    ].
    each do |code, weight, version|
      if font.props['WEIGHT_NAME'] =~ weight
        old = Font.new(GIT.tree(version)/font.file)
        font.chars[code] = old.chars[code]
      end
    end

    # output the modified font under a different name
    rename = ['Tamsyn', 'Tamzen']
    File.write font.file.sub(*rename), font.to_s.gsub(*rename)
  end
end
