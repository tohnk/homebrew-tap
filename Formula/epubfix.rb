class Epubfix < Formula
  desc "A CLI tool to fix and repair EPUB files"
  homepage "https://github.com/tohnk/epubfix"
  url "https://github.com/tohnk/epubfix/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "b0e28a18e6968c501f3466a43544641dcb80ea6120de63cb37517359e433a007"
  license "MIT" # Update if your repo uses a different license (e.g. "Apache-2.0")

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Simple check that the binary executes
    assert_match "epubfix", shell_output("#{bin}/epubfix --help")
  end
end