require "formula"

# Please only update to versions that are published on PyPi as there are too
# many releases for us to update to every single one:
# https://pypi.python.org/pypi/youtube_dl
class YoutubeDl < Formula
  homepage "http://rg3.github.io/youtube-dl/"
  url "https://yt-dl.org/downloads/2015.01.15.1/youtube-dl-2015.01.15.1.tar.gz"
  sha256 "33ca4587ada5fb57646d3ff32f8502ec5f2573043cbd9ce634305e299fb22a17"

  bottle do
    cellar :any
    sha1 "021b18db55f95f6becc61ee2b2cfdf3737610d86" => :yosemite
    sha1 "577f2f71c4234ccaf2e88205040c7bd6f6205c51" => :mavericks
    sha1 "d41a56798f802eb902e107b81af3d6e7d8088c1c" => :mountain_lion
  end

  head do
    url "https://github.com/rg3/youtube-dl.git"
    depends_on "pandoc" => :build
  end

  depends_on "rtmpdump" => :optional

  def install
    system "make", "PREFIX=#{prefix}"
    bin.install "youtube-dl"
    man1.install "youtube-dl.1"
    bash_completion.install "youtube-dl.bash-completion"
    zsh_completion.install "youtube-dl.zsh" => "_youtube-dl"
  end

  def caveats
    "To use post-processing options, `brew install ffmpeg`."
  end

  test do
    system "#{bin}/youtube-dl", "--simulate", "http://www.youtube.com/watch?v=he2a4xK8ctk"
  end
end
