/^# Packages using this file: / {
  s/# Packages using this file://
  ta
  :a
  s/ vorbis-tools / vorbis-tools /
  tb
  s/ $/ vorbis-tools /
  :b
  s/^/# Packages using this file:/
}
