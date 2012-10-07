#-----------------------------------------------------------------------------
# specification
#-----------------------------------------------------------------------------

BACKPORTS = [
  # backport the given CHARACTER at the given WEIGHT from the given VERSIONS
  # (try them all, one by one, until one of them has the specified character)
  {character: 'g', weight: /Medium/, versions: ['v1.6']},
  {character: 'h', weight: /Medium/, versions: ['v1.6']},
  {character: 'm', weight: /Medium/, versions: ['v1.6']},
  {character: 'l', weight: //,       versions: ['v1.6']},
  {character: 'w', weight: //,       versions: ['v1.6']},
  {character: 'y', weight: //,       versions: ['v1.6']},
]

#-----------------------------------------------------------------------------
# implementation
#-----------------------------------------------------------------------------

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
      props.map {|*a| a.join(' ') }.join(?\n), ?\n,
      chars.values,
      @tail
    ].join
  end
end

require 'grit'
repo = Grit::Repo.new('.')
trees = Hash.new {|h,k| h[k] = repo.tree(k) }
trees['v1.9'].blobs.each do |blob|
  if blob.name.end_with? '.bdf'
    begin
      font = Font.new(blob)

      # delete empty glyphs except space (32) and non-breaking space (160)
      font.chars.each do |code, char|
        if char =~ /BITMAP\n(?:00\n)+ENDCHAR/ && code != 32 && code != 160
          font.chars.delete code
        end
      end

      # backport characters from older versions of the font
      BACKPORTS.each do |backport|
        code = backport[:character].ord
        if font.props['WEIGHT_NAME'] =~ backport[:weight]
          backport[:versions].any? do |version|
            if old_blob = trees[version] / font.file
              old_font = Font.new(old_blob)
              font.chars[code] = old_font.chars[code]
              true
            end
          end or raise "versions #{backport[:versions]} lack #{font.file}"
        end
      end

      # output the modified font under a different name
      rename = ['Tamsyn', 'Tamzen']
      File.write font.file.sub(*rename), font.to_s.gsub(*rename)

    rescue => error
      warn "#{$0}: could not fork #{blob.name} because #{error}"
    end
  end
end
