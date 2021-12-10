class Jello < Formula
  include Language::Python::Virtualenv

  desc "Filter JSON and JSON Lines data with Python syntax"
  homepage "https://github.com/kellyjonbrazil/jello"
  url "https://files.pythonhosted.org/packages/39/35/cb9eacaab1d7845fc5f2dd086e31dc980cfeec563a4e070f980ecc6c025a/jello-1.5.0.tar.gz"
  sha256 "62aff5a06761457ac72285a377cdfd7f8555fe1c791e7c9e7783711266bb4f30"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "55573f8a05b8350f9b33be56dd3525f052e06c4e79a32e5c6065ec6ba5bc7368"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "55573f8a05b8350f9b33be56dd3525f052e06c4e79a32e5c6065ec6ba5bc7368"
    sha256 cellar: :any_skip_relocation, monterey:       "5998cfc1dbd12015b6d38afd4b6ec31a41cf4eb16a844e263e4ac80088bdce80"
    sha256 cellar: :any_skip_relocation, big_sur:        "5998cfc1dbd12015b6d38afd4b6ec31a41cf4eb16a844e263e4ac80088bdce80"
    sha256 cellar: :any_skip_relocation, catalina:       "5998cfc1dbd12015b6d38afd4b6ec31a41cf4eb16a844e263e4ac80088bdce80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "22d0856d7579b6634ee3e249315372f2c7a1272dd52917b7b50ffe66607f39ba"
  end

  depends_on "python@3.10"

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/b7/b3/5cba26637fe43500d4568d0ee7b7362de1fb29c0e158d50b4b69e9a40422/Pygments-2.10.0.tar.gz"
    sha256 "f398865f7eb6874156579fdf36bc840a03cab64d1cde9e93d68f46a425ec52c6"
  end

  def install
    virtualenv_install_with_resources
    man1.install "man/jello.1"
  end

  test do
    assert_equal "1\n", pipe_output("#{bin}/jello _.foo", "{\"foo\":1}")
  end
end
