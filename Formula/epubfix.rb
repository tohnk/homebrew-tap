class Epubfix < Formula
  desc "A CLI tool to fix and repair EPUB files"
  homepage "https://github.com/tohnk/epubfix"
  url "https://github.com/tohnk/epubfix/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "4e016b5fed445f1b1c3a53daa4b380a2e55a89fcd235164e9c28f5047728c384"
  license "MIT"

  # 1. Removed depends_on "rust" => :build

  def install
    # 2. Inject your user's cargo path into superenv's PATH
    cargo_bin = "#{ENV["HOME"]}/.cargo/bin"
    ENV.prepend_path "PATH", cargo_bin

    # 3. Verify cargo is available before proceeding
    unless quiet_system "#{cargo_bin}/cargo", "--version"
      odie "Cargo not found in #{cargo_bin}. Please install rustup first."
    end

    # 4. Execute cargo install using your system rustup toolchain
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "epubfix", shell_output("#{bin}/epubfix --help")
  end
end
