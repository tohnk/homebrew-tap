class Epubfix < Formula
  desc "A CLI tool to fix and repair EPUB files"
  homepage "https://github.com/tohnk/epubfix"
  url "https://github.com/tohnk/epubfix/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "4e016b5fed445f1b1c3a53daa4b380a2e55a89fcd235164e9c28f5047728c384"
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
