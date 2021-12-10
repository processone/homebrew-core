class Csvprintf < Formula
  desc "Command-line utility for parsing CSV files"
  homepage "https://github.com/archiecobbs/csvprintf"
  url "https://github.com/archiecobbs/csvprintf/archive/1.3.0.tar.gz"
  sha256 "f15737526f0505f0a26dbdd7799f7f3acc950001c64b18a5b233b8b0fd301b0c"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a0deb73adb1572880c61657134b72e178905b24523cf95554e1743ee9f1e02c2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ea130e438188f6e4a1d772d371c2d1c8136e0a8c4f78be7ec6b318ed22ba7d35"
    sha256 cellar: :any_skip_relocation, monterey:       "d3ec11cb1b89680e8bfb76d6ccf9ed9922b02d2c113e98e837dd02f1a807a309"
    sha256 cellar: :any_skip_relocation, big_sur:        "22721ae04799a69f22502e084131297ab50bcb7ea7ee9008e2af4bf77a6a92e1"
    sha256 cellar: :any_skip_relocation, catalina:       "d2530b77936aa91b7e5cc904c241dc4a1a947a0c398e54911fb4040a8b6c812c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "34fe20b34ade273df7d26b1ffe86f0173a4cee029c03ad515aff2c6aa5e65129"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  uses_from_macos "libxslt"

  # Fix for missing 'u_char', remove in next version
  patch do
    url "https://github.com/archiecobbs/csvprintf/commit/c8798ed8.patch?full_index=1"
    sha256 "94142117ec45922d8f6aa001ef17421e76600f761689e096015448fd3424f301"
  end

  def install
    ENV.append "LDFLAGS", "-liconv" if OS.mac?

    system "./autogen.sh"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "Fred Smith\n",
                 pipe_output("#{bin}/csvprintf -i '%2$s %1$s\n'", "Last,First\nSmith,Fred\n")
  end
end
