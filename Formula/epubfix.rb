class Epubfix < Formula
  desc "A CLI tool to fix and repair EPUB files"
  homepage "https://github.com/tohnk/epubfix"
  url "https://github.com/tohnk/epubfix/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "181d2cf2fc1db88a0ac3fb646947270cab33303ca4d1f8494555ca70814601cc"
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
